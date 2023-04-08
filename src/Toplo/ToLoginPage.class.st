Class {
	#name : #ToLoginPage,
	#superclass : #Object,
	#category : #'Toplo-Examples'
}

{ #category : #'instance creation' }
ToLoginPage class >> open [
<script>
self new open.
]

{ #category : #'instance creation' }
ToLoginPage >> open [

	| panel loginNamePanel passwdPanel btnLogin loginLabel loginValue pwLabel pwValue groupLogin btnPanel |
	panel := ToPane new.
	panel layout: BlFrameLayout new.
	panel matchParent.

	groupLogin := ToPane new beVertical.
	groupLogin width: 400.
	groupLogin vFitContent.
	groupLogin constraintsDo: [ :c | c frame vertical alignCenter ].
	groupLogin padding: (BlInsets all: 10).
	groupLogin border: (BlBorder paint: Color veryLightGray).
	groupLogin geometry: (BlRoundedRectangleGeometry cornerRadius: 12).

	loginNamePanel := ToPane new
		                  beHorizontal;
		                  hMatchParent;
		                  vFitContent.
	loginLabel := ToLabel new text: 'Login :'.
	loginLabel width: 100.
	"loginLabel constraintsDo: [ :c | c linear  weight: 0.4 ]."

	loginLabel layout alignCenterRight.
	loginValue := ToTextField new hMatchParent.
	loginNamePanel addChildren: {
			loginLabel.
			loginValue }.
	passwdPanel := ToPane new
		               beHorizontal;
		               hMatchParent;
		               vFitContent.
	pwLabel := ToLabel new text: 'Password :'.
	pwLabel width: 100.
	"pwLabel constraintsDo: [ :c | c linear weight: 0.4 ]."
	pwLabel layout alignCenterRight.
	pwValue := ToTextField new hMatchParent.
	passwdPanel addChildren: {
			pwLabel.
			pwValue }.
	btnPanel := ToPane new
		            beHorizontal;
		            hMatchParent;
		            vFitContent.
	btnLogin := ToButton new labelText: 'Accept'.
	btnLogin padding: (BlInsets
			 top: 10
			 left: 40
			 bottom: 10
			 right: 40).
	btnLogin margin: (BlInsets
			 top: 10
			 left: 0
			 bottom: 0
			 right: 0).
	btnLogin constraintsDo: [ :c | c linear horizontal alignCenter ].

	"add elements to panel"

	groupLogin addChildren: {
			loginNamePanel.
			passwdPanel.
			btnLogin }.

	groupLogin constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].

	panel addChild: groupLogin.
	panel matchParent.
	panel openInOBlSpace
]