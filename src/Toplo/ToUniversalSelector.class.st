Class {
	#name : 'ToUniversalSelector',
	#superclass : 'ToSimpleSelector',
	#category : 'Toplo-Core-Selector',
	#package : 'Toplo',
	#tag : 'Core-Selector'
}

{ #category : 'visiting' }
ToUniversalSelector >> accept: aVisitor [

	aVisitor visitUniversalSelector: self
]