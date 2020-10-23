!classDefinition: #MarsRoverTests category: 'EjercicioMarsRover'!
TestCase subclass: #MarsRoverTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'EjercicioMarsRover'!

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'EMI 10/23/2020 19:24:00'!
test01
	| rover |
	rover _ MarsRover at: 1@1 withOrientation: $N.
	self assert: (rover position = (1@1)).
	self assert: (rover orientation = $N).! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'EMI 10/23/2020 19:30:53'!
test02
	| rover |
	rover _ MarsRover at: 1@1 withOrientation: $N.
	rover receiveInstructions: ''.
	self assert: (rover position = (1@1)).
	self assert: (rover orientation = $N).! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'EMI 10/23/2020 19:35:19'!
test03
	| rover |
	rover _ MarsRover at: 1@1 withOrientation: $N.
	rover receiveInstructions: 'f'.
	self assert: (rover position = (0@1)).
	self assert: (rover orientation = $N).! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'EMI 10/23/2020 19:38:11'!
test04
	| rover |
	rover _ MarsRover at: 1@1 withOrientation: $N.
	rover receiveInstructions: 'b'.
	self assert: (rover position = (2@1)).
	self assert: (rover orientation = $N).! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'EMI 10/23/2020 19:41:38'!
test05
	| rover |
	rover _ MarsRover at: 1@1 withOrientation: $N.
	rover receiveInstructions: 'l'.
	self assert: (rover position = (1@1)).
	self assert: (rover orientation = $W).! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'EMI 10/23/2020 19:45:11'!
test06
	| rover |
	rover _ MarsRover at: 1@1 withOrientation: $N.
	rover receiveInstructions: 'r'.
	self assert: (rover position = (1@1)).
	self assert: (rover orientation = $E).! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'EMI 10/23/2020 19:55:08'!
test07
	| rover |
	rover _ MarsRover at: 1@1 withOrientation: $N.
	rover receiveInstructions: 'ff'.
	self assert: (rover position = (-1@1)).
	self assert: (rover orientation = $N).! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'EMI 10/23/2020 20:04:00'!
test08
	| rover |
	rover _ MarsRover at: 1@1 withOrientation: $N.
	rover receiveInstructions: 'bb'.
	self assert: (rover position = (3@1)).
	self assert: (rover orientation = $N).! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'EMI 10/23/2020 20:05:19'!
test09
	| rover |
	rover _ MarsRover at: 1@1 withOrientation: $N.
	rover receiveInstructions: 'll'.
	self assert: (rover position = (1@1)).
	self assert: (rover orientation = $S).! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'EMI 10/23/2020 20:24:42'!
test10
	| rover |
	rover _ MarsRover at: 1@1 withOrientation: $N.
	rover receiveInstructions: 'rr'.
	self assert: (rover position = (1@1)).
	self assert: (rover orientation = $S).! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'EMI 10/23/2020 20:30:06'!
test11
	| rover |
	rover _ MarsRover at: 1@1 withOrientation: $N.
	rover receiveInstructions: 'er'.
	self assert: (rover position = (1@1)).
	self assert: (rover orientation = $N).! !


!classDefinition: #MarsRover category: 'EjercicioMarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position orientation rotationsCounterClockwise rotationsClockwise'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'EjercicioMarsRover'!

!MarsRover methodsFor: 'initialize' stamp: 'EMI 10/23/2020 20:26:42'!
initializeAt: aPoint withOrientation: aCardinal 
	position _ aPoint.
	orientation _ aCardinal.
	
	rotationsCounterClockwise _ Dictionary new.
	rotationsCounterClockwise at:$N put:$W.
	rotationsCounterClockwise at:$W put:$S.
	rotationsCounterClockwise at:$S put:$E.
	rotationsCounterClockwise at:$E put:$N.
	
	rotationsClockwise _ Dictionary new.
	rotationsClockwise at:$N put:$E.
	rotationsClockwise at:$E put:$S.
	rotationsClockwise at:$S put:$W.
	rotationsClockwise at:$W put:$N.! !


!MarsRover methodsFor: 'accessing' stamp: 'EMI 10/23/2020 19:28:06'!
orientation
	^orientation.! !

!MarsRover methodsFor: 'accessing' stamp: 'EMI 10/23/2020 19:27:32'!
position
	^position! !


!MarsRover methodsFor: 'instructions' stamp: 'EMI 10/23/2020 20:27:06'!
receiveInstructions: anInstructionsString
	anInstructionsString isEmpty 
	ifFalse:[
		anInstructionsString do: [:aCharacter |
			aCharacter = $f ifTrue: [position _ ((position x -1)@position y)].
			aCharacter = $b ifTrue: [position _ ((position x +1)@position y)].
			aCharacter = $l ifTrue: [orientation _ rotationsCounterClockwise at: orientation ].
			aCharacter = $r ifTrue: [orientation _ rotationsClockwise at: orientation ].
		].
	].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'EjercicioMarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'EMI 10/23/2020 19:25:26'!
at: aPoint withOrientation: aCardinal
	^self new initializeAt: aPoint withOrientation: aCardinal. ! !
