!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'EMI 11/7/2020 18:39:42'!
test01NewPortfolioHasNoAccountsAndNoPortfolios
	| portfolio |
	portfolio _ Portfolio new.
	
	self assert: portfolio balance equals: 0.
	self assert: portfolio parentAssets isEmpty.! !

!PortfolioTest methodsFor: 'tests' stamp: 'EMI 11/7/2020 18:39:52'!
test02PortfolioAddEmptyAccount
	| portfolio account|
	portfolio _ Portfolio new.
	account _ ReceptiveAccount new.
	
	self assert: (portfolio add: account).
	self assert: portfolio balance equals: 0.
	self assert: portfolio parentAssets isEmpty.
	self assert: account parentAssets size equals: 1.
	self assert: account parentAssets includes: portfolio.! !

!PortfolioTest methodsFor: 'tests' stamp: 'EMI 11/7/2020 18:40:04'!
test03PortfolioAddEmptyPortfolio
	| portfolio portfolioChild |
	portfolio _ Portfolio new.
	portfolioChild _ Portfolio new.
	
	self assert: (portfolio add: portfolioChild ).
	self assert: portfolio balance equals: 0.
	self assert: portfolio parentAssets isEmpty.
	self assert: portfolioChild parentAssets size equals: 1.
	self assert: portfolioChild parentAssets includes: portfolio.! !

!PortfolioTest methodsFor: 'tests' stamp: 'EMI 11/6/2020 18:18:11'!
test04PortfolioHasNoRegisteredTransactions
	| portfolio |
	portfolio _ Portfolio new.

	self deny: (portfolio hasRegistered: (Deposit for: 100)).
	self deny: (portfolio hasRegistered: (Withdraw for: 100)).
	self assert: portfolio balance equals: 0.! !

!PortfolioTest methodsFor: 'tests' stamp: 'EMI 11/6/2020 19:56:43'!
test05PortfolioHasOneAccountWithOneRegisteredTransaction
	| portfolio account transaction|
	portfolio _ Portfolio new.
	account _ ReceptiveAccount new.
	transaction _ Deposit register: 100 on: account.
	
	self assert: (portfolio add: account).
	self assert: (portfolio hasRegistered: transaction).
	self assert: portfolio balance equals: 100.! !

!PortfolioTest methodsFor: 'tests' stamp: 'EMI 11/7/2020 18:13:25'!
test06PortfolioMoreThanOneAccountWithRegisteredTransactions
	| portfolio account1 account2 transaction1 transaction2|
	portfolio _ Portfolio new.
	account1 _ ReceptiveAccount new.
	account2 _ ReceptiveAccount new.
	transaction1 _ Deposit register: 100 on: account1.
	transaction2 _ Deposit register: 50 on: account2.
	
	self assert: (portfolio add: account1).
	self assert: (portfolio add: account2).
	self assert: (portfolio hasRegistered: transaction1).
	self assert: (portfolio hasRegistered: transaction2).
	self assert: portfolio balance equals: 150.! !

!PortfolioTest methodsFor: 'tests' stamp: 'EMI 11/6/2020 18:27:41'!
test07EmptyPortfolioHasNoTransactions
	| portfolio |
	portfolio _ Portfolio new.

	self assert: portfolio transactions isEmpty.
	self assert: portfolio balance equals: 0.! !

!PortfolioTest methodsFor: 'tests' stamp: 'EMI 11/6/2020 19:57:02'!
test08PortfolioWithOneAccountHasOneTransaction
	| portfolio account deposit |
	portfolio _ Portfolio new.
	account _  ReceptiveAccount new.
	deposit _ Deposit register: 100 on: account.
	
	self assert: (portfolio add: account).
	self assert: portfolio transactions size equals: 1.
	self assert: (portfolio transactions includes: deposit).
	self assert: portfolio balance equals: 100.! !

!PortfolioTest methodsFor: 'tests' stamp: 'EMI 11/6/2020 19:57:18'!
test09PortfolioWithMoreThanOneAccountHasMoreThanOneTransactions
	| portfolio account1 account2 deposit withdraw |
	portfolio _ Portfolio new.
	account1 _  ReceptiveAccount new.
	account2 _  ReceptiveAccount new.
	deposit _ Deposit register: 100 on: account1.
	withdraw _ Withdraw register: 50 on: account2.
	
	self assert: (portfolio add: account1).
	self assert: (portfolio add: account2).
	self assert: portfolio transactions size equals: 2.
	self assert: (portfolio transactions includes: deposit).
	self assert: (portfolio transactions includes: withdraw ).
	self assert: portfolio balance equals: 50.! !

!PortfolioTest methodsFor: 'tests' stamp: 'EMI 11/7/2020 18:14:49'!
test10PortfolioHasOneChildPortfolioWithAnAccountAndADeposit
	| portfolio portfolioChild account|
	portfolio _ Portfolio new.
	portfolioChild _ Portfolio new.
	account _  ReceptiveAccount new.
	Deposit register: 100 on: account. 
	
	self assert: (portfolioChild add: account).
	self assert: (portfolio add: portfolioChild).
	self assert: portfolioChild balance equals: 100.
	self assert: portfolio balance equals: 100.

	 
! !

!PortfolioTest methodsFor: 'tests' stamp: 'EMI 11/7/2020 18:16:03'!
test11PortfolioHasMoreThanOneChildPortfolioWithAnAccountAndADeposit
	| portfolio portfolioChildLeft  portfolioChildRight account account2|
	portfolio _ Portfolio new.
	portfolioChildLeft _ Portfolio new.
	portfolioChildRight _ Portfolio new.
	account _  ReceptiveAccount new.
	account2 _  ReceptiveAccount new.
	Deposit register: 100 on: account.
	Deposit register: 100 on: account2.
	
	self assert: (portfolioChildLeft add: account).
	self assert: (portfolioChildRight add: account2).
	self assert: (portfolio add: portfolioChildLeft).
	self assert: (portfolio add: portfolioChildRight).
	self assert: portfolioChildLeft balance equals: 100.
	self assert: portfolioChildRight balance equals: 100.
	self assert: portfolio balance equals: 200.
	 
! !

!PortfolioTest methodsFor: 'tests' stamp: 'EMI 11/7/2020 18:16:44'!
test12PortfolioHasOneChildPortfolioWithAnAccountAndADepositRegistered
	| portfolio portfolioChild account transaction |
	portfolio _ Portfolio new.
	portfolioChild _ Portfolio new.
	account _  ReceptiveAccount new.
	transaction _ Deposit register: 100 on: account. 
	
	self assert: (portfolioChild add: account).
	self assert: (portfolio add: portfolioChild).
	self assert: (portfolio hasRegistered: transaction).
	self assert: (portfolio transactions size) equals: 1.
	self assert: (portfolio transactions includes: transaction).

	 
! !

!PortfolioTest methodsFor: 'tests' stamp: 'EMI 11/7/2020 18:18:03'!
test13PortfolioHasMoreThanOneChildPortfolioWithAnAccountAndADepositRegistered
	| portfolio portfolioChildLeft  portfolioChildRight account1 account2 transaction1 transaction2|
	portfolio _ Portfolio new.
	portfolioChildLeft _ Portfolio new.
	portfolioChildRight _ Portfolio new.
	account1 _  ReceptiveAccount new.
	account2 _  ReceptiveAccount new.
	transaction1 _ Deposit register: 100 on: account1.
	transaction2 _ Deposit register: 100 on: account2.
	
	self assert: (portfolioChildLeft add: account1).
	self assert: (portfolioChildRight add: account2).
	self assert: (portfolio add: portfolioChildLeft).
	self assert: (portfolio add: portfolioChildRight).
	self assert: (portfolio hasRegistered: transaction1).
	self assert: (portfolio hasRegistered: transaction2).
	self assert: (portfolio transactions size) equals: 2.
	self assert: (portfolio transactions includes: transaction1).
	self assert: (portfolio transactions includes: transaction2).
	 
! !

!PortfolioTest methodsFor: 'tests' stamp: 'EMI 11/6/2020 20:09:59'!
test14PortfolioCannotAddSameEmptyAssetTwice
	| portfolio portfolio2 account|
	portfolio _ Portfolio new.
	account _  ReceptiveAccount new.
	
	self assert: (portfolio add: account).
	self deny: (portfolio add: account).
	
	portfolio2 _ Portfolio new.
	
	self assert: (portfolio add: portfolio2).
	self deny: (portfolio add: portfolio2).


	 
! !

!PortfolioTest methodsFor: 'tests' stamp: 'EMI 11/6/2020 20:10:59'!
test15PortfolioCannotAddChildPortfolioWithSameAccount
	| portfolio portfolio2 account|
	portfolio _ Portfolio new.
	account _  ReceptiveAccount new.
	self assert: (portfolio add: account).
	
	portfolio2 _ Portfolio new.
	self assert: (portfolio2 add: account).
	
	self deny: (portfolio add: portfolio2).


	 
! !

!PortfolioTest methodsFor: 'tests' stamp: 'EMI 11/7/2020 18:22:00'!
test16PortfolioCannotAddBothChildrenPortfoliosWithSameAccount
	| portfolio portfolioChildLeft portfolioChildRight account|
	portfolio _ Portfolio new.
	account _  ReceptiveAccount new.
	
	portfolioChildLeft _ Portfolio new.
	self assert: (portfolioChildLeft add: account).
	
	portfolioChildRight _ Portfolio new.
	self assert: (portfolioChildRight add: account).
	
	self assert: (portfolio add: portfolioChildLeft).
	self deny: (portfolio add: portfolioChildRight).


	 
! !

!PortfolioTest methodsFor: 'tests' stamp: 'EMI 11/7/2020 18:24:21'!
test17PortfolioCannotAddBothGrandChildrenPortfoliosWithSameAccount
	| portfolio portfolioChildLeft portfolioChildRight portfolioGrandChildLeft portfolioGrandChildRight account|
	portfolio _ Portfolio new.
	account _  ReceptiveAccount new.
	
	portfolioChildLeft _ Portfolio new.
	portfolioChildRight _ Portfolio new.
	
	portfolioGrandChildLeft _ Portfolio new.
	self assert: (portfolioGrandChildLeft add: account).
	
	portfolioGrandChildRight _ Portfolio new.
	self assert: (portfolioGrandChildRight add: account).
	
	self assert: (portfolio add: portfolioChildLeft).
	self assert: (portfolio add: portfolioChildRight).
	self assert: (portfolioChildLeft add: portfolioGrandChildLeft).
	self deny: (portfolioChildRight add: portfolioGrandChildRight).


	 
! !

!PortfolioTest methodsFor: 'tests' stamp: 'EMI 11/7/2020 16:22:53'!
test18PortfolioWith2ChildrenPortfoliosCannotAddAThirdWithSameAccount
	| portfolioRoot portfolioChildWithAccount portfolioChildWithoutAccount portfolioToAddWithSameAccount account|
	portfolioRoot _ Portfolio new.
	account _  ReceptiveAccount new.
	
	portfolioChildWithoutAccount _ Portfolio new.
	
	portfolioChildWithAccount _ Portfolio new.
	self assert: (portfolioChildWithAccount add: account).
	
	portfolioToAddWithSameAccount _ Portfolio new.
	self assert: (portfolioToAddWithSameAccount add: account).
	
	self assert: (portfolioRoot add: portfolioChildWithoutAccount).
	self assert: (portfolioRoot add: portfolioChildWithAccount).
	self deny: (portfolioRoot add: portfolioToAddWithSameAccount).


	 
! !

!PortfolioTest methodsFor: 'tests' stamp: 'EMI 11/7/2020 16:29:15'!
test19PortfolioWith2ChildrenPortfoliosCannotAddAThirdWithAParentWithSameAccount
	| portfolioRoot portfolioChildWithAccount portfolioChildWithoutAccount 
	portfolioToAdd portfolioWithSameAccount account|
	
	portfolioRoot _ Portfolio new.
	account _  ReceptiveAccount new.
	
	portfolioChildWithoutAccount _ Portfolio new.
	
	portfolioChildWithAccount _ Portfolio new.
	self assert: (portfolioChildWithAccount add: account).
	
	portfolioToAdd _ Portfolio new.
	portfolioWithSameAccount _ Portfolio new.
	self assert: (portfolioWithSameAccount add: account).
	self assert: (portfolioWithSameAccount add: portfolioToAdd).
	
	self assert: (portfolioRoot add: portfolioChildWithoutAccount).
	self assert: (portfolioRoot add: portfolioChildWithAccount).
	self deny: (portfolioRoot add: portfolioToAdd).


	 
! !

!PortfolioTest methodsFor: 'tests' stamp: 'EMI 11/7/2020 16:47:58'!
test20PortfolioWith2GrandChildrenPortfoliosCannotAddAThirdWithAGrandParentWithSameAccount
	| portfolioRoot portfolioChildLeft portfolioChildRight 
	portfolioGrandChildRight portfolioGrandChildLeft 
	portfolioRootAnotherTree portfolioChildAnotherTree portfolioGrandChildAnotherTree account|
	
	portfolioRoot _ Portfolio new.
	portfolioRootAnotherTree  _ Portfolio new.
	account _  ReceptiveAccount new.
	
	self assert: (portfolioRoot add: account).
	self assert: (portfolioRootAnotherTree add: account).
	
	portfolioChildLeft  _ Portfolio new.
	portfolioChildRight _ Portfolio new.
	self assert: (portfolioRoot add: portfolioChildLeft).
	self assert: (portfolioRoot add: portfolioChildRight).
	
	portfolioGrandChildLeft _ Portfolio new.
	portfolioGrandChildRight _ Portfolio new.
	self assert: (portfolioChildLeft add: portfolioGrandChildLeft ).
	self assert: (portfolioChildRight add: portfolioGrandChildRight).
	
	portfolioChildAnotherTree _ Portfolio new.
	self assert: (portfolioRootAnotherTree add: portfolioChildAnotherTree).
	
	portfolioGrandChildAnotherTree _ Portfolio new.
	self assert: (portfolioChildAnotherTree add: portfolioGrandChildAnotherTree ).
	
	self deny: (portfolioGrandChildRight add: portfolioGrandChildAnotherTree).
	


	 
! !

!PortfolioTest methodsFor: 'tests' stamp: 'EMI 11/7/2020 18:39:19'!
test21TwoPortfoliosCanUseSameAccount
	| portfolio portfolio2 account|
	
	portfolio _ Portfolio new.
	portfolio2 _ Portfolio new.
	account _ ReceptiveAccount new.
	
	self assert: (portfolio add: account).
	self assert: (portfolio2 add: account).
	self assert: account parentAssets includes: portfolio.
	self assert: account parentAssets includes: portfolio2.
	


	 
! !

!PortfolioTest methodsFor: 'tests' stamp: 'EMI 11/7/2020 18:06:13'!
test22CannotUniteTwoPortfoliosWithSameAccount
	| portfolio portfolio2 portfolioRoot account|
	
	portfolio _ Portfolio new.
	portfolio2 _ Portfolio new.
	portfolioRoot _ Portfolio new.
	account _ ReceptiveAccount new.
	
	self assert: (portfolio add: account).
	self assert: (portfolio2 add: account).
	self assert: (portfolioRoot add: portfolio).
	self deny: (portfolioRoot add: portfolio2).
	


	 
! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'EMI 11/2/2020 21:03:47'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.
	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:15'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'EMI 11/2/2020 19:55:15'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'EMI 11/2/2020 20:31:23'!
calculateBalance: aBalance

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'EMI 11/2/2020 20:32:03'!
calculateBalance: aBalance
	^aBalance + value.! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'EMI 11/2/2020 20:32:14'!
calculateBalance: aBalance
	^aBalance - value.! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Asset category: 'Portfolio-Ejercicio'!
Object subclass: #Asset
	instanceVariableNames: 'parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Asset methodsFor: 'testing' stamp: 'EMI 11/6/2020 19:51:09'!
balance
	^self subclassResponsibility.! !

!Asset methodsFor: 'testing' stamp: 'EMI 11/6/2020 20:27:10'!
hasAsset: anAsset
	^self subclassResponsibility.! !

!Asset methodsFor: 'testing' stamp: 'EMI 11/6/2020 19:51:27'!
hasRegistered: aTransaction
	^self subclassResponsibility.! !


!Asset methodsFor: 'accesing' stamp: 'EMI 11/6/2020 19:51:39'!
transactions
	^self subclassResponsibility.! !


!Asset methodsFor: 'tree operations' stamp: 'EMI 11/7/2020 17:30:57'!
addAsSubassetOf: aParentAsset
	parents add: aParentAsset.! !

!Asset methodsFor: 'tree operations' stamp: 'EMI 11/7/2020 18:38:38'!
assetTreeRoots
	| rootParents|
	rootParents _ OrderedCollection new.
	
	parents isEmpty ifTrue: [rootParents add: self].
	parents do: [:aParent | 
		rootParents addAll: aParent assetTreeRoots.
	].

	^rootParents.! !

!Asset methodsFor: 'tree operations' stamp: 'EMI 11/7/2020 18:58:04'!
hasAssetIntersectionWith: anAsset
	^(self hasAsset: anAsset) or: [anAsset hasAsset: self].! !

!Asset methodsFor: 'tree operations' stamp: 'EMI 11/7/2020 18:38:57'!
parentAssets
	^parents! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Asset subclass: #Portfolio
	instanceVariableNames: 'assets'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'testing' stamp: 'EMI 11/6/2020 19:54:47'!
balance
	^(assets sum: [:anAsset | anAsset balance] ifEmpty:[0]).! !

!Portfolio methodsFor: 'testing' stamp: 'EMI 11/7/2020 18:48:32'!
hasAsset: anAsset
	| estaEnMisHijosDirectos |
	estaEnMisHijosDirectos _ assets includes: anAsset.
	^estaEnMisHijosDirectos or: [(assets select: [:aChildAsset | aChildAsset hasAssetIntersectionWith: anAsset]) isEmpty not.].
	! !

!Portfolio methodsFor: 'testing' stamp: 'EMI 11/6/2020 19:55:28'!
hasRegistered: aTransaction
	assets detect: [:anAsset | anAsset hasRegistered: aTransaction ] ifNone: [^false].
	^true.! !


!Portfolio methodsFor: 'adding' stamp: 'EMI 11/7/2020 18:38:38'!
add: anAsset
	| rootParents rootParentsOther |
	rootParents _ (self assetTreeRoots).
	rootParentsOther _ (anAsset assetTreeRoots).
	
	rootParents do: [:aParent |
		rootParentsOther do: [:aParentOther |
			(aParent hasAsset: aParentOther) ifTrue:[^false.].
			(aParentOther hasAsset: aParent) ifTrue:[^false.].
		].
	].
	
	assets add: anAsset.
	anAsset addAsSubassetOf: self.
	^true.! !


!Portfolio methodsFor: 'initialization' stamp: 'EMI 11/7/2020 17:31:59'!
initialize
	assets _ OrderedCollection new.
	parents _ OrderedCollection new.! !


!Portfolio methodsFor: 'accessing' stamp: 'EMI 11/7/2020 17:57:47'!
transactions
	| res |
	res _ OrderedCollection new.
	assets do: [:anAsset | res addAll: anAsset transactions  ].
	^res.! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Asset subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'EMI 11/7/2020 17:31:48'!
initialize

	transactions := OrderedCollection new.
	parents _ OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'EMI 11/2/2020 20:33:55'!
balance
	| balance |
	balance _ 0.
	transactions do: [ :aTransaction | balance _ aTransaction calculateBalance: balance	].
	^balance! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'EMI 11/6/2020 20:27:30'!
hasAsset: anAsset
	^false.! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !
