!classDefinition: #TerniLapilliTest category: 'TerniLapilli'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 10/29/2020 19:23:32'!
test01TerniLapilliXPlaysFirst
	| partida |
	partida _ TerniLapilli newGame.
	self assert: partida isPlayingX.
	self deny: partida isPlayingO.
	self assert: partida countPiecesPlayed equals: 0.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 10/29/2020 18:30:04'!
test02TerniLapilliPlayerOPlaysAfterX
	| partida |
	partida _ TerniLapilli newGame.
	partida putXAt: 0@0.
	self assert: partida isPlayingO.
	self deny: partida isPlayingX.
	self assert: partida countPiecesPlayed equals: 1.
! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 10/29/2020 18:30:14'!
test03TerniLapilliPlayerXPlaysAfterO
	| partida |
	partida _ TerniLapilli newGame.
	partida putXAt: 0@0.
	partida putOAt: 1@0.
	self assert: partida isPlayingX.
	self deny: partida isPlayingO.
	self assert: partida countPiecesPlayed equals: 2.
! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 10/29/2020 18:12:29'!
test04TerniLapilliNewGameNotOver
	| partida |
	partida _ TerniLapilli newGame.
	self deny: partida isOver.
! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 10/29/2020 18:12:41'!
test05TerniLapilliNewGameHasNoWinner
	| partida |
	partida _ TerniLapilli newGame.
	self deny: partida hasPlayerXWon.
	self deny: partida hasPlayerOWon.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 11/1/2020 00:29:10'!
test06CannotPutMoreThan3PiecesPerPlayer
	| partida |
	partida _ TerniLapilli newGame.
	partida putXAt: 0@0.
	partida putOAt: 1@0.
	
	partida putXAt: 0@1.
	partida putOAt: 1@1.
	
	partida putXAt: 2@0.
	partida putOAt: 2@1.
	
	self should: [partida putXAt: 2@2.]
	raise: Error
	withExceptionDo: [:anError | 
		self assert: anError  messageText = TerniLapilli cannotPlaceMoreThan3PiecesError.
		self assert: partida countPiecesPlayed equals: 6.
		].
	
	partida moveXFrom: 0@1 To: 0@2.
	
	self should: [partida putOAt: 2@2.]
	raise: Error
	withExceptionDo: [:anError | 
		self assert: anError  messageText = TerniLapilli cannotPlaceMoreThan3PiecesError.
		self assert: partida countPiecesPlayed equals: 6.
		].
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 10/29/2020 21:27:18'!
test07PlayerOWonByPlacingPieces
	| partida |
	partida _ TerniLapilli newGame.
	partida putXAt: 0@0.
	partida putOAt: 1@0.
	
	partida putXAt: 0@1.
	partida putOAt: 1@1.
	
	partida putXAt: 2@0.
	partida putOAt: 1@2.
	
	self assert: partida isOver.
	self assert: partida hasPlayerOWon.
	self deny: partida hasPlayerXWon.
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 10/29/2020 21:27:23'!
test08PlayerXWonByPlacingPieces
	| partida |
	partida _ TerniLapilli newGame.
	partida putXAt: 0@0.
	partida putOAt: 1@0.
	
	partida putXAt: 0@1.
	partida putOAt: 1@1.
	
	partida putXAt: 0@2.
	
	self assert: partida isOver.
	self deny: partida hasPlayerOWon.
	self assert: partida hasPlayerXWon.
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 10/29/2020 21:26:43'!
test09PlayerXMovesAPieceAndGameContinues
	| partida |
	partida _ TerniLapilli newGame.
	partida putXAt: 0@0.
	partida putOAt: 1@0.
	
	partida putXAt: 0@1.
	partida putOAt: 1@1.
	
	partida putXAt: 2@0.
	partida putOAt: 0@2.
	
	partida moveXFrom: 2@0 To: 2@1.
	
	self deny: partida isOver.
	self assert: partida countPiecesPlayed equals: 6.
	self assert: partida isPlayingO.
	self deny: partida isPlayingX.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 10/29/2020 21:26:51'!
test10PlayerXMovesAPieceAndWins
	| partida |
	partida _ TerniLapilli newGame.
	partida putXAt: 0@0.
	partida putOAt: 1@0.
	
	partida putXAt: 0@1.
	partida putOAt: 1@1.
	
	partida putXAt: 1@2.
	partida putOAt: 2@0.
	
	partida moveXFrom: 1@2 To: 0@2.
	
	self assert: partida isOver.
	self assert: partida hasPlayerXWon.
	self deny: partida hasPlayerOWon.
	self assert: partida countPiecesPlayed equals: 6.
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 10/29/2020 21:23:41'!
test11PlayerOMovesAPieceAndGameContinues
	| partida |
	partida _ TerniLapilli newGame.
	partida putXAt: 0@0.
	partida putOAt: 1@0.
	
	partida putXAt: 0@1.
	partida putOAt: 1@1.
	
	partida putXAt: 2@0.
	partida putOAt: 0@2.
	
	partida moveXFrom: 2@0 To: 2@1.
	partida moveOFrom: 1@1 To: 1@2.
	
	self deny: partida isOver.
	self assert: partida countPiecesPlayed equals: 6.
	self deny: partida isPlayingO.
	self assert: partida isPlayingX.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 10/29/2020 21:25:47'!
test12PlayerOMovesAPieceAndWins
	| partida |
	partida _ TerniLapilli newGame.
	partida putXAt: 0@0.
	partida putOAt: 1@0.
	
	partida putXAt: 0@1.
	partida putOAt: 1@1.
	
	partida putXAt: 2@0.
	partida putOAt: 0@2.
	
	partida moveXFrom: 2@0 To: 2@1.
	partida moveOFrom: 1@0 To: 2@0.
	
	self assert: partida isOver.
	self assert: partida countPiecesPlayed equals: 6.
	self deny: partida hasPlayerXWon .
	self assert: partida hasPlayerOWon .! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 11/1/2020 00:14:58'!
test13PlayerOCannotPutPieceOutOfTurn
	| partida |
	partida _ TerniLapilli newGame.
	partida putXAt: 1@1.
	partida putOAt: 2@2.
	self should: [partida putOAt: 0@0.] 
	raise: Error 
	withExceptionDo: [:anError | 
		self assert: anError messageText = TerniLapilli cannotPlayOutOfTurn.
		self assert: partida countPiecesPlayed = 2.
		self assert: partida isPlayingX.
		self deny: partida isOver.
		].! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 11/1/2020 00:15:18'!
test14PlayerXCannotPutPieceOutOfTurn
	| partida |
	partida _ TerniLapilli newGame.
	partida putXAt: 1@1.
	partida putOAt: 2@2.
	partida putXAt: 0@0.
	self should: [partida putXAt: 0@1.] 
	raise: Error 
	withExceptionDo: [:anError | 
		self assert: anError messageText = TerniLapilli cannotPlayOutOfTurn .
		self assert: partida countPiecesPlayed = 3.
		self assert: partida isPlayingO.
		self deny: partida isOver.
		].! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 10/31/2020 20:10:01'!
test15PlayerXCannotPutPieceInOccupiedPosition
	| partida |
	partida _ TerniLapilli newGame.
	partida putXAt: 1@1.
	partida putOAt: 2@2.
	partida putXAt: 0@0.
	partida putOAt: 0@2.
	self should: [partida putXAt: 2@2.] 
	raise: Error 
	withExceptionDo: [:anError | 
		self assert: anError messageText = TerniLapilli cannotPlacePieceInOccupiedPosition.
		self assert: partida countPiecesPlayed = 4.
		self assert: partida isPlayingX.
		self deny: partida isOver.
		].
	self should: [partida putXAt: 1@1.] 
	raise: Error 
	withExceptionDo: [:anError | 
		self assert: anError messageText = TerniLapilli cannotPlacePieceInOccupiedPosition.
		self assert: partida countPiecesPlayed = 4.
		self assert: partida isPlayingX.
		self deny: partida isOver.
		].! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 10/31/2020 20:13:00'!
test16PlayerOCannotPutPieceInOccupiedPosition
	| partida |
	partida _ TerniLapilli newGame.
	partida putXAt: 0@2.
	partida putOAt: 2@2.
	partida putXAt: 2@0.
	partida putOAt: 1@2.
	partida putXAt: 0@0.
	self should: [partida putOAt: 0@2.] 
	raise: Error 
	withExceptionDo: [:anError | 
		self assert: anError messageText = TerniLapilli cannotPlacePieceInOccupiedPosition.
		self assert: partida countPiecesPlayed = 5.
		self assert: partida isPlayingO.
		self deny: partida isOver.
		].
	self should: [partida putOAt: 2@2.] 
	raise: Error 
	withExceptionDo: [:anError | 
		self assert: anError messageText = TerniLapilli cannotPlacePieceInOccupiedPosition.
		self assert: partida countPiecesPlayed = 5.
		self assert: partida isPlayingO.
		self deny: partida isOver.
		].! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 10/31/2020 20:24:18'!
test17PlayerOCannotMoveBeforePlacing3Pieces
	| partida |
	partida _ TerniLapilli newGame.
	partida putXAt: 0@2.
	partida putOAt: 2@2.
	partida putXAt: 2@0.
	partida putOAt: 1@2.
	partida putXAt: 0@0.
	self should: [partida moveOFrom: 1@2 To: 0@2.] 
	raise: Error 
	withExceptionDo: [:anError | 
		self assert: anError messageText = TerniLapilli cannotMovePieceBeforePlacingAllPieces.
		self assert: partida isPlayingO.
		self deny: partida isOver.
		].! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 10/31/2020 20:28:10'!
test18PlayerXCannotMoveBeforePlacing3Pieces
	| partida |
	partida _ TerniLapilli newGame.
	partida putXAt: 0@2.
	partida putOAt: 2@2.
	partida putXAt: 2@0.
	partida putOAt: 1@2.
	self should: [partida moveXFrom: 2@0 To: 1@0.] 
	raise: Error 
	withExceptionDo: [:anError | 
		self assert: anError messageText = TerniLapilli cannotMovePieceBeforePlacingAllPieces.
		self assert: partida isPlayingX.
		self deny: partida isOver.
		].! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 10/31/2020 20:34:13'!
test19PlayersCannotPlacePieceOutsideBoard
	| partida |
	partida _ TerniLapilli newGame.
	self should: [partida putXAt: (-1@0)] 
	raise: Error 
	withExceptionDo: [:anError | 
		self assert: anError messageText = TerniLapilli cannotPlacePiecesOutsideBoard.
		self assert: partida countPiecesPlayed equals: 0.
		self assert: partida isPlayingX.
		self deny: partida isOver.
		].
	
	partida putXAt: 0@2.
	
	self should: [partida putOAt: (-1@0)] 
	raise: Error 
	withExceptionDo: [:anError | 
		self assert: anError messageText = TerniLapilli cannotPlacePiecesOutsideBoard.
		self assert: partida countPiecesPlayed equals: 1.
		self assert: partida isPlayingO.
		self deny: partida isOver.
		].
	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 11/1/2020 00:12:30'!
test20PlayersCannotMovePieceOutsideBoard
	| partida |
	partida _ TerniLapilli newGame.
	partida putXAt: 0@0.
	partida putOAt: 1@0.
	partida putXAt: 0@1.
	partida putOAt: 1@1.
	partida putXAt: 2@0.
	partida putOAt: 0@2.
	
	self should: [partida moveXFrom: 0@0 To: -1@0 ] 
	raise: Error 
	withExceptionDo: [:anError | 
		self assert: anError messageText = TerniLapilli cannotPlacePiecesOutsideBoard.
		self assert: partida isPlayingX.
		self deny: partida isOver.
		].
	
	partida moveXFrom: 2@0 To: 2@1.

	self should: [partida moveOFrom: (1@0) To: (1@-1)] 
	raise: Error 
	withExceptionDo: [:anError | 
		self assert: anError messageText = TerniLapilli cannotPlacePiecesOutsideBoard.
		self assert: partida isPlayingO.
		self deny: partida isOver.
		].
	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 10/31/2020 20:51:06'!
test21PlayersCanOnlyMoveOwnedPieces
	| partida |
	partida _ TerniLapilli newGame.
	partida putXAt: 0@0.
	partida putOAt: 1@0.
	partida putXAt: 0@1.
	partida putOAt: 1@1.
	partida putXAt: 2@0.
	partida putOAt: 0@2.
	
	self should: [partida moveXFrom: 0@2 To: 1@2 ] 
	raise: Error 
	withExceptionDo: [:anError | 
		self assert: anError messageText = TerniLapilli cannotMovePiecesPlayerDoesntOwn.
		self assert: partida isPlayingX.
		self deny: partida isOver.
		].
	
	partida moveXFrom: 2@0 To: 2@1.

	self should: [partida moveOFrom: (1@-1) To: (1@0)] 
	raise: Error 
	withExceptionDo: [:anError | 
		self assert: anError messageText = TerniLapilli cannotMovePiecesPlayerDoesntOwn.
		self assert: partida isPlayingO.
		self deny: partida isOver.
		].
	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 11/1/2020 00:12:10'!
test22PlayerXCannotMovePieceToOccupiedPosition
	| partida |
	partida _ TerniLapilli newGame.
	partida putXAt: 0@0.
	partida putOAt: 1@0.
	partida putXAt: 0@1.
	partida putOAt: 1@1.
	partida putXAt: 2@0.
	partida putOAt: 0@2.
	
	self should: [partida moveXFrom: 0@0 To: 1@0 ] 
	raise: Error 
	withExceptionDo: [:anError | 
		self assert: anError messageText = TerniLapilli cannotPlacePieceInOccupiedPosition.
		self assert: partida isPlayingX.
		self deny: partida isOver.
		].

	self should: [partida moveXFrom: 0@0 To: 0@1] 
	raise: Error 
	withExceptionDo: [:anError | 
		self assert: anError messageText = TerniLapilli cannotPlacePieceInOccupiedPosition.
		self assert: partida isPlayingX.
		self deny: partida isOver.
		].
	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 11/1/2020 00:11:51'!
test23PlayerOCannotMovePieceToOccupiedPosition
	| partida |
	partida _ TerniLapilli newGame.
	partida putXAt: 0@0.
	partida putOAt: 1@0.
	partida putXAt: 0@1.
	partida putOAt: 1@1.
	partida putXAt: 2@0.
	partida putOAt: 0@2.
	partida moveXFrom: 2@0 To: 2@1.
	
	self should: [partida moveOFrom: 1@0 To: 0@0 ] 
	raise: Error 
	withExceptionDo: [:anError | 
		self assert: anError messageText = TerniLapilli cannotPlacePieceInOccupiedPosition .
		self assert: partida isPlayingO.
		self deny: partida isOver.
		].

	self should: [partida moveOFrom: 1@0 To: 1@1] 
	raise: Error 
	withExceptionDo: [:anError | 
		self assert: anError messageText = TerniLapilli cannotPlacePieceInOccupiedPosition .
		self assert: partida isPlayingO.
		self deny: partida isOver.
		].
	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 10/31/2020 23:17:23'!
test24PlayerXCanOnlyMoveToNeighbour
	| partida |
	partida _ TerniLapilli newGame.
	partida putXAt: 0@0.
	partida putOAt: 1@0.
	partida putXAt: 0@1.
	partida putOAt: 1@1.
	partida putXAt: 2@0.
	partida putOAt: 0@2.
	
	self should: [partida moveXFrom: 0@0 To: 1@2 ] 
	raise: Error 
	withExceptionDo: [:anError | 
		self assert: anError messageText = TerniLapilli cannotMovePieceMoreThanOneSpace.
		self assert: partida isPlayingX.
		self deny: partida isOver.
		].
	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 10/31/2020 23:21:40'!
test25PlayerOCanOnlyMoveToNeighbour
	| partida |
	partida _ TerniLapilli newGame.
	partida putXAt: 0@0.
	partida putOAt: 1@0.
	partida putXAt: 0@1.
	partida putOAt: 1@1.
	partida putXAt: 2@0.
	partida putOAt: 0@2.
	partida moveXFrom: 2@0 To: 2@1.
	
	self should: [partida moveOFrom: 1@0 To: 2@2 ] 
	raise: Error 
	withExceptionDo: [:anError | 
		self assert: anError messageText = TerniLapilli cannotMovePieceMoreThanOneSpace .
		self assert: partida isPlayingO.
		self deny: partida isOver.
		].
	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 11/1/2020 00:16:20'!
test26PlayerXCannotMoveByInvalidDiagonal
	| partida |
	partida _ TerniLapilli newGame.
	partida putXAt: 0@0.
	partida putOAt: 1@2.
	partida putXAt: 0@1.
	partida putOAt: 1@1.
	partida putXAt: 2@0.
	partida putOAt: 0@2.
	
	self should: [partida moveXFrom: 0@1 To: 1@0 ] 
	raise: Error 
	withExceptionDo: [:anError | 
		self assert: anError messageText = TerniLapilli cannotMovePieceByInvalidDiagonal.
		self assert: partida isPlayingX.
		self deny: partida isOver.
		].
	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 10/31/2020 23:27:43'!
test27PlayerOCannotMoveByInvalidDiagonal
	| partida |
	partida _ TerniLapilli newGame.
	partida putXAt: 0@0.
	partida putOAt: 0@1.
	partida putXAt: 1@1.
	partida putOAt: 2@1.
	partida putXAt: 0@2.
	partida putOAt: 1@0.
	partida moveXFrom: 1@1 To: 2@0.
	
	self should: [partida moveOFrom: 2@1 To: 1@2 ] 
	raise: Error 
	withExceptionDo: [:anError | 
		self assert: anError messageText = TerniLapilli cannotMovePieceByInvalidDiagonal .
		self assert: partida isPlayingO.
		self deny: partida isOver.
		].
	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 11/1/2020 00:17:28'!
test28PlayerOCannotMoveOutOfTurn
	| partida |
	partida _ TerniLapilli newGame.
	partida putXAt: 0@0.
	partida putOAt: 1@2.
	partida putXAt: 0@1.
	partida putOAt: 1@1.
	partida putXAt: 2@0.
	partida putOAt: 0@2.
	
	self should: [partida moveOFrom: 1@2 To: 2@2 ] 
	raise: Error 
	withExceptionDo: [:anError | 
		self assert: anError messageText = TerniLapilli cannotPlayOutOfTurn .
		self assert: partida isPlayingX.
		self deny: partida isOver.
		].
	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 11/1/2020 00:18:47'!
test29PlayerXCannotMoveOutOfTurn
	| partida |
	partida _ TerniLapilli newGame.
	partida putXAt: 0@0.
	partida putOAt: 0@1.
	partida putXAt: 1@1.
	partida putOAt: 2@1.
	partida putXAt: 0@2.
	partida putOAt: 1@0.
	partida moveXFrom: 1@1 To: 2@0.
	
	self should: [partida moveXFrom: 2@0 To: 1@1 ] 
	raise: Error 
	withExceptionDo: [:anError | 
		self assert: anError messageText = TerniLapilli cannotPlayOutOfTurn.
		self assert: partida isPlayingO.
		self deny: partida isOver.
		].
	
	! !


!classDefinition: #TerniLapilli category: 'TerniLapilli'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'isXTurn piecesX piecesO gameEnded xIsWinner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilli methodsFor: 'testing' stamp: 'EMI 10/29/2020 19:21:52'!
countPiecesPlayed
	^piecesX size + piecesO size.! !

!TerniLapilli methodsFor: 'testing' stamp: 'EMI 10/29/2020 20:28:10'!
hasPlayerOWon
	^gameEnded and: [xIsWinner not].! !

!TerniLapilli methodsFor: 'testing' stamp: 'EMI 10/29/2020 20:27:37'!
hasPlayerXWon
	^gameEnded and: [xIsWinner].! !

!TerniLapilli methodsFor: 'testing' stamp: 'EMI 10/29/2020 20:25:45'!
isOver
	^gameEnded.! !

!TerniLapilli methodsFor: 'testing' stamp: 'EMI 10/29/2020 18:33:46'!
isPlayingO
	^isXTurn not.! !

!TerniLapilli methodsFor: 'testing' stamp: 'EMI 10/29/2020 18:33:35'!
isPlayingX
	^isXTurn.! !


!TerniLapilli methodsFor: 'player actions' stamp: 'EMI 10/29/2020 20:58:58'!
checkDiagonalLine: aPiecesCollection
	|center diagonalInversa diagonal |
	
	(aPiecesCollection includes: 1@1) ifFalse:[^false.].
	
	center _ 1@1.
	
	diagonal  _ (aPiecesCollection includes: (center + (1@1))) and: [aPiecesCollection includes: center - (1@1)].
	diagonalInversa _ (aPiecesCollection includes: (center + (1@-1))) and: [aPiecesCollection includes: center + (-1@1)].
	
	^diagonal or:[diagonalInversa].! !

!TerniLapilli methodsFor: 'player actions' stamp: 'EMI 10/29/2020 20:58:06'!
checkHorizontalLine: aPiecesCollection
	|first estanALaIzq estanALaDer estanAmbosLados|
	first _ aPiecesCollection first.
	
	estanAmbosLados  _ (aPiecesCollection includes: (first + (0@1))) and: [aPiecesCollection includes: first - (0@1)].
	estanALaDer _ (aPiecesCollection includes: (first + (0@1))) and: [aPiecesCollection includes: first + (0@2)].
	estanALaIzq _ (aPiecesCollection includes: (first - (0@1))) and: [aPiecesCollection includes: first - (0@2)].
	
	^estanAmbosLados or:[estanALaDer or:[estanALaIzq]].! !

!TerniLapilli methodsFor: 'player actions' stamp: 'EMI 11/1/2020 00:13:03'!
checkIfMoveFrom: aOriginPosition isValidTo: anEmptyDestinationPosition
	| invalidDiagonalPositions |
	invalidDiagonalPositions _ OrderedCollection with: (1@0) with: (0@1)  with:(1@2) with:(2@1).
	
	(aOriginPosition eightNeighbors includes: anEmptyDestinationPosition) ifFalse:[^Error signal: self class 	cannotMovePieceMoreThanOneSpace ].
	
	((invalidDiagonalPositions includes: aOriginPosition) and:[invalidDiagonalPositions includes: anEmptyDestinationPosition ]) ifTrue:[^Error signal: self class cannotMovePieceByInvalidDiagonal ].
! !

!TerniLapilli methodsFor: 'player actions' stamp: 'EMI 10/29/2020 20:52:40'!
checkIfPlayerOWon
	xIsWinner _ ((self checkHorizontalLine: piecesO) or: [(self checkVerticalLine: piecesO) or:[self checkDiagonalLine: piecesO]]) not.
	gameEnded _ xIsWinner not.! !

!TerniLapilli methodsFor: 'player actions' stamp: 'EMI 10/29/2020 20:52:21'!
checkIfPlayerXWon
	xIsWinner _ (self checkHorizontalLine: piecesX) or: [(self checkVerticalLine: piecesX) or:[self checkDiagonalLine: piecesX]].
	gameEnded _ xIsWinner.! !

!TerniLapilli methodsFor: 'player actions' stamp: 'EMI 10/29/2020 20:58:35'!
checkVerticalLine: aPiecesCollection
	|first estanArriba estanAbajo estanAmbosLados|
	first _ aPiecesCollection first.
	
	estanAmbosLados  _ (aPiecesCollection includes: (first + (1@0))) and: [aPiecesCollection includes: first - (1@0)].
	estanAbajo _ (aPiecesCollection includes: (first + (1@0))) and: [aPiecesCollection includes: first + (2@0)].
	estanArriba _ (aPiecesCollection includes: (first - (1@0))) and: [aPiecesCollection includes: first - (2@0)].
	
	^estanAmbosLados or:[estanAbajo or:[estanArriba]].! !

!TerniLapilli methodsFor: 'player actions' stamp: 'EMI 11/1/2020 00:43:23'!
doPlayerOAction: aBlock
	isXTurn ifTrue: [^Error signal: self class cannotPlayOutOfTurn ].
	
	aBlock value.
	
	isXTurn _ true.
	self checkIfPlayerOWon.

	! !

!TerniLapilli methodsFor: 'player actions' stamp: 'EMI 11/1/2020 00:40:33'!
doPlayerXAction: aBlock
	isXTurn ifFalse: [^Error signal: self class cannotPlayOutOfTurn ].
	
	aBlock value.
	
	isXTurn _ false.
	self checkIfPlayerXWon.! !

!TerniLapilli methodsFor: 'player actions' stamp: 'EMI 11/1/2020 00:04:51'!
hasEnoughPiecesToMove: aPiecesCollection
	aPiecesCollection size < 3 ifTrue: [^Error signal: self class cannotMovePieceBeforePlacingAllPieces ].! !

!TerniLapilli methodsFor: 'player actions' stamp: 'EMI 11/1/2020 00:23:37'!
hasRemainingPiecesToPlace: aPiecesCollection
	aPiecesCollection size = 3 ifTrue: [^Error signal: self class cannotPlaceMoreThan3PiecesError ].! !

!TerniLapilli methodsFor: 'player actions' stamp: 'EMI 10/31/2020 20:37:59'!
isInsideBoard: aPosition
	^ ((aPosition x) between: 0 and: 2) and: [(aPosition y) between: 0 and: 2].! !

!TerniLapilli methodsFor: 'player actions' stamp: 'EMI 11/1/2020 00:14:12'!
isPositionEmpty: aPosition
	((piecesO includes: aPosition ) or: [piecesX includes: aPosition ]) ifTrue: [^Error signal: self class cannotPlacePieceInOccupiedPosition ].
! !

!TerniLapilli methodsFor: 'player actions' stamp: 'EMI 11/1/2020 00:43:58'!
moveOFrom: aOriginPosition To: aDestinationPosition
	self doPlayerOAction: [self movePieceOf: piecesO From: aOriginPosition To: aDestinationPosition].
! !

!TerniLapilli methodsFor: 'player actions' stamp: 'EMI 11/1/2020 00:13:18'!
movePieceOf: aPiecesCollection From: aOriginPosition To: aDestinationPosition
	self hasEnoughPiecesToMove: aPiecesCollection.
	(self isInsideBoard: aDestinationPosition ) ifFalse:[^Error signal: self class cannotPlacePiecesOutsideBoard ].
	(aPiecesCollection includes: aOriginPosition) ifFalse: [^Error signal: self class cannotMovePiecesPlayerDoesntOwn].
	self isPositionEmpty: aDestinationPosition.
	self checkIfMoveFrom: aOriginPosition isValidTo: aDestinationPosition.
	
	aPiecesCollection remove: aOriginPosition.
	aPiecesCollection add: aDestinationPosition.! !

!TerniLapilli methodsFor: 'player actions' stamp: 'EMI 11/1/2020 00:41:42'!
moveXFrom: aOriginPosition To: aDestinationPosition
	self doPlayerXAction: [ self movePieceOf: piecesX From: aOriginPosition To: aDestinationPosition].! !

!TerniLapilli methodsFor: 'player actions' stamp: 'EMI 11/1/2020 00:31:37'!
put: aPosition into: aPiecesCollection
	self hasRemainingPiecesToPlace: aPiecesCollection .
	(self isInsideBoard: aPosition) ifFalse:[^Error signal: self class cannotPlacePiecesOutsideBoard ].
	self isPositionEmpty: aPosition.
	aPiecesCollection add: aPosition.! !

!TerniLapilli methodsFor: 'player actions' stamp: 'EMI 11/1/2020 00:43:40'!
putOAt: aPosition
	self doPlayerOAction: [self put: aPosition into: piecesO].


	! !

!TerniLapilli methodsFor: 'player actions' stamp: 'EMI 11/1/2020 00:41:13'!
putXAt: aPosition
	self doPlayerXAction:[self put: aPosition into: piecesX].! !


!TerniLapilli methodsFor: 'private' stamp: 'EMI 10/29/2020 20:54:28'!
initialize
	isXTurn _ true.
	piecesX _ OrderedCollection new.
	piecesO _ OrderedCollection new.
	gameEnded _ false.
	xIsWinner _ false.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: 'TerniLapilli'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'initialization' stamp: 'EMI 10/29/2020 18:33:58'!
newGame
	^self new initialize .! !


!TerniLapilli class methodsFor: 'error messages' stamp: 'EMI 10/31/2020 20:25:03'!
cannotMovePieceBeforePlacingAllPieces
	^'Cannot move piece before placing all pieces'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'EMI 10/31/2020 23:28:04'!
cannotMovePieceByInvalidDiagonal
	^'Cannot move piece by invalid diagonal'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'EMI 10/31/2020 23:17:49'!
cannotMovePieceMoreThanOneSpace
	^'Cannot move piece more than one space'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'EMI 10/31/2020 20:51:43'!
cannotMovePiecesPlayerDoesntOwn
	^'Player doesnt have a piece in that position'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'EMI 10/29/2020 18:48:51'!
cannotPlaceMoreThan3PiecesError
	^'Cannot place more than 3 pieces per player'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'EMI 10/31/2020 20:25:24'!
cannotPlacePieceInOccupiedPosition
	^'Cannot place piece in occupied position'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'EMI 10/31/2020 20:34:50'!
cannotPlacePiecesOutsideBoard
	^'Cannot place piece outside board'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'EMI 11/1/2020 00:09:33'!
cannotPlayOutOfTurn
	^'Cannot place piece out of turn'.! !
