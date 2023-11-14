Class {
	#name : #ToSkinManager,
	#superclass : #Object,
	#instVars : [
		'skinInstaller',
		'localTheme',
		'postponedRequestSkin',
		'installedSkin',
		'skinStateQueue',
		'skinUninstaller',
		'defaultSkin',
		'intrinsicStateIndex'
	],
	#category : 'Toplo-Core-Theme'
}

{ #category : #'skin application' }
ToSkinManager >> applySkinInstallerIn: anElement [
	" ask the skin installer (if any) to actually install the skin "

	self skinInstaller ifNotNil: [ :si | si applyOn: anElement ].
	self installedSkin ifNil: [
		((anElement isKindOf: ToElement) and: [postponedRequestSkin isNil and: [
			 skinUninstaller isNil and: [ skinInstaller isNil ] ] ]) ifTrue: [
			Error signal: 'A ToSkinManager has an invalid state' ] ]
]

{ #category : #'skin application' }
ToSkinManager >> applySkinUninstallerIn: anElement [

	" ask the skin uninstaller (if any) to actually uninstall the skin "
	self skinUninstaller ifNotNil: [ :su | su applyOn: anElement ]
]

{ #category : #'accessing - skin' }
ToSkinManager >> defaultSkin: aSkin in: anElement [

	defaultSkin = aSkin ifTrue: [ ^ self ].
	self setSkin: aSkin in: anElement

]

{ #category : #'accessing - skin' }
ToSkinManager >> defaultSkinIn: anElement [

	^ defaultSkin ifNil: [ (self lookupThemeFrom: anElement) newSkinFor: anElement ]
]

{ #category : #'skin application' }
ToSkinManager >> enqueueState: aSkinState for: anElement [

	self skinStateQueue enqueueState: aSkinState for: anElement
]

{ #category : #initialization }
ToSkinManager >> initialize [ 

	super initialize.
	intrinsicStateIndex := IdentityDictionary new
]

{ #category : #'accessing - skin' }
ToSkinManager >> installedSkin [

	" set from the ToSkin>>onInstalledIn: and ToSkin>>onUninstalledIn: "
	^ installedSkin
]

{ #category : #'accessing - skin' }
ToSkinManager >> installedSkin: aSkin [

	" send from the ToSkin>>onInstalledIn: and ToSkin>>onUninstalledIn: "
	installedSkin := aSkin
]

{ #category : #'accessing - skin' }
ToSkinManager >> installedSkinDo: aBlock [

	self installedSkin ifNil: [ ^ self ].
	aBlock value: self installedSkin
]

{ #category : #'skin application' }
ToSkinManager >> intrinicState: aState enqueuedFor: anElement [

	intrinsicStateIndex at: aState class put: aState
]

{ #category : #accessing }
ToSkinManager >> intrinsicStateIndex [

	^ intrinsicStateIndex 
]

{ #category : #'skin application' }
ToSkinManager >> intrinsicStatesDo: aBlock [

	intrinsicStateIndex valuesDo: aBlock
]

{ #category : #'accessing - skin' }
ToSkinManager >> isRequestSkinPostponed [

	
	^ postponedRequestSkin notNil
]

{ #category : #accessing }
ToSkinManager >> localTheme [ 

	^ localTheme
]

{ #category : #accessing }
ToSkinManager >> localTheme: aTheme [

	localTheme := aTheme
]

{ #category : #accessing }
ToSkinManager >> localTheme: aTheme in: anElement [

	self localTheme = aTheme ifTrue: [ ^ self ].
	self localTheme: aTheme.
	anElement toThemeChanged.

]

{ #category : #accessing }
ToSkinManager >> lookupThemeFrom: anElement [

	^ self localTheme ifNil: [
		  anElement hasParent
			  ifTrue: [ anElement parent toTheme ]
			  ifFalse: [
				  anElement isAttachedToSceneGraph
					  ifTrue: [ " install the theme only if the root is attached to 
						avoid default installation in another element than the space root"
						  self localTheme: ToTheme current.
						  self localTheme ]
					  ifFalse: [ Error signal: 'A not attached element should not ask for its theme' ] ] ]
]

{ #category : #'accessing - skin' }
ToSkinManager >> postponeRequestSkinIn: anElement [

	self isRequestSkinPostponed ifTrue: [ ^ self ].
	postponedRequestSkin := BlEventHandler new.
	postponedRequestSkin eventClass: BlElementAddedToSceneGraphEvent.
	postponedRequestSkin action: [ :evt |
		evt target removeEventHandler: postponedRequestSkin.
		postponedRequestSkin := nil.
		evt target requestSkin ].
	anElement addEventHandler: postponedRequestSkin
]

{ #category : #'accessing - skin' }
ToSkinManager >> requestSkinIn: anElement [

	" first check for the space phases "
	anElement space ifNil: [
		^ self postponeRequestSkinIn: anElement ].
	self skinInstaller ifNotNil: [ 
		^ self ].
	anElement space installSkinPhases.
	self skinInstaller: ToSkinInstaller new
]

{ #category : #'accessing - skin' }
ToSkinManager >> requestUninstallSkinIn: anElement [

	self skinUninstaller ifNotNil: [ 
		^ self ].
	self skinUninstaller: ToSkinUninstaller new
]

{ #category : #'accessing - skin' }
ToSkinManager >> setSkin: aSkin in: anElement [

	anElement requestUninstallSkin.
	defaultSkin := aSkin.
	anElement requestSkin
]

{ #category : #accessing }
ToSkinManager >> skinInstaller [ 

	^ skinInstaller 
]

{ #category : #accessing }
ToSkinManager >> skinInstaller: aSkinInstaller [

	skinInstaller := aSkinInstaller 
]

{ #category : #accessing }
ToSkinManager >> skinStateQueue [

	^ skinStateQueue ifNil: [ skinStateQueue := ToSkinStateQueue new ]
]

{ #category : #accessing }
ToSkinManager >> skinUninstaller [

	^ skinUninstaller
]

{ #category : #accessing }
ToSkinManager >> skinUninstaller: aSkinUninstaller [

	skinUninstaller := aSkinUninstaller 
]

{ #category : #'skin application' }
ToSkinManager >> updateStylesIn: anElement [

	" run the skin actually by flushing the state queue"
	self installedSkinDo: [ :s | s updateStylesIn: anElement ]
]