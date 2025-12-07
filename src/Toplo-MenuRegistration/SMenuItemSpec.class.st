"
I'm a spec for an item menu. The World menu pragma based registration uses it for now. I'm moved in this package so that later we can decide what to do with it. 
We could probably avoid MenuSpec and just use MenuMorph instead. 
"
Class {
	#name : #SMenuItemSpec,
	#superclass : #SAbstractMenuSpec,
	#instVars : [
		'action',
		'checked',
		'enabled',
		'separator',
		'subMenu',
		'iconFormSet',
		'enabledBlock',
		'keyText',
		'help',
		'name',
		'target',
		'selector'
	],
	#category : #'Toplo-MenuRegistration-New'
}

{ #category : #visiting }
SMenuItemSpec >> accept: aToploVisitor [ 
	^ aToploVisitor visitMenuItem: self
]

{ #category : #accessing }
SMenuItemSpec >> action [
	"Answer the action associated with the receiver"
	^ action ifNil: [ MessageSend new selector: #value ; yourself ]
]

{ #category : #'public api' }
SMenuItemSpec >> action: aMessageSend [
	"Answer the action associated with the receiver"
	action := aMessageSend
]

{ #category : #accessing }
SMenuItemSpec >> checked [
	"Answer whether the receiver is checked"
	^checked
]

{ #category : #accessing }
SMenuItemSpec >> checked: aBool [
	"Indicate whether the receiver is checked"
	checked := aBool
]

{ #category : #accessing }
SMenuItemSpec >> enabled [
	"Answer whether the receiver is enabled"
	^ enabledBlock
		ifNil:[enabled ifNil: [ true ]]
		ifNotNil: [ enabledBlock value ]
]

{ #category : #accessing }
SMenuItemSpec >> enabled: aBool [
	"Indicate whether the receiver is enabled"
	enabled := aBool
]

{ #category : #accessing }
SMenuItemSpec >> enabledBlock [

	^ enabledBlock
]

{ #category : #accessing }
SMenuItemSpec >> enabledBlock: aBlock [

	enabledBlock := aBlock
]

{ #category : #accessing }
SMenuItemSpec >> hasCheckBox [

	^ checked isNotNil
]

{ #category : #testing }
SMenuItemSpec >> hasIcon [
	^ self icon isNotNil
]

{ #category : #accessing }
SMenuItemSpec >> help [
	"Answer the message to get the help texts of this element."
	^ help
]

{ #category : #'public api' }
SMenuItemSpec >> help: aSymbol [
	"Indicate the message to retrieve the help texts of this element."
	help := aSymbol
]

{ #category : #accessing }
SMenuItemSpec >> icon [
	^ self iconFormSet ifNotNil: [ :formSet | formSet asForm ]
]

{ #category : #'public api' }
SMenuItemSpec >> icon: aForm [
	self iconFormSet: (aForm ifNotNil: [ FormSet form: aForm ])
]

{ #category : #accessing }
SMenuItemSpec >> iconFormSet [
	^ iconFormSet
]

{ #category : #accessing }
SMenuItemSpec >> iconFormSet: aFormSet [
	iconFormSet := aFormSet
]

{ #category : #'public api' }
SMenuItemSpec >> iconName: aSymbol [ 
	self icon: (Smalltalk ui icons iconNamed: aSymbol)
]

{ #category : #accessing }
SMenuItemSpec >> keyText [
	^keyText
]

{ #category : #'public api' }
SMenuItemSpec >> keyText: aString [
	keyText := aString
]

{ #category : #accessing }
SMenuItemSpec >> name [
	^ name
]

{ #category : #'public api' }
SMenuItemSpec >> name: anObject [
	name := anObject
]

{ #category : #accessing }
SMenuItemSpec >> selector [

	^ action selector
]

{ #category : #accessing }
SMenuItemSpec >> selector: aSymbol [
	"set the selector for item with an action"
	
	action
		ifNil: [ action := MessageSend new selector: aSymbol ; yourself ]
		ifNotNil: [ action selector: aSymbol ]
]

{ #category : #accessing }
SMenuItemSpec >> separator [
	"Answer whether the receiver should be followed by a separator"
	^separator ifNil: [ false ]
]

{ #category : #accessing }
SMenuItemSpec >> separator: aBool [
	"Indicate whether the receiver should be followed by a separator"
	separator := aBool
]

{ #category : #accessing }
SMenuItemSpec >> subMenu [
	"Answer the receiver's subMenu"
	^subMenu
]

{ #category : #accessing }
SMenuItemSpec >> subMenu: aMenuSpec [
	"Answer the receiver's subMenu"
	subMenu := aMenuSpec
]

{ #category : #accessing }
SMenuItemSpec >> target [

	^ action receiver
]

{ #category : #accessing }
SMenuItemSpec >> target: anObject [
	"set the target for the action"

	"I will not check that anObject is not nil. Let it fails!"
	action
		ifNil: [ action := MessageSend receiver: anObject selector: nil ]
		ifNotNil: [ action receiver: anObject ]

	"I would like to see if I can avoid the itemReceiver sharing. Because two subitms may share the same owner.
	action
		ifNil: [self spec action: (MessageSend receiver: (anObject ifNil: [owner itemReceiver]) selector: nil)]
		ifNotNil: [self spec action receiver: anObject]
	"
		
]

{ #category : #'public api' }
SMenuItemSpec >> withSeparatorAfter [
	self separator: true
]
