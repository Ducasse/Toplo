Class {
	#name : #SMenuDeclarationVisitor,
	#superclass : #Object,
	#instVars : [
		'menuPane'
	],
	#category : #'Toplo-MenuRegistration-New'
}

{ #category : #visiting }
SMenuDeclarationVisitor >> visitMenu: aMenu [

	self subclassResponsibility
]

{ #category : #visiting }
SMenuDeclarationVisitor >> visitMenuItem: aMenuItem [

	| tmenu|
	tmenu := ToMenuItem new labelText: aMenuItem label.
	tmenu clickAction: aMenuItem action.
	aMenuItem hasIcon ifTrue: [ tmenu iconImage: aMenuItem icon asElement ].
	^ tmenu
	
]
