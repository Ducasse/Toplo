Class {
	#name : #SAbstractMenuSpec,
	#superclass : #Object,
	#instVars : [
		'parent',
		'order',
		'label'
	],
	#category : #'Toplo-MenuRegistration-New'
}

{ #category : #accessing }
SAbstractMenuSpec >> label [
	"Answer the receiver's label"
	^label
]

{ #category : #'public api' }
SAbstractMenuSpec >> label: aString [
	"Set the receiver's label"
	label := aString
]

{ #category : #accessing }
SAbstractMenuSpec >> order [

	^ order
]

{ #category : #'public api' }
SAbstractMenuSpec >> order: anObject [

	order := anObject
]

{ #category : #accessing }
SAbstractMenuSpec >> parent [
	"Pay attention, since parent: is part of the public API for scripting
	parent does not return the parent menu but its name"
	
	^ parent 
]

{ #category : #'public api' }
SAbstractMenuSpec >> parent: aString [

	parent := aString
	
]

{ #category : #printing }
SAbstractMenuSpec >> printOn: aStream [

	super printOn: aStream. 
	aStream << ' ('.
	aStream print: self label.
	aStream << ')'.
]
