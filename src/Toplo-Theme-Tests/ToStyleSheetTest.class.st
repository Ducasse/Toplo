"
A ToStyleSheetTest is a test class for testing the behavior of ToStyleSheet
"
Class {
	#name : #ToStyleSheetTest,
	#superclass : #TestCase,
	#category : #'Toplo-Theme-Tests-StyleSheet'
}

{ #category : #tests }
ToStyleSheetTest >> testButtonLabelSkin0 [

	| ss button labelSkin attributes foregroundAttr prop writers label ssi |
	" declare a local only stylesheet "
	ss := ToStyleSheet new inherits: false; yourself.
	ssi := ToStyleSheetInterpreter new.

	" danger button label rule "
	prop := ToPseudoProperty new name: #'text-attributes'.
	prop writer: [ :e :v |
		e text attributes:
			(BlTextAttributesBuilder new foreground: v) attributes.
		e textChanged ].

	ss addStyleRule: (
		((ToStyleTagSelector new styleTag: #'button-label') 
			parent: (ToStyleTagSelector new styleTags: #( #button #danger ))
			depth: 2)
			 style: [ :sr |
				 sr write: prop with: [ :e | e toTheme colorError ].
				 sr
					 when: ToDisabledLookEvent
					 write: prop
					 with: [ :e | e toTheme colorTextDisabled ].
				 sr
					 when: ToInitialLookEvent
					 write: prop
					 with: [ :e | e toTheme colorError ].
				 sr
					 when: ToHoveredLookEvent
					 write: prop
					 with: [ :e | e toTheme colorErrorHover ].
				 sr
					 when: ToPressedLookEvent
					 write: prop
					 with: [ :e | e toTheme colorError darker ] ]).

	button := ToButton new.
	button styleSheet: ss.
	label := (ToLabel text: 'Default') defaultSkin: nil.
	button label: label.
	labelSkin := ToSkin new.
	self assert: (button styleTags includes: #danger) not.
	self assert: (button label styleTags includes: #'button-label').
	writers := ssi writersFor: button label.
	" writers should be empty since the label rule expect the button 
	to be of class #danger and the label to be with style class #'button-label'"
	self assert: writers isEmpty.
	button styleTags: #( #button #danger ).
	writers := ssi writersFor: button label.
	self assert: writers size equals: 5.

	labelSkin writers: writers.
	button label withSkin: labelSkin.
	button label checkSkinInstallation.
	attributes := button label text attributesAt: 1.
	self assert: attributes notEmpty.
	foregroundAttr := attributes
		                  detect: [ :eachAttribute |
		                  eachAttribute isKindOf: BlTextForegroundAttribute ]
		                  ifNone: [
			                  self fail:
				                  'should have a foreground attribute (toTheme colorError)' ].
	self
		assert: foregroundAttr paint
		equals: button label toTheme colorError
]

{ #category : #tests }
ToStyleSheetTest >> testButtonSkin0 [

	| ss button skin labelSkin attributes foregroundAttr writers label ssi |
	ss := ToStyleSheet new inherits: false; yourself.
	ssi := ToStyleSheetInterpreter new.
	
	" default button rule "
	ss addStyleRule: ((ToStyleTagSelector new styleTag: #button)
			 style: [ :sr |
				 | p |
				 p := ToFeatureProperty new name: #background.

				 sr
					 when: ToDisabledLookEvent
					 write: p
					 with: [ :e | e toTheme colorBgContainerDisabled ].
				 sr
					 when: ToInitialLookEvent
					 write: p
					 with: [ :e | Color transparent ].

				 p := ToFeatureProperty new name: #border.

				 sr
					 when: ToDisabledLookEvent
					 write: p
					 with: [ :e | e toTheme colorBorderDisabled ].
				 sr
					 when: ToInitialLookEvent
					 write: p
					 with: [ :e | e toTheme colorBorder ].
				 sr
					 when: ToHoveredLookEvent
					 write: p
					 with: [ :e | e toTheme colorPrimaryHover ].
				 sr
					 when: ToPressedLookEvent
					 write: p
					 with: [ :e | e toTheme colorPrimaryPressed ] ]).

	" danger button label rule "
	ss addStyleRule: (((ToStyleTagSelector new styleTag: #'button-label')
					  parent:
					  (ToStyleTagSelector new styleTags: #( #button #danger ))
					  depth: 2)
			 style: [ :sr |
				 | p |
				 p := ToPseudoProperty new name: #'text-attributes'.
				 p writer: [ :e :v |
					 e text attributes:
						 (BlTextAttributesBuilder new foreground: v) attributes.
					 e textChanged ].

				 sr
					 when: ToDisabledLookEvent
					 write: p
					 with: [ :e | e toTheme colorTextDisabled ].
				 sr
					 when: ToInitialLookEvent
					 write: p
					 with: [ :e | e toTheme colorError ].
				 sr
					 when: ToHoveredLookEvent
					 write: p
					 with: [ :e | e toTheme colorErrorHover ].
				 sr
					 when: ToPressedLookEvent
					 write: p
					 with: [ :e | e toTheme colorError darker ] ]).


	button := ToButton new.
	button styleSheet: ss.
	writers := ssi writersFor: button.
	self assert: writers size equals: 6.
	skin := ToSkin new.
	skin writers: writers.
	button withSkin: nil.
	button innerElement defaultSkin: nil.
	self assert: button privateSkin isNil.
	button withSkin: skin.
	button checkSkinInstallation.
	self assert: button border width equals: 1.
	self assert: button border paint isColorPaint.
	self
		assert: button border paint color
		equals: button toTheme colorBorder.

	label := ToLabel text: 'Default'.
	label defaultSkin: nil.
	label withSkin: nil.
	button label: label.
	labelSkin := ToSkin new.
	writers := ssi writersFor: button label.
	self assert: writers isEmpty.
	button label styleTag: #'button-label'.
	writers := ssi writersFor: button label.
	" should be empty since the label rule expect the button to be of class #danger "
	self assert: writers isEmpty.
	button styleTags: #( #button #danger ).
	writers := ssi writersFor: button label.
	self assert: writers size equals: 4.

	labelSkin writers: writers.
	label withSkin: labelSkin.
	label checkSkinInstallation.
	attributes := button label text attributesAt: 1.
	self assert: attributes notEmpty.
	foregroundAttr := attributes
		                  detect: [ :eachAttribute |
		                  eachAttribute isKindOf: BlTextForegroundAttribute ]
		                  ifNone: [
			                  self fail:
				                  'should have a foreground attribute (toTheme colorError)' ].
	self
		assert: foregroundAttr paint
		equals: button label toTheme colorError
]

{ #category : #tests }
ToStyleSheetTest >> testButtonSkinWithInterspace [

	| ss elem writers skin interspaceProp layoutProp ssi |
	
	ssi := ToStyleSheetInterpreter new.
	interspaceProp := ToPseudoProperty
			   name: #'layout-interspace'
			   reader: [ :e | e layout interspace ]
			   writer: [ :e :v | e layout interspace: v ].
	layoutProp := ToFeatureProperty name: #layout.
	
	ss := ToStyleSheet new inherits: false; yourself.
	ss addStyleRule: (((ToStyleTagSelector new styleTag: #button) 
				or: (ToStyleTagSelector new styleTags: #( #button #horizontal )))
			 style: [ :sr |
				 sr
					 write: layoutProp
					 with: BlLinearLayout horizontal.
				 sr  write: interspaceProp with: 10]).

	elem := ToElement new.
	elem styleSheet: ss.
	writers := ssi writersFor: elem.
	self assert: writers size equals: 0.
	elem styleTag: #button.
	writers := ssi writersFor: elem.
	self assert: writers size equals: 2.
	skin := ToSkin new.
	skin writers: writers.
	elem withSkin: skin.
	elem checkSkinInstallation.
	self assert: (elem layout isKindOf: BlLinearLayout).
	self assert: elem layout interspace equals: 10
]

{ #category : #tests }
ToStyleSheetTest >> testEmptyStyleSheet [

	| ss ssi |
	ss := ToStyleSheet new inherits: false; yourself.
	ssi := ToStyleSheetInterpreter new.
	self assert: (ssi writersFor: (ToElement new)) isEmpty
]

{ #category : #tests }
ToStyleSheetTest >> testNewStyleSheetWith2Rules [

	| styleSheet |
	styleSheet := ToStyleSheet new inherits: false; yourself.
	styleSheet addAllStyleRules: {
			((ToStyleTagSelector new styleTag: #button)
				 style: [ :sr |
					 sr
						 write: (styleSheet propertyNamed: #background)
						 with: Color blue.
					 sr
						 write: (styleSheet propertyNamed: #border)
						 with: Color red ]).
			".button {
				background: blue;
				border: red;
			}"
			((ToStyleTagSelector new styleTag: #button)
				 style: [ :sr |
					 sr
						 write: (styleSheet propertyNamed: #background)
						 with: Color transparent.
					 sr
						 write: (styleSheet propertyNamed: #border)
						 with: Color blue ])
			".button:initial {
				background: transparent;
				border: blue;
			}" }
]

{ #category : #tests }
ToStyleSheetTest >> testSkinWithAnUniversalRule [

	| ss elem skin writers ssi |
	ss := ToStyleSheet new inherits: false; yourself.
	ssi := ToStyleSheetInterpreter new.
	ss addStyleRule:
		(ToUniversalSelector new style: [ :sr |
			 sr
				 when: ToInitialLookEvent
				 write: (ToFeatureProperty new name: #background)
				 with: Color red ]).
	elem := ToElement new.
	elem styleSheet: ss.
	writers := ssi writersFor: elem.
	self assert: writers size equals: 1.
	skin := ToSkin new.
	skin writers: writers.
	elem withSkin: skin.
	elem checkSkinInstallation.
	self assert: elem background paint color equals: Color red
]

{ #category : #tests }
ToStyleSheetTest >> testSkinWithChildRule [
	" with a direct child "

	| ss skin parent child writers ssi |
	ss := ToStyleSheet new inherits: false; yourself.
	ssi := ToStyleSheetInterpreter new.
	ss addStyleRule: (((ToIdSelector new id: #child) parent:
					  (ToStyleTagSelector new styleTag: #parent))
			 style: [ :sr |
				 sr
					 when: ToInitialLookEvent
					 write: (ToFeatureProperty new name: #border)
					 with: (BlBorder paint: Color red width: 3) ]).

	parent := ToElement new styleTag: #parent.
	parent styleSheet: ss.
	child := ToElement new id: #child.
	writers := ssi writersFor: child.
	self assert: writers size equals: 0.

	parent addChild: child.
	writers := ssi writersFor: child.
	self assert: writers size equals: 1.
	skin := ToSkin new.
	skin writers: writers.
	child withSkin: skin.
	parent checkSkinInstallation.
	self assert: child border width equals: 3.
	self assert: child border paint isColorPaint.
	self assert: child border paint color equals: Color red
]

{ #category : #tests }
ToStyleSheetTest >> testSkinWithChildRuleLevel2 [
	" with a direct child "

	| ss skin parent child writers subParent ssi |
	ss := ToStyleSheet new inherits: false; yourself.
	ssi := ToStyleSheetInterpreter new.
	ss addStyleRule: (((ToIdSelector new id: #child)
					  parent: (ToStyleTagSelector new styleTag: #parent)
					  depth: 2)
			 style: [ :sr |
				 sr
					 when: ToInitialLookEvent
					 write: (ToFeatureProperty new name: #border)
					 with: (BlBorder paint: Color red width: 3) ]).

	parent := ToElement new styleTag: #parent.
	parent styleSheet: ss.
	subParent := ToElement new.
	child := ToElement new id: #child.
	writers := ssi writersFor: child.
	self assert: writers size equals: 0.

	parent addChild: subParent.
	subParent addChild: child.
	writers := ssi writersFor: child.
	self assert: writers size equals: 1.
	skin := ToSkin new.
	skin writers: writers.
	child withSkin: skin.
	parent checkSkinInstallation.
	self assert: child border width equals: 3.
	self assert: child border paint isColorPaint.
	self assert: child border paint color equals: Color red
]

{ #category : #tests }
ToStyleSheetTest >> testSkinWithIdRule [

	| ss elem writers skin ssi |
	ss := ToStyleSheet new inherits: false; yourself.
	ssi := ToStyleSheetInterpreter new.
	ss addStyleRule:
		((ToIdSelector new id: #a) style: [ :sr |
			 sr
				 write: (ToFeatureProperty new name: #border)
				 with: (BlBorder paint: Color red width: 3) ]).
	elem := ToElement new.
	elem styleSheet: ss.
	writers := ssi writersFor: elem.
	self assert: writers size equals: 0.
	elem id: #a.
	writers := ssi writersFor: elem.
	self assert: writers size equals: 1.
	skin := ToSkin new.
	skin writers: writers.
	elem withSkin: skin.
	elem checkSkinInstallation.
	self assert: elem border width equals: 3.
	self assert: elem border paint isColorPaint.
	self assert: elem border paint color equals: Color red
]

{ #category : #'tests - style sheet style' }
ToStyleSheetTest >> testStyleSheetStyle0 [

	| ss button skin writers ssi rules |
	ss := ToStyleSheet new
		      inherits: false;
		      yourself.
	ssi := ToStyleSheetInterpreter new.

	" default button rule "
	rules := { (#button asStyleSelector style: [ :sr |
		          sr write: (ss property: #background) with: Color white.
		          sr
			          when: ToInitialLookEvent
			          write: (ss property: #background)
			          with: [ :e | Color black ].
		          sr
			          when: ToDisabledLookEvent
			          write: (ss property: #background)
			          with: [ :e | e toTheme colorBgContainerDisabled ] ]) }.

	ss addAllStyleRules: rules.
	button := ToElement new.
	button addStyleTag: #button.
	button styleSheet: ss.
	writers := ssi writersFor: button.
	self assert: writers size equals: 3.
	skin := ToSkin new.
	skin writers: writers.
	button withSkin: skin.

	button switchToSkinState: ToInstallState new.
	self assert: button background paint isColorPaint.
	self assert: button background paint color equals: Color white.

	button switchToSkinState: ToInitialState new.
	self assert: button background paint isColorPaint.
	self assert: button background paint color equals: Color black
]

{ #category : #'tests - style sheet style' }
ToStyleSheetTest >> testStyleSheetStyleWithSubRules0 [

	| ss button skin writers ssi rules |
	ss := ToStyleSheet new
		      inherits: false;
		      yourself.
	ssi := ToStyleSheetInterpreter new.

	" default button rule "
	rules := { (#button asStyleSelector style: [ :sr |
		          sr rules: { 
							#danger asStyleSelector style: [ :srb |
				           	srb write: (ss property: #background) with: Color red.
								srb
									when: ToDisabledLookEvent
									write: (ss property: #background)
									with: [ :e | Color red alpha: 0.1 ] ].
					 }.
		          sr write: (ss property: #background) with: Color white.
		          sr
			          when: ToInitialLookEvent
			          write: (ss property: #background)
			          with: [ :e | Color black ].
		          sr
			          when: ToDisabledLookEvent
			          write: (ss property: #background)
			          with: [ :e | Color lightGray ] ]) }.

	ss addAllStyleRules: rules.
	button := ToElement new.
	button addStyleTag: #button.
	button styleSheet: ss.
	writers := ssi writersFor: button.
	self assert: writers size equals: 3.
	skin := ToSkin new.
	skin writers: writers.
	button withSkin: skin.

	button switchToSkinState: ToInstallState new.
	self assert: button background paint isColorPaint.
	self assert: button background paint color equals: Color white.

	button switchToSkinState: ToInitialState new.
	self assert: button background paint isColorPaint.
	self assert: button background paint color equals: Color black.
	
	button addStyleTag: #danger.
	button updateSkin.
	button switchToSkinState: ToInstallState new.
	self assert: button background paint isColorPaint.
	self assert: button background paint color equals: Color red.
	
	button switchToSkinState: ToInitialState new.
	self assert: button background paint isColorPaint.
	self assert: button background paint color equals: Color black.
	
	button switchToSkinState: ToDisabledState new.
	self assert: button background paint isColorPaint.
	self assert: button background paint color equals: (Color red alpha: 0.1)


]