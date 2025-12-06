Class {
	#name : #SMenuBuilder,
	#superclass : #Object,
	#instVars : [
		'currentRoot',
		'items'
	],
	#category : #'Toplo-MenuRegistration-New'
}

{ #category : #accessing }
SMenuBuilder >> collectedItems [
	^ items
]

{ #category : #initialization }
SMenuBuilder >> initialize [

	super initialize.
	items := OrderedCollection new
]

{ #category : #accessing }
SMenuBuilder >> item: aString [ 
	"Creates and retrun a new item"
	
	| item |
	item := (self newItemNamed: aString).
	items add: item.
	^ item
]

{ #category : #accessing }
SMenuBuilder >> itemNamed: aString [ 
	
	^ items detect: [ :each | each name = aString ] ifNone: [ nil ]
]

{ #category : #'instance creation' }
SMenuBuilder >> newItemNamed: aString [ 
	
	^ SMenuItemSpec new name: aString
]

{ #category : #'instance creation' }
SMenuBuilder >> newSubItem [

	| reg |
	reg := SMenuUserDescription owner: currentRoot.
	currentRoot addItem: reg.
	^ reg
]

{ #category : #accessing }
SMenuBuilder >> parent: aString [ 
	self shouldBeImplemented.
]
