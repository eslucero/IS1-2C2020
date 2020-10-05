!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:48'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'first'.
	secondPushedObject := 'second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'EMI 10/4/2020 19:11:15'!
test01FindDeUnStackVacioEsVacio
	|finder|	
	self assert: (finder find:'a' isEmpty).! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'EMI 10/4/2020 18:49:11'!
test02FindDePrefijoVacioDevuelveError
	| finder |
	
	self should: [finder find:''] 
	      raise: Error 
	      withExceptionDo:[:anError | anError messageText = SentenceFinderByPrefix class messageEmptyPrefixError].
		! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'EMI 10/4/2020 18:56:31'!
test03FindEsCaseSensitive
	| finder |
	
	self assert: (finder find:'a' isEmpty).
	self assert: (finder find:'B' isEmpty).
	
	self deny: (finder find:'A' isEmpty).
	self deny: (finder find:'b' isEmpty).! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'EMI 10/4/2020 18:52:11'!
test04FindDePrefijoConEspaciosDevuelveError
	| finder |
	
	self should: [finder find:' '] 
	      raise: Error 
	      withExceptionDo:[:anError | anError messageText = SentenceFinderByPrefix class messageHasEmptySpacesError].
	
	self should: [finder find:'a a'] 
	      raise: Error 
	      withExceptionDo:[:anError | anError messageText = SentenceFinderByPrefix class messageHasEmptySpacesError].! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'EMI 10/4/2020 19:00:49'!
test05FindNoModificaElStack
	| finder stack datos|
	
	datos _ #('hola' 'chau' 'chaucha').
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'EMI 10/4/2020 19:06:22'!
test06FindDeUnPrefijoPresenteYUnicoLoDevuelve
	|finder result|
	result _ finder find:'a'.
	self deny: result isEmpty.
	self assert: result size = 1.
	self assert: 'a' isPrefix: (result first).! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'EMI 10/4/2020 19:09:37'!
test07FindDeUnPrefijoPresenteLosDevuelve
	|finder apariciones result |
	result _ finder find:'a'.
	self deny: result isEmpty.
	self assert: result size = apariciones.
	result collect:[:aString | self assert: 'a' isPrefix: aString].! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'EMI 10/4/2020 19:10:35'!
test08FindDeUnPrefijoAusenteDevuelveVacio
	|finder|
	self assert: (finder find:'a' isEmpty).! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'topNode stackSize'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'EMI 10/4/2020 18:00:45'!
initialize
	topNode _ NullStackNode new.
	stackSize  _ 0.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'EMI 10/4/2020 18:07:41'!
isEmpty
	^stackSize = 0.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'EMI 10/4/2020 18:05:40'!
pop
	|data|
	data _ topNode getData.
	topNode _ topNode nextNode.
	stackSize _ stackSize - 1.
	^data.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'EMI 10/4/2020 18:15:58'!
push: anObjectToPush
	topNode _ ValidStackNode with: anObjectToPush nextNode: topNode.
	stackSize _ stackSize + 1.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'EMI 10/4/2020 17:59:50'!
size
	^stackSize.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'EMI 10/4/2020 18:01:27'!
top
	^topNode getData! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 10/1/2020 18:08:13'!
stackEmptyErrorDescription
	
	^ 'Stack is empty!!'! !


!OOStack class methodsFor: 'as yet unclassified' stamp: 'EMI 10/4/2020 17:25:47'!
new
	^super new initialize.! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'error-messages' stamp: 'EMI 10/4/2020 18:50:08'!
messageEmptyPrefixError
	^'Prefix cannot be empty!!'.! !

!SentenceFinderByPrefix class methodsFor: 'error-messages' stamp: 'EMI 10/4/2020 18:55:06'!
messageHasEmptySpacesError
	^'Prefix cannot have empty spaces!!'.! !


!classDefinition: #StackNode category: 'Stack-Exercise'!
Object subclass: #StackNode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackNode methodsFor: 'as yet unclassified' stamp: 'EMI 10/4/2020 18:04:24'!
getData
	^self subclassResponsibility.! !

!StackNode methodsFor: 'as yet unclassified' stamp: 'EMI 10/4/2020 18:05:21'!
nextNode
	^self subclassResponsibility.! !


!classDefinition: #NullStackNode category: 'Stack-Exercise'!
StackNode subclass: #NullStackNode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!NullStackNode methodsFor: 'as yet unclassified' stamp: 'EMI 10/4/2020 18:07:10'!
getData
	^Error signal: OOStack stackEmptyErrorDescription.! !

!NullStackNode methodsFor: 'as yet unclassified' stamp: 'EMI 10/4/2020 18:08:59'!
nextNode
	^Error signal: OOStack stackEmptyErrorDescription.! !


!classDefinition: #ValidStackNode category: 'Stack-Exercise'!
StackNode subclass: #ValidStackNode
	instanceVariableNames: 'data next'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!ValidStackNode methodsFor: 'as yet unclassified' stamp: 'EMI 10/4/2020 18:13:27'!
getData
	^data.! !

!ValidStackNode methodsFor: 'as yet unclassified' stamp: 'EMI 10/4/2020 18:12:53'!
initialize: anObject withNextNode: previousTopNode
	data _ anObject.
	next _ previousTopNode.! !

!ValidStackNode methodsFor: 'as yet unclassified' stamp: 'EMI 10/4/2020 18:13:37'!
nextNode
	^next.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ValidStackNode class' category: 'Stack-Exercise'!
ValidStackNode class
	instanceVariableNames: ''!

!ValidStackNode class methodsFor: 'as yet unclassified' stamp: 'EMI 10/4/2020 18:11:34'!
with: anObject nextNode: previousTopNode
	^super new initialize: anObject withNextNode: previousTopNode.! !
