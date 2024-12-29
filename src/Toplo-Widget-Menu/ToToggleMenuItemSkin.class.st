Class {
	#name : #ToToggleMenuItemSkin,
	#superclass : #ToMenuItemSkin,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'event handling' }
ToToggleMenuItemSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e | 
		e button startAlignment: (e valueOfTokenNamed: #'menu-item-start-alignment') ].

	
]