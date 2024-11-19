Class {
	#name : #ToMenuNode,
	#superclass : #ToBarNode,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'t - bar node' }
ToMenuNode >> autoDistribute: aBoolean [

	super autoDistribute: aBoolean.
	aBoolean ifTrue: [
		self item constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ] ]
]

{ #category : #'t - bar node' }
ToMenuNode >> item [

	^ self firstChild
]

{ #category : #'t - bar node' }
ToMenuNode >> item: aMenuItem [

	aMenuItem removeFromParent.
	self addChild: aMenuItem
]