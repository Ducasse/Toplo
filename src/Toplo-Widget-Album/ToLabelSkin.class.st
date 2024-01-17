Class {
	#name : #ToLabelSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Album-Label'
}

{ #category : #'event handling' }
ToLabelSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e textAttributesBuilder 
			weight: (e tokenValueNamed: #'font-weight-strong');
			defaultFontName: (e tokenValueNamed: #'font-family-code');
			defaultFontSize: (e tokenValueNamed: #'font-size');
			lineSpacing: (e tokenValueNamed: #'line-height');
			foreground: (e tokenValueNamed: #'color-text').
		e isDisabled ifTrue: [
			e textAttributesBuilder foreground: (e tokenValueNamed: #'color-text-disabled') ].
		e hasText ifFalse: [ ^ self ].
		e applyAttributesBuilder.
		e textChanged ]
]