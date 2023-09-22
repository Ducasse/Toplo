"
A ToDefaultStyleSheetTest is a test class for testing the behavior of ToDefaultStyleSheet
"
Class {
	#name : #ToDefaultStyleSheetTest,
	#superclass : #TestCase,
	#category : #'Toplo-Theme-Tests-DefaultTheme'
}

{ #category : #skin }
ToDefaultStyleSheetTest >> testDefaultButtonSkin [

	| ss button writers skin labelSkin ssi |
	ss := ToDefaultStyleSheet new.
	ssi := ToStyleSheetInterpreter new.
	button := ToButton new.
	writers := ssi writersFor: button.
	self assert: writers notEmpty.
	skin := ToSkin new.
	skin writers: writers.
	button withSkin: nil.
	self assert: button privateSkin isNil.
	button withSkin: skin.
	button checkSkinInstallation.
	self assert: button border width equals: 1.
	self assert: button border paint isColorPaint.
	self assert: button border paint color equals: button toTheme colorBorder.
	
	button labelText: 'Default'.
	button label privateSkin: nil.
	
	labelSkin := ToSkin new.
	writers := ssi writersFor: button label.
	labelSkin writers: writers.
	button label withSkin: labelSkin.
	button checkSkinInstallation.
	
	
]

{ #category : #'look updaters' }
ToDefaultStyleSheetTest >> testPropertyList [

	| ss index count |
	ss := ToStyleSheet new.
	index := IdentityDictionary new.
	ss propertyList do: [ :p |
		index at: p name ifAbsentPut: [ 0 ].
		count := (index at: p name) + 1.
		index at: p name put: count ].
	index keysAndValuesDo: [ :k :v | self assert: v identicalTo: 1 ].
	ss propertyList do: [ :p | self assert: (ss propertyNamed: p name) notNil ]
]