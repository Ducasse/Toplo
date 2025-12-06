Class {
	#name : #SAbstractMenuSpec,
	#superclass : #Object,
	#instVars : [
		'parent',
		'order'
	],
	#category : #'Toplo-MenuRegistration-New'
}

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
