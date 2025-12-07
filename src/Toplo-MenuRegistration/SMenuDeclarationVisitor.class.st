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
SMenuDeclarationVisitor >> visitMenuItem: aMenu [

	self subclassResponsibility
]
