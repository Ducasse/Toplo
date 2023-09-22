Class {
	#name : #ToStyleRule,
	#superclass : #Object,
	#traits : 'TToPropertyWriterHolder + TToStyleRuleHolder',
	#classTraits : 'TToPropertyWriterHolder classTrait + TToStyleRuleHolder classTrait',
	#instVars : [
		'selector',
		'eventClass',
		'writers',
		'subStyleRules'
	],
	#category : #'Toplo-Theme-StyleSheet'
}

{ #category : #'instance creation' }
ToStyleRule class >> selectedWith: aStyleSelector style: aBlock [

	^ self new selectedWith: aStyleSelector style: aBlock
]

{ #category : #'instance creation' }
ToStyleRule class >> selectedWith: aStyleSelector when: anLookEventClass  style: aBlock [

	^ self new
		  selectedWith: aStyleSelector
		  when: anLookEventClass
		  style: aBlock
]

{ #category : #declaring }
ToStyleRule >> addSubRule: aStyleRule [

	aStyleRule selector: (self selector + aStyleRule selector).
	self addStyleRule: aStyleRule
]

{ #category : #testing }
ToStyleRule >> canBeAppliedTo: anElement [

	| engine |
	engine := ToStyleSelectorInterpreter new.
	engine check: self selector on: anElement.
	^ engine result
]

{ #category : #'syntactic sugar' }
ToStyleRule >> event: aLookEventClass [

	self eventClass: aLookEventClass
]

{ #category : #accessing }
ToStyleRule >> eventClass [

	^ eventClass
]

{ #category : #accessing }
ToStyleRule >> eventClass: aLookEventClass [

	eventClass := aLookEventClass
]

{ #category : #accessing }
ToStyleRule >> flattenStyleRules [

	^ Array streamContents: [ :str |
		  str nextPut: self.
		  self styleRules do: [ :sr | str nextPutAll: sr flattenStyleRules ] ]
]

{ #category : #initialization }
ToStyleRule >> initialize [

	super initialize.
	selector := ToUniversalSelector new.
	eventClass := ToInstallLookEvent.
	writers := #(  ).
	subStyleRules := #(  )
]

{ #category : #'property writer' }
ToStyleRule >> property: aProperty value: aValuableOrObject animation: aPropertyAnimation [

	self addWriter: (aProperty
			 when: self eventClass
			 write: aValuableOrObject
			 animation: aPropertyAnimation;
			 yourself)
]

{ #category : #'t - style rule holder - accessing' }
ToStyleRule >> rawStyleRules [

	^ subStyleRules
]

{ #category : #'t - style rule holder - accessing' }
ToStyleRule >> rawStyleRules: aStyleRuleCollection [

	subStyleRules := aStyleRuleCollection
]

{ #category : #'t - property writer holder - accessing' }
ToStyleRule >> rawWriters [

	^ writers
]

{ #category : #'t - property writer holder - accessing' }
ToStyleRule >> rawWriters: aPropertyWriterCollection [

	writers := aPropertyWriterCollection 
]

{ #category : #'syntactic sugar' }
ToStyleRule >> select: aSelector style: aBlock [

	| sub |
	sub := self class new selector: aSelector.
	aBlock value: sub.
	self addSubRule: sub 
]

{ #category : #declaring }
ToStyleRule >> selectedWith: aStyleSelector style: aBlock [

	self selector: aStyleSelector.
	aBlock value: self
	
]

{ #category : #declaring }
ToStyleRule >> selectedWith: aStyleSelector when: anEventClass style: aBlock [

	self eventClass: anEventClass.
	self selector: aStyleSelector.
	aBlock value: self
]

{ #category : #accessing }
ToStyleRule >> selector [

	^ selector
]

{ #category : #accessing }
ToStyleRule >> selector: aStyleSelector [

	selector := aStyleSelector
]

{ #category : #'syntactic sugar' }
ToStyleRule >> supplement: aProperty with: aValuableOrObject [

	self
		when: self eventClass
		supplement: aProperty
		with: aValuableOrObject
]

{ #category : #'syntactic sugar' }
ToStyleRule >> when: aLookEventClass supplement: aProperty with: aValuableOrObject [

	aProperty ifNil: [ ^self ].
	self addWriter: ((aProperty
			  when: aLookEventClass
			  write: aValuableOrObject
			  animation: nil)
			 supplement: true;
			 yourself)
]

{ #category : #'syntactic sugar' }
ToStyleRule >> when: aLookEventClass write: aProperty with: aValuableOrObject [

	self
		when: aLookEventClass
		write: aProperty
		with: aValuableOrObject
		animation: nil
]

{ #category : #'syntactic sugar' }
ToStyleRule >> when: aLookEventClass write: aProperty with: aValuableOrObject animation: aPropertyAnimation [

	aProperty ifNil: [ ^ self ].
	self addWriter: (aProperty
			 when: aLookEventClass
			 write: aValuableOrObject
			 animation: aPropertyAnimation)
]

{ #category : #'syntactic sugar' }
ToStyleRule >> write: aProperty with: aValue [

	self
		when: self eventClass
		write: aProperty
		with: aValue
		animation: nil
]

{ #category : #'syntactic sugar' }
ToStyleRule >> write: aProperty with: aValuableOrObject animation: aPropertyAnimation [

	self
		when: self eventClass
		write: aProperty
		with: aValuableOrObject
		animation: aPropertyAnimation
]