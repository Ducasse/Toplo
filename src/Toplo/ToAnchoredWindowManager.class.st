Class {
	#name : 'ToAnchoredWindowManager',
	#superclass : 'Object',
	#instVars : [
		'currentWindow',
		'element',
		'builder',
		'elementEventHandler',
		'windowClosedHandler',
		'positionHook',
		'sizeHook'
	],
	#category : 'Toplo-Core-Window',
	#package : 'Toplo',
	#tag : 'Core-Window'
}

{ #category : 'position hook' }
ToAnchoredWindowManager >> applyPositionHookFromEvent: anEvent [

	self currentWindow ifNil: [ Error signal: 'No current window'. ].
	self currentWindow position: (self positionHook value: anEvent value: self element)
]

{ #category : 'position hook' }
ToAnchoredWindowManager >> applySizeHookFromEvent: anEvent [

	self currentWindow ifNil: [ Error signal: 'No current window' ].
	self sizeHook ifNil: [ ^ self ].
	self currentWindow size: (self sizeHook value: anEvent value: self element)
]

{ #category : 'accessing' }
ToAnchoredWindowManager >> builder [

	^ builder
]

{ #category : 'accessing' }
ToAnchoredWindowManager >> builder: aWindowBuilderValuable [

	builder := aWindowBuilderValuable
]

{ #category : 'window handling' }
ToAnchoredWindowManager >> closeWindow [

	self currentWindow ifNil: [ ^ self ].
	self currentWindow close
]

{ #category : 'accessing' }
ToAnchoredWindowManager >> currentWindow [

	^ currentWindow
]

{ #category : 'accessing' }
ToAnchoredWindowManager >> currentWindow: aWindowElement [

	currentWindow := aWindowElement
]

{ #category : 'initialization' }
ToAnchoredWindowManager >> defaultBuilder [

	^ [ :theWindow :theElement | ]

	
]

{ #category : 'initialization' }
ToAnchoredWindowManager >> defaultPositionHook [

	^ [ :event :theElement| theElement bounds inSpace bounds topLeft ]
]

{ #category : 'initialization' }
ToAnchoredWindowManager >> defaultSizeHook [

	^ nil
]

{ #category : 'accessing' }
ToAnchoredWindowManager >> element [

	^ element
]

{ #category : 'accessing' }
ToAnchoredWindowManager >> element: anElement [

	element ifNotNil: [
		element removeEventHandler: elementEventHandler.
		elementEventHandler := nil ].
	element := anElement.
	element ifNotNil: [
		element addEventHandler: self newElementEventHandler ]
]

{ #category : 'accessing' }
ToAnchoredWindowManager >> elementEventHandler [

	^ elementEventHandler
]

{ #category : 'accessing' }
ToAnchoredWindowManager >> elementEventHandlerClass [

	^ ToAnchorEventHandler 
]

{ #category : 'testing' }
ToAnchoredWindowManager >> hasWindow [

	^ self currentWindow notNil
]

{ #category : 'initialization' }
ToAnchoredWindowManager >> initialize [ 

	super initialize.
	self positionHook: self defaultPositionHook.
	self sizeHook: self defaultSizeHook.
	self builder: self defaultBuilder.

	
]

{ #category : 'accessing' }
ToAnchoredWindowManager >> newElementEventHandler [

	elementEventHandler := self elementEventHandlerClass new.
	elementEventHandler windowManager: self.
	^ elementEventHandler
]

{ #category : 'window handling' }
ToAnchoredWindowManager >> newWindowEvent: anEvent [

	| request |
	self currentWindow ifNotNil: [
		^ Error signal: 'Asking for a window building twice' ].
	self element ifNil: [ ^ Error signal: 'An element is required for building a window' ].
	self builder ifNil: [ ^ Error signal: 'A window builder is required for building a window' ].
	request := self windowRequestClass new
		           sourceEvent: anEvent;
		           yourself.
	self element dispatchEvent: request.
	self currentWindow: (self windowClass new
			 manager: self;
			 yourself).
	builder value: self currentWindow value: request.
	windowClosedHandler := BlEventHandler
		                       on: ToWindowClosedEvent
		                       do: [ self onWindowClosed ].
	self currentWindow addEventHandler: windowClosedHandler.
	^ self currentWindow
]

{ #category : 'window handling' }
ToAnchoredWindowManager >> onWindowClosed [

	self currentWindow removeEventHandler: windowClosedHandler.
	windowClosedHandler := nil.
	currentWindow manager: nil.
	currentWindow := nil
]

{ #category : 'accessing' }
ToAnchoredWindowManager >> positionHook [

	^ positionHook
]

{ #category : 'accessing' }
ToAnchoredWindowManager >> positionHook: aValuable [
	" aValuable takes the event as first argument and the element as second argument. 
	Computes the window position according to the element position "
	
	positionHook := aValuable.
	self currentWindow ifNil: [ ^ self ].
	self applyPositionHookFromEvent: nil
]

{ #category : 'accessing' }
ToAnchoredWindowManager >> sizeHook [
	
	^ sizeHook
]

{ #category : 'accessing' }
ToAnchoredWindowManager >> sizeHook: aValuable [
	
	sizeHook := aValuable.
	self currentWindow ifNil: [  ^self ].
	self applySizeHookFromEvent: nil
]

{ #category : 'accessing' }
ToAnchoredWindowManager >> windowClass [

	^ ToAnchoredWindow 
]

{ #category : 'accessing' }
ToAnchoredWindowManager >> windowRequestClass [

	^ ToWindowRequest 
]