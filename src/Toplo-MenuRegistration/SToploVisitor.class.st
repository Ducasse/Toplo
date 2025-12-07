Class {
	#name : #SToploVisitor,
	#superclass : #SMenuDeclarationVisitor,
	#category : #'Toplo-MenuRegistration-New'
}

{ #category : #'instance creation' }
SToploVisitor class >> open [
	<script>
	
	| builder visitor |
	builder := SMenuBuilder new.
	builder item: #Tools.
	visitor := SToploVisitor new.
	builder accept: visitor.
	visitor menuPane openInSpace.
	builder inspect.
]

{ #category : #'instance creation' }
SToploVisitor class >> trying [
	<script>
	
	| menuPane menuItem menu |
	menuPane := ToMenuPane new. 
	menuItem := ToMenuItem new  labelText: 'Menu item'.
	menu :=  ToMenu new labelText: 'Menu'.
	menu addItem: menuItem. 
	menuPane addItem: menu.
	menuPane openInSpace
]

{ #category : #initialization }
SToploVisitor >> initialize [

	menuPane := ToMenuPane new
]

{ #category : #accessing }
SToploVisitor >> menuPane [
	^ menuPane
]

{ #category : #visiting }
SToploVisitor >> visitBuilder: aMenuBuilder [

	"aMenuBuilder collectedItems do: [ :item |
		item isGroup ifFalse: ["
			
	| menuSpecs |
	menuSpecs := aMenuBuilder items collect: [ :each | SMenuSpec new label: 'Faked Root' ; addItem: each ].  	
			"for now we will simulate the presence of SMenuSpec"
	
	menuSpecs do: [ :s | 
		menuPane addItem: (s accept: self) ].
	^ menuPane
	
]

{ #category : #'Protocol (visiting) - 2 selector(s)' }
SToploVisitor >> visitMenu: aMenu [

	| tmenu |
	tmenu := ToMenu new labelText: aMenu label; yourself.
	aMenu items do: [ :item |
		tmenu addItem: (item accept: self) ].
	^ tmenu
]

{ #category : #'Protocol (visiting) - 2 selector(s)' }
SToploVisitor >> visitMenuItem: aMenuItem [

	| tmenu |
	tmenu := ToMenuItem new labelText: aMenuItem label; yourself .
	tmenu clickAction: aMenuItem action.
	aMenuItem hasIcon ifTrue: [ tmenu iconImage: aMenuItem icon asElement ].
	^ tmenu
	
]
