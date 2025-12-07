"
I'm a spec for a menu. The World menu pragma based registration uses it for now. I'm moved in this package so that later we can decide what to do with it. 
We could probably avoid MenuSpec and just use MenuMorph instead. 
"
Class {
	#name : #SMenuSpec,
	#superclass : #SAbstractMenuSpec,
	#instVars : [
		'model',
		'items',
		'parentMenu'
	],
	#category : #'Toplo-MenuRegistration-New'
}

{ #category : #'instance creation' }
SMenuSpec class >> withModel: aModel [
	^ self new model: aModel
]

{ #category : #visiting }
SMenuSpec >> accept: aToploVisitor [ 
	^ aToploVisitor visitMenu: self
]

{ #category : #'simple item building' }
SMenuSpec >> add: aString [
	^ self add: aString action: nil
]

{ #category : #'simple item building' }
SMenuSpec >> add: aString action: aMessageSend [
	| item |
	item := self addMenuItem.
	item label: aString translated.
	item action: aMessageSend.
	^item
]

{ #category : #'simple item building' }
SMenuSpec >> add: aString selector: aMessageSend [
	| item |
	item := self addMenuItem.
	item label: aString translated.
	item action: aMessageSend.
	^item
]

{ #category : #'simple item building' }
SMenuSpec >> add: aString selector: aSelector argumentList: anArray [
	^ self add: aString action: (MessageSend receiver: model selector: aSelector arguments: anArray)
]

{ #category : #'simple item building' }
SMenuSpec >> add: aString target: anObject selector: aSelector argumentList: anArray [
	^ self add: aString translated action: (MessageSend receiver: anObject selector: aSelector arguments: anArray)
]

{ #category : #building }
SMenuSpec >> addItem: anItem [
	self items add: anItem
]

{ #category : #'simple item building' }
SMenuSpec >> addList: aList [
	"Add the given items to this menu, where each item is a pair (<string> <actionSelector>).  If an element of the list is simply the symobl $-, add a line to the receiver. The optional third element of each entry, if present, provides balloon help."

	aList
		do: [ :tuple |
			tuple == #-
				ifTrue: [ self addSeparator ]
				ifFalse: [
					| item |
					item := self
								add: tuple first
								target: model
								selector: tuple second
								argumentList: #().
					(tuple size > 2 and: [ tuple third isNotNil ])
						ifTrue: [ item help: tuple third ].
					(tuple size > 3 and: [ tuple fourth isNotNil ])
						ifTrue: [ item icon: (self theme iconNamed: tuple fourth) ] ] ]
]

{ #category : #'simple item building' }
SMenuSpec >> addMenuItem [
	| item |
	item := self newMenuItem.
	self items add: item.
	^item
]

{ #category : #building }
SMenuSpec >> addSeparator [
	self items isEmpty
		ifTrue: [ ^ nil ].
	self items last separator: true
]

{ #category : #initialization }
SMenuSpec >> initialize [ 

	super initialize.
	items := OrderedCollection new. 
]

{ #category : #accessing }
SMenuSpec >> items [
	^ items
]

{ #category : #'simple item building' }
SMenuSpec >> model [
	^ model
]

{ #category : #'simple item building' }
SMenuSpec >> model: anObject [
	model := anObject
]

{ #category : #'simple item building' }
SMenuSpec >> newMenuItem [

	^ SMenuItemSpec new
]
