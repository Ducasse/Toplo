Class {
	#name : #SMenuBuilder,
	#superclass : #Object,
	#instVars : [
		'currentRoot',
		'items'
	],
	#category : #'Toplo-MenuRegistration-New'
}

{ #category : #visiting }
SMenuBuilder >> accept: aToploVisitor [ 
	
	^ aToploVisitor visitBuilder: self
]

{ #category : #accessing }
SMenuBuilder >> collectedItems [
	^ items
]

{ #category : #initialization }
SMenuBuilder >> initialize [

	super initialize.
	items := OrderedCollection new
]

{ #category : #'public scripting API' }
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

{ #category : #accessing }
SMenuBuilder >> items [

	^ items
]

{ #category : #'t - menu item' }
SMenuBuilder >> menuPane [
	self shouldBeImplemented.
]

{ #category : #'instance creation' }
SMenuBuilder >> newItemNamed: aString [ 
	
	^ SMenuItemSpec new 
			name: aString;
			label: aString asString; 
			yourself	
]

{ #category : #'instance creation' }
SMenuBuilder >> newSubItem [

	| reg |
	self halt.
	reg := SMenuItemSpec new.
	currentRoot addItem: reg.
	^ reg
]

{ #category : #'public scripting API' }
SMenuBuilder >> withSeparatorAfter [
	items ifEmpty: [ ^ self ].
	items last withSeparatorAfter
]
