Class {
	#name : #ToDemoButSkin2,
	#superclass : #ToButterflySkin,
	#category : #'Toplo-Demo-2-ButterflyTheme'
}

{ #category : #'event handling' }
ToDemoButSkin2 >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: (e tokenValueNamed: #'color-success') ]
]

{ #category : #'event handling' }
ToDemoButSkin2 >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e geometry: BlCircleGeometry new.
		e background: (e tokenValueNamed: #'color-primary').
		e border: (e tokenValueNamed: #'color-primary') ]
]

{ #category : #'event handling' }
ToDemoButSkin2 >> leavedLookEvent: anEvent [

	super leavedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: (e tokenValueNamed: #'color-primary') ]
]