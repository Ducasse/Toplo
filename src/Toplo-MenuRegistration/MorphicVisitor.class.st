Class {
	#name : #MorphicVisitor,
	#superclass : #SMenuDeclarationVisitor,
	#category : #'Toplo-MenuRegistration-New'
}

{ #category : #'instance creation' }
MorphicVisitor class >> open [
	<script>
	
	| builder visitor |
	builder := SMenuBuilder new.
	builder item: #Tools.
	visitor := ToploVisitor new.
	builder accept: visitor.
	visitor menuPane openInSpace.
	builder inspect.
]

{ #category : #'instance creation' }
MorphicVisitor >> open [
	<script>
	
	| builder visitor |
	builder := SMenuBuilder new.
	builder item: #Tools.
	visitor := ToploVisitor new.
	builder accept: visitor.
	visitor menuPane openInSpace.
	builder inspect.
]
