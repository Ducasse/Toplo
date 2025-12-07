Class {
	#name : #SMenuBuilder,
	#superclass : #Object,
	#instVars : [
		'currentRoot',
		'items',
		'resolvedTrees'
	],
	#category : #'Toplo-MenuRegistration-New'
}

{ #category : #visiting }
SMenuBuilder >> accept: aToploVisitor [ 
	
	^ aToploVisitor visitBuilder: self
]

{ #category : #navigating }
SMenuBuilder >> addItem: anItem toParentNamed: aName [

	resolvedTrees do: [ :each |
		each name = aName
			ifTrue: [ anItem parentNode: each. ^ self ]
			ifFalse: [  self halt. "I should look into children " ]
		].
	"here we should report an error because the parent does not exist"
]

{ #category : #accessing }
SMenuBuilder >> collectedItems [
	^ items
]

{ #category : #navigating }
SMenuBuilder >> findDeeplyIn: anItem itemNamed: aString [
	"Return the item that is named, aString, in the argument or nil"
	
	^ anItem findItemNamed: aString
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

{ #category : #navigating }
SMenuBuilder >> resolve [
	"taking a list of items we build a list of trees"
	
	resolvedTrees := self roots.
	"roots are items with a nil parent"
	
	items do: [ :item | 
		item parent ifNotNil: [ :p | self addItemToParentNamed: p ]
		]
]

{ #category : #accessing }
SMenuBuilder >> roots [
	
	^ self items select: [ :each | each parent isNil ]
]

{ #category : #'public scripting API' }
SMenuBuilder >> withSeparatorAfter [
	items ifEmpty: [ ^ self ].
	items last withSeparatorAfter
]
