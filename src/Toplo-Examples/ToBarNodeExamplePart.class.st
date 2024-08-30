"
I'm part of a larger example. I'm not expected to be opened as a standalone. 

Check `ToSandBox >> example_bar`
"
Class {
	#name : #ToBarNodeExamplePart,
	#superclass : #ToBarNode,
	#instVars : [
		'triplet'
	],
	#category : #'Toplo-Examples-Parts'
}

{ #category : #'instance creation' }
ToBarNodeExamplePart class >> open [

	<script>
	
	self new openInSpace
]

{ #category : #initialization }
ToBarNodeExamplePart >> initialize [ 

	super initialize.
	triplet := ToTripletElement new.
	triplet hMatchParent; vFitContent.
	self addChild: triplet.
	self initializeRemoveButton
]

{ #category : #initialization }
ToBarNodeExamplePart >> initializeRemoveButton [

	| but |
	but := ToButton new.
	but withNullSkin.
	but icon: (ToImage inner: (self iconNamed: #windowClose)).
	but constraintsDo: [ :c | c linear vertical alignCenter ].
	but geometry: BlCircleGeometry new.

	but addEventHandler: (BlEventHandler
			 on: BlClickEvent
			 do: [ :event |
				 event consume.
				 self removeFromBar ]).

	" consume mouseUp/mouseDown to avoid unwanted opening/closing of the popup list element"
	but addEventHandler: (BlEventHandler
			 on: BlMouseDownEvent
			 do: [ :event | event consume ]).
	but addEventHandler: (BlEventHandler
			 on: BlMouseUpEvent
			 do: [ :event | event consume ]).

	but id: #removeButton.
	triplet startElement: but.
	triplet startInterspace: 5
]

{ #category : #accessing }
ToBarNodeExamplePart >> label [

	^ triplet middleElement
]

{ #category : #accessing }
ToBarNodeExamplePart >> label: aLabel [

	triplet middleElement: aLabel
]

{ #category : #initialization }
ToBarNodeExamplePart >> removeFromBar [ 

	self holder barElement dataAccessor removeAt: self holder position
]