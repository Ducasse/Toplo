Class {
	#name : #SToploVisitor,
	#superclass : #SMenuDeclarationVisitor,
	#category : #'Toplo-MenuRegistration-New'
}

{ #category : #'instance creation' }
SToploVisitor class >> open [
	<script>
	
	| builder menuPane |
	builder := SMenuBuilder new.
	builder item: #Tools.
	
	menuPane := builder accept: ToploVisitor new.
	menuPane openInSpace.
	builder inspect.
]

{ #category : #initialization }
SToploVisitor >> initialize [

	menuPane := ToMenuPane new
]

{ #category : #visiting }
SToploVisitor >> visitBuilder: aMenuBuilder [

	"aMenuBuilder collectedItems do: [ :item |
		item isGroup ifFalse: ["
			
	aMenuBuilder items do: [ :each |  		
	menuPane addItem: (each accept: self) ].
	^ menuPane
	
]

{ #category : #'Protocol (visiting) - 2 selector(s)' }
SToploVisitor >> visitMenu: aMenu [

	menuPane addItem: (ToMenu new labelText: aMenu label)
]

{ #category : #visiting }
SToploVisitor >> visitMenuBuilder: aMenuBuilder [

	aMenuBuilder collectedItems do: [ :item |
		item isGroup ifFalse: [
			
			menuPane addItem: (item accept: self) ] ].
	^ menuPane
	
]

{ #category : #'Protocol (visiting) - 2 selector(s)' }
SToploVisitor >> visitMenuRegistration: aMenuRegistration [

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
