Trait {
	#name : #TToLayoutableButton,
	#instVars : [
		'labelFirst'
	],
	#traits : 'TToButton',
	#classTraits : 'TToButton classTrait',
	#category : #'Toplo-Widget-Button'
}

{ #category : #'t - button orientation' }
TToLayoutableButton >> beHorizontal [ 

	self horizontal: true
]

{ #category : #'t - button direction' }
TToLayoutableButton >> beIconFirst [

	self labelFirst: false
]

{ #category : #'t - button presentation' }
TToLayoutableButton >> beLabelFirst [

	self labelFirst: true
]

{ #category : #'t - button direction' }
TToLayoutableButton >> beLeftToRight [

	self layout leftToRight.
	self requestLayout 
]

{ #category : #'t - button direction' }
TToLayoutableButton >> beRightToLeft [

	self layout rightToLeft.
	self requestLayout 
]

{ #category : #'t - button orientation' }
TToLayoutableButton >> beVertical [

	self horizontal: false
]

{ #category : #'t - button orientation' }
TToLayoutableButton >> horizontal [

	^ self layout isHorizontal
]

{ #category : #'t - button orientation' }
TToLayoutableButton >> horizontal: aBoolean [

	aBoolean
		ifTrue: [ self layout beHorizontal ]
		ifFalse: [ self layout beVertical ].
	self requestLayout   
]

{ #category : #'t - button orientation' }
TToLayoutableButton >> isHorizontal [

	^ self horizontal
]

{ #category : #'t - button presentation' }
TToLayoutableButton >> isIconFirst [
	
	^ self isLabelFirst not
]

{ #category : #'t - button presentation' }
TToLayoutableButton >> isLabelFirst [
	
	^ self labelFirst
]

{ #category : #'t - button presentation' }
TToLayoutableButton >> labelFirst [

	^ labelFirst ifNil: [ labelFirst := false ]
]

{ #category : #'t - button presentation' }
TToLayoutableButton >> labelFirst: aBoolean [
	
	labelFirst = aBoolean ifTrue: [ ^ self ].
	labelFirst := aBoolean.
	self privateUpdateChildren 
]

{ #category : #'t - button orientation' }
TToLayoutableButton >> orientation [

	^ self layout orientation
]

{ #category : #'t - button orientation' }
TToLayoutableButton >> orientation: aBlLayoutOrientation [

	self layout orientation: aBlLayoutOrientation.
	self requestLayout 
]

{ #category : #'t - button private' }
TToLayoutableButton >> privateFill [

	| e |
	e := ToElement new id: #fill.
	self isHorizontal
		ifTrue: [ 
			e vExact: 4.
			e hMatchParent ]
		ifFalse: [ 
			e hExact: 4.
			e vMatchParent ].
	^ e
]