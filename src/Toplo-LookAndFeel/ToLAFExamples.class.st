Class {
	#name : #ToLAFExamples,
	#superclass : #Object,
	#category : #'Toplo-LookAndFeel-Examples'
}

{ #category : #button }
ToLAFExamples class >> example_toButtonChangeThemeOnClickChangeSkinOnRightClick [

	| but space |
	but := ToButton new.
	but dresser: ToLAFButtonDresser new.
	but label: (ToLabel text: 'Button').
	
	but whenClickedDo: [
		but toTheme: (but toTheme class = ToClearTheme
				 ifTrue: [ ToDarkTheme new ]
				 ifFalse: [ ToClearTheme new ]) ].
			
	but when: BlMouseDownEvent do: [ :event |
		event secondaryButtonPressed ifTrue: [
			but skin: (but skin class = ToPrimaryButtonSkin
					 ifTrue: [ ToDefaultButtonSkin new ]
					 ifFalse: [ ToPrimaryButtonSkin new ]) ] ].
			
	space := OBlSpace new.
	"space toTheme: ToClearTheme new."
	space addChild: but.
	space show
]

{ #category : #'see class side' }
ToLAFExamples >> seeClassSide [ 
]