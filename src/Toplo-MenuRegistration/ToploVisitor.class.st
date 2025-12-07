Class {
	#name : #ToploVisitor,
	#superclass : #SMenuDeclarationVisitor,
	#category : #'Toplo-MenuRegistration-New'
}

{ #category : #'instance creation' }
ToploVisitor class >> open [
	<script>
	
	| builder menuPane |
	builder := SMenuBuilder new.
	builder item: #Tools.
	self halt.
	menuPane := builder accept: ToploVisitor new.
	menuPane openInSpace.
	builder inspect.
]

{ #category : #initialization }
ToploVisitor >> initialize [

	menuPane := ToMenuPane new
]

{ #category : #visiting }
ToploVisitor >> visitBuilder: aMenuBuilder [

	"aMenuBuilder collectedItems do: [ :item |
		item isGroup ifFalse: ["
			
	| menuSpecs |
	menuSpecs := aMenuBuilder items collect: [ :each | SMenuSpec new addItem: each ].  	
			"for now we will simulate the presence of SMenuSpec"
	
	menuSpecs do: [ :s | 
		menuPane addItem: (s accept: self) ].
	^ menuPane
	
]

{ #category : #visiting }
ToploVisitor >> visitMenuBuilder: aMenuBuilder [

	aMenuBuilder collectedItems do: [ :item |
		item isGroup ifFalse: [
			
			menuPane addItem: (item accept: self) ] ].
	^ menuPane
	
]

{ #category : #'Protocol (visiting) - 2 selector(s)' }
ToploVisitor >> visitMenuRegistration: aMenuRegistration [

	| menu |
	aMenuRegistration hasChildren
		ifTrue: [
			menu := ToMenu new labelText: aMenuRegistration curatedLabel.
			aMenuRegistration childrenItems do: [ :subItem |
				subItem isGroup 
					ifFalse: [ 
							menu addItem: (subItem accept: self).
							aMenuRegistration separator ifTrue: [ menu addSeparator ] ] ].
			 ]
		
		ifFalse: [
			menu := ToMenuItem new labelText: aMenuRegistration curatedLabel.
			menu clickAction: aMenuRegistration action.
			aMenuRegistration hasIcon ifTrue: [ menu iconImage: aMenuRegistration icon asElement ] ].
	
	^ menu
]
