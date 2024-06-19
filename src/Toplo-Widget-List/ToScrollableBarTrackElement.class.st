Class {
	#name : #ToScrollableBarTrackElement,
	#superclass : #ToElement,
	#instVars : [
		'nodeScrolling',
		'nodeWrapping',
		'nodeAutoDistribution',
		'horizontal',
		'flowLineUniformWidth',
		'fakeNode'
	],
	#category : #'Toplo-Widget-List-InnerBar'
}

{ #category : #visiting }
ToScrollableBarTrackElement >> accept: aVisitor [

	aVisitor visitScrollableBarTrackElement: self
]

{ #category : #adding }
ToScrollableBarTrackElement >> addAllHolders: anArray at: aPosition [

	anArray reverseDo: [ :h | self addHolder: h at: aPosition]
]

{ #category : #adding }
ToScrollableBarTrackElement >> addFakeNode: aNode [

	fakeNode ifNotNil: [ fakeNode removeFromParent ].
	fakeNode := aNode.
	self addChild: aNode at: 1.

]

{ #category : #adding }
ToScrollableBarTrackElement >> addHolder: anHolder at: aPosition [

	| node |
	node := anHolder node.
	self addChild: node at: aPosition + 1
]

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> artlyVisibleNodesSelect: aBlock [

	^ Array streamContents: [ :stream |
		  self partlyVisibleNodesDo: [ :node |
			  (aBlock value: node) ifTrue: [ stream nextPut: node ] ] ]
]

{ #category : #accessing }
ToScrollableBarTrackElement >> fakeNode [ 

	^ fakeNode
]

{ #category : #accessing }
ToScrollableBarTrackElement >> flowLineUniformWidth: anObject [

	flowLineUniformWidth := anObject
]

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> fullyVisibleNodes [

	^ Array streamContents: [ :stream |
		  self fullyVisibleNodesDo: [ :node | stream nextPut: node ] ]
]

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> fullyVisibleNodesDo: aBlock [

	self nodesDo: [ :node |
		node isFullyVisible ifTrue: [ aBlock value: node ] ]
]

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> fullyVisibleNodesSelect: aBlock [

	^ Array streamContents: [ :stream |
		  self nodesDo: [ :node |
			  node isFullyVisible ifTrue: [
				  (aBlock value: node) ifTrue: [ stream nextPut: node ] ] ] ]
]

{ #category : #accessing }
ToScrollableBarTrackElement >> horizontal: anObject [

	horizontal := anObject
]

{ #category : #testing }
ToScrollableBarTrackElement >> isFlowLineUniformWidth [

	^ flowLineUniformWidth 
]

{ #category : #testing }
ToScrollableBarTrackElement >> isHorizontal [

	^ horizontal
]

{ #category : #testing }
ToScrollableBarTrackElement >> isNodeAutoDistribution [

	^ nodeAutoDistribution
]

{ #category : #testing }
ToScrollableBarTrackElement >> isNodeScrolling [

	^ nodeScrolling
]

{ #category : #testing }
ToScrollableBarTrackElement >> isNodeWrapping [

	^ nodeWrapping
]

{ #category : #accessing }
ToScrollableBarTrackElement >> nodeAutoDistribution: anObject [

	nodeAutoDistribution := anObject
]

{ #category : #accessing }
ToScrollableBarTrackElement >> nodeScrolling: anObject [

	nodeScrolling := anObject
]

{ #category : #accessing }
ToScrollableBarTrackElement >> nodeWrapping: anObject [

	nodeWrapping := anObject
]

{ #category : #accessing }
ToScrollableBarTrackElement >> nodes [

	^ Array streamContents: [ :stream |
		  self nodesDo: [ :node | stream nextPut: node ] ]
]

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> nodesDo: aBlock [

	self childrenDo: [ :node |
		node = fakeNode ifFalse: [ aBlock value: node ] ]
]

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> nodesSelect: aBlock [

	^ Array streamContents: [ :stream |
		  self nodesDo: [ :node |
			  (aBlock value: node) ifTrue: [ stream nextPut: node ] ] ]
]

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> nodesWithIndexDo: aBlock [

	self nodesDo: [ :node |
		aBlock value: node value: node holder position]
]

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> partlyVisibleNodesDo: aBlock [

	self nodesDo: [ :node |
		node isPartlyVisible ifTrue: [ aBlock value: node ] ]
]

{ #category : #'accessing - children' }
ToScrollableBarTrackElement >> partlyVisibleNodesSelect: aBlock [

	^ Array streamContents: [ :stream |
		  self partlyVisibleNodesDo: [ :node |
			  (aBlock value: node) ifTrue: [ stream nextPut: node ] ] ]
]

{ #category : #removing }
ToScrollableBarTrackElement >> removeAllNodes: anArray [

	anArray reverseDo: [ :node | self removeNode: node ]
]

{ #category : #removing }
ToScrollableBarTrackElement >> removeFakeNode [

	fakeNode ifNotNil: [ fakeNode removeFromParent ].
	fakeNode := nil
]

{ #category : #removing }
ToScrollableBarTrackElement >> removeNode: aNode [

	aNode
		release;
		removeFromParent
]