Class {
	#name : #ToSelectionModelOperator,
	#superclass : #ToCommandApplier,
	#instVars : [
		'selectionModel',
		'previousModel'
	],
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #'command operations' }
ToSelectionModelOperator >> addIndexesSelectionCommand: aCommand [

	aCommand indexes ifEmpty: [ ^ self ].
	self selectionModel selectAllIndexes: aCommand indexes
]

{ #category : #'command operations' }
ToSelectionModelOperator >> addIntervalSelectionCommand: aCommand [

	self selectionModel selectIndex: aCommand from to: aCommand to
]

{ #category : #'command operations' }
ToSelectionModelOperator >> addWholeSelectionCommand: aCommand [

	self selectionModel selectAll
]

{ #category : #'command application' }
ToSelectionModelOperator >> applyCommand: aCommand for: aTarget [

	| dispatch |
	previousModel ifNil: [ previousModel := self selectionModel copy ].

	super applyCommand: aCommand for: aTarget.

	dispatch := aCommand silent
		            ifTrue: [ false ]
		            ifFalse: [ previousModel ~= self selectionModel ].

	dispatch ifFalse: [ ^ self ].
	
	previousModel := self selectionModel copy.
	aTarget dispatchEvent: (ToSelectionCommandAppliedEvent new
			 operator: self;
			 command: aCommand).

	aTarget dispatchEvent: (ToListSelectionChangedEvent new
			 selectionModel: previousModel;
			 yourself)
]

{ #category : #accessing }
ToSelectionModelOperator >> itemCount [

	^ self selectionModel itemCount
]

{ #category : #'api - hooks' }
ToSelectionModelOperator >> onInstalledIn: anEventTarget [

	super onInstalledIn: anEventTarget.
	self selectionModel: anEventTarget selectionModel
]

{ #category : #'api - hooks' }
ToSelectionModelOperator >> onUninstalledIn: anEventTarget [

	super onUninstalledIn: anEventTarget.
	self selectionModel: nil
]

{ #category : #'command operations' }
ToSelectionModelOperator >> removeIndexesSelectionCommand: aCommand [

	aCommand indexes ifEmpty: [ ^ self ].
	self selectionModel deselectAllIndexes: aCommand indexes
]

{ #category : #'command operations' }
ToSelectionModelOperator >> removeIntervalSelectionCommand: aCommand [

	self selectionModel deselectIndex: aCommand from to: aCommand to
]

{ #category : #'command operations' }
ToSelectionModelOperator >> removeWholeSelectionCommand: aCommand [

	self selectionModel deselectAll
]

{ #category : #accessing }
ToSelectionModelOperator >> selectionModel [

	^ selectionModel
]

{ #category : #accessing }
ToSelectionModelOperator >> selectionModel: aSelectionModel [

	selectionModel := aSelectionModel
]

{ #category : #'command operations' }
ToSelectionModelOperator >> selectionModelShiftCommand: aShiftCommand [

	self selectionModel shift: aShiftCommand itemCount from: aShiftCommand fromIndex
]

{ #category : #accessing }
ToSelectionModelOperator >> sharedEvents [

	^ super sharedEvents , {
		  ToSelectionCommandAppliedEvent.
		  ToListSelectionChangedEvent }
]