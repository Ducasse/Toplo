Class {
	#name : #SMenuBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'builder'
	],
	#category : #'Toplo-MenuRegistration-New'
}

{ #category : #todo }
SMenuBuilderTest >> estDefineTwoItemsWithSameNameShouldBeAConflict [
	"we could support anem name and parent but we should then change itenNamed:
	to return a list of item having a name.
	so for a menu should have a unique name"
]

{ #category : #running }
SMenuBuilderTest >> setUp [
	
	builder := SMenuBuilder new
]

{ #category : #'tests - collection' }
SMenuBuilderTest >> testCollectItemWithParent [

	(builder item: #MyOwnCoolTool)
		parent: #Tools.
	self assert: builder collectedItems size equals: 1. 
	
]

{ #category : #'tests - collection' }
SMenuBuilderTest >> testCollectSimpleItemName [

	| item |
	builder item: #MyOwnCoolTool.
	item := builder itemNamed: #MyOwnCoolTool.
	self assert: item name equals: #MyOwnCoolTool
]

{ #category : #'tests - collection' }
SMenuBuilderTest >> testCollectTwoSimpleItems [

	builder item: #MyOwnCoolTool.
	builder item: #MyOwnCoolTool2.
	self assert: builder collectedItems size equals: 2.
]

{ #category : #'tests - collection' }
SMenuBuilderTest >> testItemNamed [

	| item |
	builder item: #MyOwnCoolTool.
	builder item: #MyOwnCoolTool2.
	item := builder itemNamed: #MyOwnCoolTool.
	self assert: item name equals: #MyOwnCoolTool.

	item := builder itemNamed: #MyOwnCoolTool2.
	self assert: item name equals: #MyOwnCoolTool2
]
