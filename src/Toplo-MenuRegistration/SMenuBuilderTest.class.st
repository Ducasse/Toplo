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

{ #category : #todo }
SMenuBuilderTest >> estItemNamedReturnOnlyDirectMenuItem [
	"it is unclear if itemNamed: is different after the collection of item"
]

{ #category : #'tests - item basic properties' }
SMenuBuilderTest >> forTestIcon [
	^ Form fromBinaryStream: self iconStreamString base64Decoded readStream
]

{ #category : #'tests - item basic properties' }
SMenuBuilderTest >> iconStreamString [
	^ 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAABMUlEQVQ4T2NkoBAwgvS/sAr5D6LNi6MZ/v39z/D3LwPD3z8MEPrvf4b3ycFgddgAwoD/DF8ljq/hkV217v/jsCC4BsG5a/+DDPuUjt0QDJPRDQDZyjdz7f9/fxkYvmRhGkKUASBDeKat/U/QAPm1ayX//WV8huwFmL8JGqC0cT3Yr8iB+DIWEhZEeQFkwD3/QEZYGIgvXvf/4vRlDJrJkeAYIRiIIAP+/f2//u8fhsC//xi+/f3NwAUyAAQkjq3BH40wf8qvBRsCjv9nkUGML6zDKjWTwtsIpgPkBIItHVBuAO9fdoawsF8wi17ahAb+//d/HchrRKUDUCwgByIs6WMY8NIq5Pd/BgYW9ECDRSMkf0DzSkkI2HIUFyCbjC3jcE5e++R7brAMshzO6CE2lwMAVKG/Eb0e33UAAAAASUVORK5CYII='
]

{ #category : #'tests - item basic properties' }
SMenuBuilderTest >> return33 [
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
	
	"Pay attention, since parent: is part of the public API for scripting
	parent does not return the parent menu but its name"
	self 
		assert: builder collectedItems first parent 
		equals: #Tools
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

{ #category : #'tests - item basic properties' }
SMenuBuilderTest >> testHelpDeclaration [
	
	| item |
	item := (builder item: #MyOwnCoolTool).
	item help: 'This is the help'.
	self 
		assert: item help 
		equals:  'This is the help'.
]

{ #category : #'tests - item basic properties' }
SMenuBuilderTest >> testIconDeclaration [
	
	| item |
	item := (builder item: #MyOwnCoolTool).
	item icon: self forTestIcon.
	self 
		assert: item icon class 
		equals: Form 
]

{ #category : #'tests - item basic properties' }
SMenuBuilderTest >> testIconNameDeclaration [
	
	| item |
	item := (builder item: #MyOwnCoolTool).
	item iconName: #go.
	self 
		assert: item icon 
		equals: (Smalltalk ui icons iconNamed: #go)
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

{ #category : #'tests - item basic properties' }
SMenuBuilderTest >> testKeyTextDeclaration [
	
	| item |
	item := (builder item: #MyOwnCoolTool).
	item action:  [ (Smalltalk tools toolNamed: #browser) open ].
	self assert: (item action isKindOf: BlockClosure).
]

{ #category : #'tests - item basic properties' }
SMenuBuilderTest >> testLabelDeclaration [
	
	| item |
	item := (builder item: #MyOwnCoolTool).
	self 
		assert: item name 
		equals: 'MyOwnCoolTool'.
		
	self 
		assert: item label 
		equals:  'MyOwnCoolTool'
]

{ #category : #'tests - item basic properties' }
SMenuBuilderTest >> testNameDeclarationIsKeyWhenNotExplicit [
	
	| item |
	item := (builder item: #MyOwnCoolTool).
	item order: 9999.
	self 
		assert: item order 
		equals: 9999
]

{ #category : #'tests - item basic properties' }
SMenuBuilderTest >> testOrderDeclaration [
	
	| item |
	item := (builder item: #MyOwnCoolTool).
	item order: 9999.
	self 
		assert: item order 
		equals: 9999
]

{ #category : #'tests - item basic properties' }
SMenuBuilderTest >> testTargetSelector [

	| item |
	item := (builder item: #Screenshot)
		parent: #System;
		target: self class new;
		selector: #return33;
		label: 'Screenshot';
		iconName: #smallScreenshot.
	self assert: item selector equals: #return33.
	self assert: item target class equals: self class.
	
]

{ #category : #'tests - item basic properties' }
SMenuBuilderTest >> testWithSeparatorAfter [
	
	| item |
	item := (builder item: #MyOwnCoolTool).
	self deny: item separator.
	item withSeparatorAfter.
	self assert: item separator.

]

{ #category : #'tests - item basic properties' }
SMenuBuilderTest >> testWithSeparatorAtBuilderLevel [

	(builder item: #'Enable all Debug Points')
		parent: #Debug;
		order: -1;
		help: 'Enable all the debug points of the image.';
		action: [ self all do: #enable ].

	(builder item: #'Disable all Debug Points')
		parent: #Debug;
		order: 0;
		help: 'Disable all the debug points of the image.';
		action: [ self all do: #disable ].
	builder withSeparatorAfter.
	
	self assert: (builder itemNamed: #'Disable all Debug Points') separator
]
