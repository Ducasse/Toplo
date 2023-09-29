Class {
	#name : #ToMenuWindowEventHandler,
	#superclass : #ToPopupWindowEventHandler,
	#category : #'Toplo-Core-Window'
}

{ #category : #'event handling' }
ToMenuWindowEventHandler >> mouseUpOutsideEvent: anEvent [

	| origEventTarget win |
	origEventTarget := anEvent originalEvent target.
	" if I'm the original event target then do nothing"
	origEventTarget ifNil: [
		^ super mouseUpOutsideEvent: anEvent ].
	" if one of my children is the original event target then do nothing"
	(origEventTarget hasInParentChain: anEvent currentTarget) ifTrue: [
		^ self ].

	win := anEvent currentTarget openedSubmenuWindow.
	[ win notNil ] whileTrue: [
		" If the original event target is one of the submenu child then do nothing"
		(origEventTarget hasInParentChain: win) ifTrue: [
			^ self ].
		win := win openedSubmenuWindow ].

	" ok, the event is outside of the submenu chain"
	super mouseUpOutsideEvent: anEvent 
]

{ #category : #'event handling' }
ToMenuWindowEventHandler >> mouseWheelEvent: anEvent [

	
]