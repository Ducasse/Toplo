Class {
	#name : #ToElementWithContextMenuEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'mouseButton',
		'contextMenu'
	],
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'api - accessing' }
ToElementWithContextMenuEventHandler >> eventsToHandle [

	^ { BlMouseDownEvent }
]

{ #category : #private }
ToElementWithContextMenuEventHandler >> hideContextMenuFor: aWidget [

	contextMenu ifNotNil: [ :m |
		m close.
		contextMenu := nil ]
]

{ #category : #initialization }
ToElementWithContextMenuEventHandler >> initialize [

	super initialize.
	self useSecondaryMouseButton 
]

{ #category : #'api - accessing' }
ToElementWithContextMenuEventHandler >> mouseDownEvent: anEvent [

	anEvent button = mouseButton ifFalse: [ ^ self ].
	self hideContextMenuFor: anEvent currentTarget.
	self
		popupContextMenuFor: anEvent currentTarget 
		event: anEvent
]

{ #category : #private }
ToElementWithContextMenuEventHandler >> popupContextMenuFor: aWidget event: anEvent [

	aWidget dispatchEvent: (ToContextMenuOpenedEvent new
			 widget: aWidget;
			 sourceEvent: anEvent;
			 yourself).
	contextMenu := aWidget contextMenu.
	contextMenu popupEvent: anEvent
]

{ #category : #'api - accessing' }
ToElementWithContextMenuEventHandler >> usePrimaryMouseButton [

	mouseButton := BlMouseButton primary
]

{ #category : #'api - accessing' }
ToElementWithContextMenuEventHandler >> useSecondaryMouseButton [

	mouseButton := BlMouseButton secondary
]