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

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'EMI 10/5/2020 21:09:40'!
test01FindDeUnStackVacioEsVacio
	|finder stack|	
	stack _ OOStack new.
	finder _ SentenceFinderByPrefix with: stack.
	self assert: (finder find:'a') isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'EMI 10/5/2020 21:51:33'!
test02FindDePrefijoVacioDevuelveError
	|finder stack|	
	stack _ OOStack new.
	finder _ SentenceFinderByPrefix with: stack.
	self should: [finder find:''] 
	      raise: Error 
	      withExceptionDo:[:anError | anError messageText = SentenceFinderByPrefix messageEmptyPrefixError].
		! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'EMI 10/7/2020 18:40:06'!
test03FindEsCaseSensitive
	|finder stack|	
	stack _ OOStack new.
	stack push: 'AbA'.
	stack push: 'bAb'.
	finder _ SentenceFinderByPrefix with: stack.
	
	self assert: (finder find:'aBa') isEmpty.
	self assert: (finder find:'BaB') isEmpty.
	
	self deny: (finder find:'Ab') isEmpty.
	self deny: (finder find:'bA') isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'EMI 10/5/2020 21:51:45'!
test04FindDePrefijoConEspaciosDevuelveError
	|finder stack|	
	stack _ OOStack new.
	finder _ SentenceFinderByPrefix with: stack.
	self should: [finder find:' '] 
	      raise: Error 
	      withExceptionDo:[:anError | anError messageText = SentenceFinderByPrefix messageHasEmptySpacesError].
	self should: [finder find:'aa '] 
	      raise: Error 
	      withExceptionDo:[:anError | anError messageText = SentenceFinderByPrefix messageHasEmptySpacesError].
	self should: [finder find:' aa'] 
	      raise: Error 
	      withExceptionDo:[:anError | anError messageText = SentenceFinderByPrefix messageHasEmptySpacesError].
	self should: [finder find:'a a'] 
	      raise: Error 
	      withExceptionDo:[:anError | anError messageText = SentenceFinderByPrefix messageHasEmptySpacesError].! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'EMI 10/7/2020 18:00:38'!
test05FindNoModificaElStack
	| finder stackToFind validationStack |	
	validationStack _ OOStack new.
	validationStack push: 'a'; push: 'aa'; push: 'aaa'.
	
	stackToFind _ OOStack new.
	stackToFind push: 'a';push: 'aa'; push: 'aaa'.
	
	finder _ SentenceFinderByPrefix with: stackToFind.
	finder find:'a'.
	
	self assert:(stackToFind isEmpty = validationStack isEmpty).
	self assert:(stackToFind size = validationStack size).
	3 timesRepeat: [self assert:(stackToFind pop = validationStack pop)].
	self assert:(stackToFind isEmpty = validationStack isEmpty).
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'EMI 10/7/2020 18:05:20'!
test06FindDeUnPrefijoPresenteYUnicoLoDevuelve
	|finder stack result|	
	stack _ OOStack new.
	stack push:'a';push:'fdfg';push:'sdsdsdadafg'.
	
	finder _ SentenceFinderByPrefix with: stack.
	result _ finder find:'a'.
	
	self deny: result isEmpty.
	self assert: result size = 1.
	self assert: ((result first) = 'a').! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'EMI 10/7/2020 18:37:21'!
test07FindDeUnPrefijoPresenteLosDevuelve
	|finder stack result resultAsBag apariciones|	
	stack _ OOStack new.
	stack push:'a';push:'aa';push:'ababa';push:'zszszszs'.
	apariciones _ 3.
	
	finder _ SentenceFinderByPrefix with: stack.
	result _ finder find:'a'.
	
	self deny: result isEmpty.
	self assert: result size = apariciones.
	result do:[:aString | self assert: (aString beginsWith: 'a')].
	resultAsBag _ result asBag.
	#('a' 'aa' 'ababa') do:[:aString | self assert: (resultAsBag occurrencesOf: aString) = 1].! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'EMI 10/5/2020 21:18:09'!
test08FindDeUnPrefijoAusenteDevuelveVacio
	|finder stack |	
	stack _ OOStack new.
	stack push:'ba'.
	stack push:'baa'.
	stack push:'bababa'.
	finder _ SentenceFinderByPrefix with: stack.
	self assert: (finder find:'a') isEmpty.! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'topBlock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'private' stamp: 'EMI 10/5/2020 21:38:04'!
initialize
	topBlock _ BaseStackableBlock new.! !


!OOStack methodsFor: 'accessing' stamp: 'EMI 10/5/2020 21:37:57'!
isEmpty
	^self size = 0.! !

!OOStack methodsFor: 'accessing' stamp: 'EMI 10/5/2020 21:37:32'!
size
	^topBlock countBlocksUnder.! !

!OOStack methodsFor: 'accessing' stamp: 'EMI 10/5/2020 21:02:05'!
top
	^topBlock getContainedObject.! !


!OOStack methodsFor: 'adding-removing' stamp: 'EMI 10/5/2020 21:37:48'!
pop
	|data|
	data _ topBlock getContainedObject.
	topBlock _ topBlock nextBlock.
	^data.! !

!OOStack methodsFor: 'adding-removing' stamp: 'EMI 10/5/2020 21:37:41'!
push: anObjectToPush
	topBlock _ FilledStackableBlock with: anObjectToPush nextBlock: topBlock.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 10/1/2020 18:08:13'!
stackEmptyErrorDescription
	
	^ 'Stack is empty!!'! !


!OOStack class methodsFor: 'initialization' stamp: 'EMI 10/4/2020 17:25:47'!
new
	^super new initialize.! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'EMI 10/5/2020 21:08:57'!
with: aStackToSearch
	stack _ aStackToSearch.
	! !


!SentenceFinderByPrefix methodsFor: 'operations' stamp: 'EMI 10/5/2020 22:02:03'!
find: aPrefix
	| tempStack resultCollection|
	(aPrefix = '') ifTrue:[^Error signal: SentenceFinderByPrefix messageEmptyPrefixError].
	('* *' match: aPrefix ) ifTrue:[^Error signal: SentenceFinderByPrefix messageHasEmptySpacesError].

	tempStack _ OOStack new.
	resultCollection _ OrderedCollection new.
	
	[stack isEmpty not] 
	whileTrue: [| element |
		element _ stack pop.
		tempStack push: element.
		(element beginsWith: aPrefix) 
		ifTrue:[
			resultCollection add: element.
		].
	].

	[tempStack isEmpty not] 
	whileTrue: [
		stack push: tempStack pop.
	].


	^resultCollection.! !

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


!SentenceFinderByPrefix class methodsFor: 'initialization' stamp: 'EMI 10/5/2020 21:08:57'!
with: aStackToSearch
	^super new with: aStackToSearch.! !


!classDefinition: #StackableBlock category: 'Stack-Exercise'!
Object subclass: #StackableBlock
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackableBlock methodsFor: 'queries' stamp: 'EMI 10/5/2020 21:35:54'!
countBlocksUnder
	^self subclassResponsibility.! !

!StackableBlock methodsFor: 'queries' stamp: 'EMI 10/5/2020 20:59:39'!
getContainedObject
	^self subclassResponsibility.! !

!StackableBlock methodsFor: 'queries' stamp: 'EMI 10/5/2020 20:50:26'!
nextBlock
	^self subclassResponsibility.! !


!classDefinition: #BaseStackableBlock category: 'Stack-Exercise'!
StackableBlock subclass: #BaseStackableBlock
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!BaseStackableBlock methodsFor: 'queries' stamp: 'EMI 10/5/2020 21:37:11'!
countBlocksUnder
	^0.! !

!BaseStackableBlock methodsFor: 'queries' stamp: 'EMI 10/5/2020 20:59:39'!
getContainedObject
	^Error signal: OOStack stackEmptyErrorDescription.! !

!BaseStackableBlock methodsFor: 'queries' stamp: 'EMI 10/5/2020 20:50:26'!
nextBlock
	^Error signal: OOStack stackEmptyErrorDescription.! !


!classDefinition: #FilledStackableBlock category: 'Stack-Exercise'!
StackableBlock subclass: #FilledStackableBlock
	instanceVariableNames: 'containedObject underBlock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!FilledStackableBlock methodsFor: 'queries' stamp: 'EMI 10/5/2020 21:36:59'!
countBlocksUnder
	^underBlock countBlocksUnder + 1.! !

!FilledStackableBlock methodsFor: 'queries' stamp: 'EMI 10/5/2020 20:59:57'!
getContainedObject
	^containedObject.! !

!FilledStackableBlock methodsFor: 'queries' stamp: 'EMI 10/5/2020 21:00:54'!
nextBlock
	^underBlock.! !


!FilledStackableBlock methodsFor: 'private' stamp: 'EMI 10/5/2020 21:02:54'!
initialize: anObjectToContain withNextBlock: previousTopBlock
	containedObject _ anObjectToContain.
	underBlock _ previousTopBlock.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FilledStackableBlock class' category: 'Stack-Exercise'!
FilledStackableBlock class
	instanceVariableNames: ''!

!FilledStackableBlock class methodsFor: 'initialization' stamp: 'EMI 10/5/2020 21:03:11'!
with: anObjectToContain nextBlock: previousTopBlock
	^super new initialize: anObjectToContain withNextBlock: previousTopBlock.! !
