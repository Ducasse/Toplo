Class {
	#name : #ToPropertyWriter,
	#superclass : #Object,
	#traits : 'TToPropertyWriter',
	#classTraits : 'TToPropertyWriter classTrait',
	#instVars : [
		'property',
		'value',
		'animation',
		'eventClass',
		'supplement'
	],
	#category : 'Toplo-Theme-Skin'
}

{ #category : #accessing }
ToPropertyWriter >> animation [

	^ animation
]

{ #category : #accessing }
ToPropertyWriter >> animation: aPropertyAnimation [

	animation := aPropertyAnimation.
	animation ifNil: [ ^ self ].
	animation property: self property
]

{ #category : #testing }
ToPropertyWriter >> canReceiveEvent: aLookEvent [ 

	^ self eventClass = aLookEvent class 
]

{ #category : #testing }
ToPropertyWriter >> canReplace: anotherWriter [

	^ false
]

{ #category : #accessing }
ToPropertyWriter >> eventClass [

	^ eventClass ifNil: [ eventClass := ToInstallLookEvent  ]
]

{ #category : #accessing }
ToPropertyWriter >> eventClass: aLookEventClass [

	eventClass := aLookEventClass
]

{ #category : #testing }
ToPropertyWriter >> isSupplement [

	^ self supplement 
]

{ #category : #printing }
ToPropertyWriter >> printOn: aStream [

	super printOn: aStream.
	aStream space.
	self property name printOn: aStream.
	aStream space.
	self eventClass printOn: aStream.
	aStream space.
	self value printOn: aStream
]

{ #category : #accessing }
ToPropertyWriter >> property [

	^ property
]

{ #category : #accessing }
ToPropertyWriter >> property: anObject [

	property := anObject.
	self animation ifNotNil: [ :a | a property: self property ]
]

{ #category : #writing }
ToPropertyWriter >> receiveEvent: aLookEvent [

	| target |
	(self canReceiveEvent: aLookEvent) ifFalse: [ ^ self ].
	target := aLookEvent currentTarget.
	self writeTo: target
]

{ #category : #accessing }
ToPropertyWriter >> supplement [ 

	^ supplement ifNil: [ supplement := false ]
]

{ #category : #accessing }
ToPropertyWriter >> supplement: aBoolean [

	supplement := aBoolean
]

{ #category : #accessing }
ToPropertyWriter >> value [

	^ value
]

{ #category : #accessing }
ToPropertyWriter >> value: aBlockOrObject [

	value := aBlockOrObject
]

{ #category : #operating }
ToPropertyWriter >> valueIn: anElement [

	^ value isClosure
		  ifTrue: [ value value: anElement ]
		  ifFalse: [ value ]
]

{ #category : #operating }
ToPropertyWriter >> valueWriter [

	^ self animation ifNil: [ self property ].
]

{ #category : #'t - property writer - writing' }
ToPropertyWriter >> writeTo: anElement [

	^ self valueWriter write: (self valueIn: anElement) to: anElement
]