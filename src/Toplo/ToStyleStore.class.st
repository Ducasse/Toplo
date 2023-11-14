Class {
	#name : #ToStyleStore,
	#superclass : #Object,
	#instVars : [
		'stampIndex',
		'borderBuilder',
		'styleSheet',
		'textAttributesBuilder'
	],
	#category : 'Toplo-Core-Theme'
}

{ #category : #'adding-removing' }
ToStyleStore >> addStamp: aStyleStamp [

	self stampIndex addProperty: aStyleStamp
]

{ #category : #accessing }
ToStyleStore >> borderBuilder [

	^ borderBuilder ifNil: [ borderBuilder := BlBorderBuilder new ]
]

{ #category : #testing }
ToStyleStore >> hasStamp: aSymbol [

	self stampIndexDo: [ :si | ^ si hasPropertyNamed: aSymbol ].
	^ false
]

{ #category : #accessing }
ToStyleStore >> localStampNamed: aSymbol [

	self stampIndexDo: [ :si | ^ si propertyNamed: aSymbol ].
	^ nil
]

{ #category : #lookup }
ToStyleStore >> lookUpStampNamed: aSymbol from: anElement [
	" first look-up following child-parent association 
	for each element, try first to get the stamp from the localStyleStampIndex 
	then from the elementl styleSheet ifPresent"
	anElement withAllParentsDo: [ :p |
		(p toStyleStore localStampNamed: aSymbol) ifNotNil: [ :t | ^ t ].
		p toStyleStore styleSheet ifNotNil: [ :ss |
			(ss stampNamed: aSymbol) ifNotNil: [ :t | ^ t ] ] ].
	" finally, try to get the stamp from the theme "
	^ anElement toTheme stampNamed: aSymbol
]

{ #category : #'adding-removing' }
ToStyleStore >> removeAllStamps [

	self stampIndexDo: [ :si | si removeAllProperties ] 
]

{ #category : #'adding-removing' }
ToStyleStore >> removeAllStamps: aStyleStampCollection [

	aStyleStampCollection do: [ :s | self removeStamp: s ]
]

{ #category : #'adding-removing' }
ToStyleStore >> removeStamp: aStyleStamp [

	self stampIndexDo: [ :si | si removeProperty: aStyleStamp ]
]

{ #category : #'adding-removing' }
ToStyleStore >> removeStampNamed: aSymbol [

	self stampIndexDo: [ :si | si removePropertyNamed: aSymbol ]
]

{ #category : #'adding-removing' }
ToStyleStore >> removeStampNamed: aSymbol ifAbsent: anAbsentBlock [

	self stampIndexDo: [ :si |
		si removePropertyNamed: aSymbol ifAbsent: anAbsentBlock.
		^ self ].
	anAbsentBlock value
]

{ #category : #accessing }
ToStyleStore >> stampIndex [

	^ stampIndex ifNil: [ stampIndex := ToPropertyIndex new ]
]

{ #category : #accessing }
ToStyleStore >> stampIndexDo: aBlock [

	stampIndex ifNil: [ ^ self ].
	aBlock value: stampIndex 
]

{ #category : #accessing }
ToStyleStore >> stampNamed: aSymbol in: anElement [

	(self lookUpStampNamed: aSymbol from: anElement) ifNotNil: [ :s | ^ s ].
	(ToElementPropertyNotFound name: aSymbol) signal
]

{ #category : #accessing }
ToStyleStore >> stampValue: aSymbol in: anElement [

	(self lookUpStampNamed: aSymbol from: anElement) ifNotNil: [ :s | ^ s value ].
	(ToElementPropertyNotFound name: aSymbol) signal
]

{ #category : #accessing }
ToStyleStore >> styleSheet [

	^ styleSheet
]

{ #category : #accessing }
ToStyleStore >> styleSheet: aStyleSheet [

	styleSheet := aStyleSheet
]

{ #category : #accessing }
ToStyleStore >> styleSheet: aStyleSheet in: anElement [

	self styleSheet ifNotNil: [ :prev | prev onUnInstalledIn: anElement ].
	self styleSheet: aStyleSheet.
	self styleSheet ifNotNil: [ :curr | curr onInstalledIn: anElement ]
]

{ #category : #accessing }
ToStyleStore >> styleSheetChainIn: anElement [
	" return an array with all my inherited stylesheets "

	^ Array new: 20 streamContents: [ :str |
		  | current inherits th |
		  current := anElement.
		  inherits := true.
		  [ current notNil and: [ inherits ] ] whileTrue: [
			  current toStyleStore styleSheet  ifNotNil: [ :ss |
				  str nextPut: ss.
				  inherits := ss inherits ].
			  current := current parent ].
		  th := anElement toTheme.
		  (th notNil and: [ th styleSheet notNil and: [ inherits ] ])
			  ifTrue: [ str nextPut: th styleSheet ] ]
]

{ #category : #accessing }
ToStyleStore >> textAttributesBuilder [

	^ textAttributesBuilder ifNil: [ textAttributesBuilder := BlTextAttributesBuilder new ]
]

{ #category : #'adding-removing' }
ToStyleStore >> withAllStamps: aCollectionOfSymbol [

	aCollectionOfSymbol ifEmpty: [ ^ self ].
	aCollectionOfSymbol do: [ :s | self withStamp: s ]
]

{ #category : #'adding-removing' }
ToStyleStore >> withStamp: anAssociationOrSymbol [

	self addStamp: anAssociationOrSymbol asStyleStamp
]

{ #category : #'adding-removing' }
ToStyleStore >> withoutAllStamps [

	self removeAllStamps
]

{ #category : #'adding-removing' }
ToStyleStore >> withoutStamp: aSymbol [

	self removeStampNamed: aSymbol ifAbsent: [  ]
]