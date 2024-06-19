Class {
	#name : #ToCheckableNode,
	#superclass : #ToBarNode,
	#classTraits : 'TToCheckable classTrait',
	#category : #'Toplo-Widget-CheckableBar'
}

{ #category : #accessing }
ToCheckableNode >> checked: aBoolean [

	self holder checked: aBoolean
]

{ #category : #'t - list node' }
ToCheckableNode >> clickEventHandlerClasses [

	^  { ToCheckableNodeEventHandler } 
]

{ #category : #accessing }
ToCheckableNode >> content [ 

	^ self firstChild
]

{ #category : #initialization }
ToCheckableNode >> initialize [

	super initialize.
]

{ #category : #testing }
ToCheckableNode >> isChecked [ 

	^ self holder isChecked
]