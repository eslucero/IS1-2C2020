!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'catalogue carrito'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'EMI 11/18/2020 18:20:23'!
test01NewCartIsEmpty
	self assert: (carrito isEmpty).! !

!CartTest methodsFor: 'tests' stamp: 'EMI 11/18/2020 18:16:25'!
test02CartCanAddOneBook
	carrito add: 'El principito'.
	self deny: (carrito isEmpty).
	self assert: (carrito productsAmount) equals: 1.! !

!CartTest methodsFor: 'tests' stamp: 'EMI 11/18/2020 18:16:25'!
test03CartCanAddMoreThanOneCopyOfABookAtOnce
	carrito add: 'El principito' amount: 2.
	self deny: (carrito isEmpty).
	self assert: (carrito productsAmount) equals: 2.
	self assert: (carrito copiesOf: 'El principito') equals: 2.! !

!CartTest methodsFor: 'tests' stamp: 'EMI 11/18/2020 18:16:57'!
test04CartCanAddMoreThanOneBook
	carrito add: 'El principito'.
	carrito add: 'El principote'.
	self deny: (carrito isEmpty).
	self assert: (carrito productsAmount) equals: 2.
	self assert: (carrito contains: 'El principito').
	self assert: (carrito contains: 'El principote').! !

!CartTest methodsFor: 'tests' stamp: 'EMI 11/18/2020 18:16:25'!
test05CartCanAddMoreThanOneBookWithDifferentAmountOfCopies
	carrito add: 'El principito'.
	carrito add: 'El principito' amount: 2.
	carrito add: 'El principote'.
	self deny: (carrito isEmpty).
	self assert: (carrito productsAmount) equals: 4.
	self assert: (carrito contains: 'El principito').
	self assert: (carrito contains: 'El principote').
	self assert: (carrito copiesOf: 'El principito') equals: 3.
	self assert: (carrito copiesOf: 'El principote') equals: 1.! !

!CartTest methodsFor: 'tests' stamp: 'EMI 11/18/2020 18:16:25'!
test06CartCanShowContents
	| expectedResult |
	
	carrito add: 'El principito'.
	carrito add: 'El principito' amount: 2.
	carrito add: 'El principote'.
	
	expectedResult _ Bag with: 'El principote'.
	expectedResult add: 'El principito' withOccurrences: 3.
	
	self assert: (carrito contents) equals: expectedResult.! !

!CartTest methodsFor: 'tests' stamp: 'EMI 11/24/2020 18:37:01'!
test07CartCannotAddBookMissingFromCatalogue
	self should: [carrito add: 'La celula'] 
	raise: Error 
	withExceptionDo: [:anError| 
		self assert: anError messageText equals: Cart itemNotFoundInCatalogueMessage.
		self assert: carrito isEmpty.
		].! !

!CartTest methodsFor: 'tests' stamp: 'EMI 11/24/2020 18:36:39'!
test08CartCannotAddInvalidAmountOfBooks
	self should: [carrito add: 'El principito' amount: 2.5] 
	raise: Error 
	withExceptionDo: [:anError| 
		self assert: anError messageText equals: Cart itemAmountMustBeIntegerMessage.
		self assert: carrito isEmpty.
		].
	self should: [carrito add: 'El principito' amount: -1] 
	raise: Error 
	withExceptionDo: [:anError| 
		self assert: anError messageText equals: Cart itemAmountMustBePositiveMessage.
		self assert: carrito isEmpty.
		].! !


!CartTest methodsFor: 'set up' stamp: 'EMI 11/26/2020 20:42:49'!
setUp
	catalogue _ Dictionary with: 'El principito'->1 with: 'El principote'->2.
	carrito _ Cart createUsingPriceList: catalogue.! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'listaPrecios salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'setUp' stamp: 'EMI 11/26/2020 21:08:53'!
setUp
	listaPrecios _ Dictionary new.
	listaPrecios add: '1234'->1.
	salesBook _ OrderedCollection new.! !


!CashierTest methodsFor: 'tests' stamp: 'EMI 11/26/2020 21:09:02'!
test01CashierCannotCheckoutEmptyCart
	| cashier card mp cart |
	cart _ Cart createUsingPriceList: listaPrecios.
	mp _ AlwaysValidMerchantProcessorSimulator new.
	cashier _ Cashier withPriceList: listaPrecios withMerchantProcessor: mp.
	card _ CreditCard of: 'Pepito' withID: '1234' withExpirationDate: self nonExpiredCardDate.
	
	self should: [cashier checkout: cart usingCard: card onDate: GregorianMonthOfYear current usingSalesBook: salesBook] 
	raise: Error 
	withExceptionDo: [:anError | self assert: anError messageText equals: Cashier cannotCheckoutEmptyCartMessage].! !

!CashierTest methodsFor: 'tests' stamp: 'EMI 11/26/2020 21:13:37'!
test02CashierCanCheckoutCartWithOneBook
	| cashier mp card cart |
	card _ CreditCard of: 'Pepo' withID: '1111' withExpirationDate: self nonExpiredCardDate.
	cart _ Cart createUsingPriceList: listaPrecios.
	cart add: '1234'.
	mp _ AlwaysValidMerchantProcessorSimulator new.
	cashier _ Cashier withPriceList: listaPrecios withMerchantProcessor: mp.
	cashier checkout: cart usingCard: card onDate: GregorianMonthOfYear current usingSalesBook: salesBook.
	self deny: salesBook isEmpty.
	self assert: salesBook last equals: 1.! !

!CashierTest methodsFor: 'tests' stamp: 'EMI 11/26/2020 21:14:12'!
test03CashierCanCheckoutCartWithMoreThanOneBook
	| cashier mp card cart |
	card _ CreditCard of: 'Pepo' withID: '1111' withExpirationDate: self nonExpiredCardDate.

	cart _ Cart createUsingPriceList: listaPrecios.
	cart add: '1234' amount: 50.
	mp _ AlwaysValidMerchantProcessorSimulator new.
	cashier _ Cashier withPriceList: listaPrecios withMerchantProcessor: mp.
	cashier checkout: cart usingCard: card onDate: GregorianMonthOfYear current usingSalesBook: salesBook.
	self deny: salesBook isEmpty.
	self assert: salesBook last equals: 50.! !

!CashierTest methodsFor: 'tests' stamp: 'EMI 11/26/2020 21:14:41'!
test04CashierCannotCheckoutWithInvalidCard
	| cashier mp card cart |
	card _ CreditCard of: 'Tito' withID: '1112' withExpirationDate: self nonExpiredCardDate.

	cart _ Cart createUsingPriceList: listaPrecios.
	cart add: '1234' amount: 50.
	mp _ OnlyChecksIDsMerchantProcessorSimulator initialize: (Set with: '1111').
	cashier _ Cashier withPriceList: listaPrecios withMerchantProcessor: mp.
	
	self should: [cashier checkout: cart usingCard: card onDate: GregorianMonthOfYear current usingSalesBook: salesBook]
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText equals: mp class cannotDebitFromCreditCardWithInvalidIDMessage].
	
	self assert: salesBook isEmpty.! !

!CashierTest methodsFor: 'tests' stamp: 'EMI 11/26/2020 21:15:02'!
test05CashierCannotCheckoutWithExpiredCard
	| cashier mp card carrito |
	card _ CreditCard of: 'Tito' withID: '1112' withExpirationDate: self expiredCardDate.
	
	carrito _ Cart createUsingPriceList: listaPrecios.
	carrito add: '1234' amount: 50.
	
	mp _ AlwaysValidMerchantProcessorSimulator new.
	cashier _ Cashier withPriceList: listaPrecios withMerchantProcessor: mp.
	
	self should: [cashier checkout: carrito usingCard: card onDate: GregorianMonthOfYear current usingSalesBook: salesBook]
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText equals: Cashier cannotCheckoutWithExpiredCardMessage].
	self assert: salesBook isEmpty.! !

!CashierTest methodsFor: 'tests' stamp: 'EMI 11/26/2020 21:15:17'!
test06CashierCannotCheckoutWithIncorrectNameOnCard
	| cashier mp card carrito idsToNamesDictionary |
	card _ CreditCard of: 'NombreInvalido' withID: '1112' withExpirationDate: self nonExpiredCardDate.
	
	carrito _ Cart createUsingPriceList: listaPrecios.
	carrito add: '1234' amount: 50.
	
	idsToNamesDictionary _ Dictionary new.
	idsToNamesDictionary add:'1112'->'NombreValido'.
	mp _ OnlyChecksIDsAndNamesMerchantProcessorSimulator initialize: idsToNamesDictionary.
	cashier _ Cashier withPriceList: listaPrecios withMerchantProcessor: mp.
	
	self should: [cashier checkout: carrito usingCard: card onDate: GregorianMonthOfYear current usingSalesBook: salesBook]
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText equals: MerchantProcessorSimulator cannotDebitUsingCardWithIncorrectNameMessage].
	
	self assert: salesBook isEmpty.! !

!CashierTest methodsFor: 'tests' stamp: 'EMI 11/26/2020 21:15:26'!
test07CashierCannotCheckoutUsingCardWithoutFunds
	| cashier mp card cart idsToFundsDictionary |
	card _ CreditCard of: 'NombreValido' withID: '1112' withExpirationDate: self nonExpiredCardDate.
	
	cart _ Cart createUsingPriceList: listaPrecios.
	cart add: '1234' amount: 50.
	
	idsToFundsDictionary _ Dictionary new.
	idsToFundsDictionary add:'1112'->49.
	mp _ OnlyChecksIDsAndFundsMerchantProcessorSimulator initialize: idsToFundsDictionary.
	cashier _ Cashier withPriceList: listaPrecios withMerchantProcessor: mp.
	
	self should: [cashier checkout: cart usingCard: card onDate: GregorianMonthOfYear current usingSalesBook: salesBook]
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText equals: MerchantProcessorSimulator cannotDebitUsingCardWithInsufficientFundsMessage].
	self assert: salesBook isEmpty.! !


!CashierTest methodsFor: 'aux' stamp: 'EMI 11/26/2020 20:51:16'!
expiredCardDate
	^GregorianMonthOfYear current previous.! !

!CashierTest methodsFor: 'aux' stamp: 'EMI 11/26/2020 20:51:58'!
nonExpiredCardDate
	^GregorianMonthOfYear current next.! !


!classDefinition: #CreditCardTest category: 'TusLibros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'tests' stamp: 'EMI 11/26/2020 20:58:55'!
test01CannotCreateCardWithInvalidIDFormat
	self should:[CreditCard of: 'Bob' withID: '' withExpirationDate: GregorianMonthOfYear current.]
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText equals: CreditCard cannotCreateCardWithInvalidIDMessage].! !

!CreditCardTest methodsFor: 'tests' stamp: 'EMI 11/26/2020 20:59:02'!
test02CannotCreateCardWithInvalidName
	self should:[CreditCard of: '' withID: '1' withExpirationDate: GregorianMonthOfYear current.]
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText equals: CreditCard cannotCreateCardWithInvalidNameMessage].! !

!CreditCardTest methodsFor: 'tests' stamp: 'EMI 11/26/2020 20:59:06'!
test03CannotCreateCardWithInvalidDateFormat
	self should:[CreditCard of: 'Pepo' withID: '1' withExpirationDate: Date today]
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText equals: CreditCard cannotCreateCardWithInvalidDateFormatMessage].! !


!classDefinition: #RESTInterfaceTest category: 'TusLibros'!
TestCase subclass: #RESTInterfaceTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RESTInterfaceTest methodsFor: 'tests' stamp: 'EMI 11/30/2020 19:30:45'!
test01CanCreateEmptyCartUsingValidIDAndPassword
	| interface cartID |
	interface _ RESTInterface withAuthenticator: self defaultAuthenticator withPriceList: self defaultPriceList withCashier: self defaultCashier.
	
	cartID _ interface createCart: self validClientID withPassword: self validClientPassword.
	self assert: (interface listCart: cartID) isEmpty.! !

!RESTInterfaceTest methodsFor: 'tests' stamp: 'EMI 11/30/2020 19:30:45'!
test02CannotCreateCartUsingInvalidIDOrPassword
	| interface |
	interface _ RESTInterface withAuthenticator: self defaultAuthenticator withPriceList: self defaultPriceList withCashier: self defaultCashier.
	
	self should: [interface createCart: self invalidClientID withPassword: self validClientPassword.]
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText equals: interface class cannotCreateCartWithInvalidID].
	
	self should: [interface createCart: self validClientID withPassword: self invalidClientPassword.]
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText equals: interface class cannotCreateCartWithInvalidPassword].
	! !

!RESTInterfaceTest methodsFor: 'tests' stamp: 'EMI 11/30/2020 19:30:45'!
test03CannotListCartUsingInvalidCartID
	| interface cartID |
	interface _ RESTInterface withAuthenticator: self defaultAuthenticator withPriceList: self defaultPriceList withCashier: self defaultCashier.
	cartID _ interface createCart: self validClientID withPassword: self validClientPassword.
	self should: [interface listCart: '2']
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText equals: interface class cannotListCartWithInvalidCartID].
	! !

!RESTInterfaceTest methodsFor: 'tests' stamp: 'EMI 11/30/2020 19:30:45'!
test04CanAddOneProductToValidCart
	| interface cartID |
	interface _ RESTInterface withAuthenticator: self defaultAuthenticator withPriceList: self defaultPriceList withCashier: self defaultCashier.
	cartID _ interface createCart: self validClientID withPassword: self validClientPassword.
	interface addToCart: cartID productName: self validProductName quantity: 1.
	
	self assert: (interface listCart: cartID) size equals: 1.! !

!RESTInterfaceTest methodsFor: 'tests' stamp: 'EMI 11/30/2020 19:30:45'!
test05CanHaveMoreThanOneValidCart
	| interface cartID cartID2 |
	interface _ RESTInterface withAuthenticator: self defaultAuthenticator withPriceList: self defaultPriceList withCashier: self defaultCashier.
	
	cartID _ interface createCart: self validClientID withPassword: self validClientPassword.
	interface addToCart: cartID productName: self validProductName quantity: 1.
	
	cartID2 _ interface createCart: self anotherValidClientID withPassword: self validClientPassword.
	interface addToCart: cartID2 productName: self anotherValidProductName quantity: 5.
	
	self assert: (interface listCart: cartID) size equals: 1.
	self assert: ((interface listCart: cartID) includes: self validProductName).
	self assert: (interface listCart: cartID2) size equals: 5.
	self assert: ((interface listCart: cartID2) includes: self anotherValidProductName).
! !

!RESTInterfaceTest methodsFor: 'tests' stamp: 'EMI 11/30/2020 19:30:45'!
test06CannotAddProductToCartWithInvalidCartID
	| interface cartID |
	interface _ RESTInterface withAuthenticator: self defaultAuthenticator withPriceList: self defaultPriceList withCashier: self defaultCashier.
	cartID _ interface createCart: self validClientID withPassword: self validClientPassword.
	
	self should: [interface addToCart: '11111' productName: self validProductName quantity: 1.]
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText equals: RESTInterface cannotAddProductToCartWithInvalidCartID].! !

!RESTInterfaceTest methodsFor: 'tests' stamp: 'EMI 11/30/2020 19:39:28'!
test07CanCheckoutProductsOfAValidCart
	| interface cartID |
	interface _ RESTInterface withAuthenticator: self defaultAuthenticator 
						    withPriceList: self defaultPriceList 
						    withCashier: self defaultCashier.
	
	cartID _ interface createCart: self validClientID withPassword: self validClientPassword.
	
	interface addToCart: cartID productName: self anotherValidProductName quantity: 1.
	
	interface checkout: cartID withCardNumber: self validCardNumber withCardExpDate: self validCardDate withCardOwnerName: self validCardOwnerName.

	self should: [interface listCart: cartID]
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText equals: RESTInterface cannotListCartWithInvalidCartID].
	! !

!RESTInterfaceTest methodsFor: 'tests' stamp: 'EMI 11/30/2020 19:43:18'!
test08CannotCheckoutProductsOfAnInvalidCart
	| interface cartID |
	interface _ RESTInterface withAuthenticator: self defaultAuthenticator 
						    withPriceList: self defaultPriceList 
						    withCashier: self defaultCashier.
	
	cartID _ interface createCart: self validClientID withPassword: self validClientPassword.
	
	interface addToCart: cartID productName: self anotherValidProductName quantity: 1.

	self should: [interface checkout: '10000' withCardNumber: self validCardNumber withCardExpDate: self validCardDate withCardOwnerName: self validCardOwnerName.]
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText equals: RESTInterface cannotCheckoutCartWithInvalidCartID].
	! !

!RESTInterfaceTest methodsFor: 'tests' stamp: 'EMI 11/30/2020 20:37:07'!
test09CanListPurchasesMadeBValidUser
	| interface cartID result |
	interface _ RESTInterface withAuthenticator: self defaultAuthenticator 
						    withPriceList: self defaultPriceList 
						    withCashier: self defaultCashier.
	
	cartID _ interface createCart: self validClientID withPassword: self validClientPassword.
	
	interface addToCart: cartID productName: self anotherValidProductName quantity: 1.

	interface checkout: cartID withCardNumber: self validCardNumber withCardExpDate: self validCardDate withCardOwnerName: self validCardOwnerName.
	
	result _ interface listPurchases: self validClientID withPassword: self validClientPassword.
	
	self deny: result isEmpty.

	! !

!RESTInterfaceTest methodsFor: 'tests' stamp: 'EMI 11/30/2020 21:08:04'!
test10CannotListPurchasesUsingInvalidClientIDOrPassword
	| interface cartID |
	interface _ RESTInterface withAuthenticator: self defaultAuthenticator 
						    withPriceList: self defaultPriceList 
						    withCashier: self defaultCashier.
	
	cartID _ interface createCart: self validClientID withPassword: self validClientPassword.
	
	interface addToCart: cartID productName: self anotherValidProductName quantity: 1.

	interface checkout: cartID withCardNumber: self validCardNumber withCardExpDate: self validCardDate withCardOwnerName: self validCardOwnerName.
	
	self should: [interface listPurchases: self invalidClientID withPassword: self validClientPassword.]
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText equals: RESTInterface cannotListPurchasesUsingInvalidID].
	
	self should: [interface listPurchases: self validClientID withPassword: self invalidClientPassword.]
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText equals: RESTInterface cannotListPurchasesUsingInvalidPassword].


	! !


!RESTInterfaceTest methodsFor: 'aux' stamp: 'EMI 11/30/2020 18:55:25'!
anotherValidClientID
	^'2'.! !

!RESTInterfaceTest methodsFor: 'aux' stamp: 'EMI 11/30/2020 18:56:35'!
anotherValidProductName
	^'El principito'.! !

!RESTInterfaceTest methodsFor: 'aux' stamp: 'EMI 11/30/2020 18:55:52'!
defaultAuthenticator
	^Dictionary with: self validClientID -> self validClientPassword with: self anotherValidClientID -> self validClientPassword.! !

!RESTInterfaceTest methodsFor: 'aux' stamp: 'EMI 11/30/2020 19:40:16'!
defaultCashier
	^Cashier withPriceList: self defaultPriceList withMerchantProcessor: AlwaysValidMerchantProcessorSimulator new.! !

!RESTInterfaceTest methodsFor: 'aux' stamp: 'EMI 11/30/2020 18:57:03'!
defaultPriceList
	^Dictionary with: 'El Principote' -> 50 with: 'El principito' -> 100.! !

!RESTInterfaceTest methodsFor: 'aux' stamp: 'EMI 11/30/2020 18:22:08'!
invalidClientID
	^Object new.! !

!RESTInterfaceTest methodsFor: 'aux' stamp: 'EMI 11/30/2020 18:22:16'!
invalidClientPassword
	^Object new.! !

!RESTInterfaceTest methodsFor: 'aux' stamp: 'EMI 11/30/2020 19:26:33'!
validCardDate
	| date |
	date _ (GregorianMonthOfYear current) next.
	^date monthNumber asString, date year number asString.! !

!RESTInterfaceTest methodsFor: 'aux' stamp: 'EMI 11/30/2020 19:23:16'!
validCardNumber
	^'123456789'! !

!RESTInterfaceTest methodsFor: 'aux' stamp: 'EMI 11/30/2020 19:26:57'!
validCardOwnerName
	^'El Principe'.! !

!RESTInterfaceTest methodsFor: 'aux' stamp: 'EMI 11/30/2020 18:10:54'!
validClientID
	^'1'.! !

!RESTInterfaceTest methodsFor: 'aux' stamp: 'EMI 11/30/2020 18:10:01'!
validClientPassword
	^'1234'.! !

!RESTInterfaceTest methodsFor: 'aux' stamp: 'EMI 11/30/2020 18:40:44'!
validProductName
	^'El Principote'.! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'items amount priceList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'testing' stamp: 'EMI 11/24/2020 18:34:27'!
contains: anItem 
	^items includes: anItem.! !

!Cart methodsFor: 'testing' stamp: 'EMI 11/16/2020 19:09:19'!
isEmpty
	^amount = 0.! !

!Cart methodsFor: 'testing' stamp: 'EMI 11/16/2020 19:09:25'!
productsAmount
	^amount.! !


!Cart methodsFor: 'initialization' stamp: 'EMI 11/26/2020 20:37:42'!
initialize: aPriceList
	amount _ 0.
	items _ Bag new.
	priceList _ aPriceList.! !


!Cart methodsFor: 'adding' stamp: 'EMI 11/24/2020 18:34:49'!
add: anItem
	self add: anItem amount: 1.
	
	! !

!Cart methodsFor: 'adding' stamp: 'EMI 11/24/2020 18:37:01'!
add: anItem amount: aNumberOfItems 
	(self checkIfItemIsInCatalogue: anItem) ifFalse: [^Error signal: self class itemNotFoundInCatalogueMessage.].
	(aNumberOfItems isInteger) ifFalse: [^Error signal: self class itemAmountMustBeIntegerMessage.].
	(aNumberOfItems > 0) ifFalse: [^Error signal: self class itemAmountMustBePositiveMessage].
	amount _ amount + aNumberOfItems.
	items add: anItem withOccurrences: aNumberOfItems.! !


!Cart methodsFor: 'private' stamp: 'EMI 11/26/2020 20:38:32'!
checkIfItemIsInCatalogue: anItem
	^priceList includesKey: anItem.! !


!Cart methodsFor: 'accessing' stamp: 'EMI 11/24/2020 18:34:18'!
contents
	^items copy.! !

!Cart methodsFor: 'accessing' stamp: 'EMI 11/26/2020 20:42:01'!
contentsTotalPrice
	| total |
	total _ 0.
	items do:[:anItem | total _ total + priceList at: anItem].
	^total.! !

!Cart methodsFor: 'accessing' stamp: 'EMI 11/24/2020 18:36:06'!
copiesOf: anItem
	^items occurrencesOf: anItem.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'EMI 11/26/2020 20:37:16'!
createUsingPriceList: aPriceList
	^self new initialize: aPriceList.! !


!Cart class methodsFor: 'error messages' stamp: 'EMI 11/24/2020 18:37:18'!
itemAmountMustBeIntegerMessage
	^'Item amount must be an integer'.! !

!Cart class methodsFor: 'error messages' stamp: 'EMI 11/24/2020 18:37:23'!
itemAmountMustBePositiveMessage
	^'Item amount must be a positive integer'.! !

!Cart class methodsFor: 'error messages' stamp: 'EMI 11/24/2020 18:37:28'!
itemNotFoundInCatalogueMessage
	^'Cannot find requested item in catalogue.'! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'priceListDictionary merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'operations' stamp: 'EMI 11/26/2020 21:11:53'!
checkout: aCart usingCard: aCard onDate: aDate usingSalesBook: aSalesBook  
	| bill  |
	(aCart isEmpty) ifTrue: [^Error signal: self class cannotCheckoutEmptyCartMessage].
	(aCard isExpiredOn: aDate) ifTrue:[^Error signal: self class cannotCheckoutWithExpiredCardMessage.].
	bill _ aCart contentsTotalPrice.
	merchantProcessor debit: bill from: aCard.
	aSalesBook addAll: aCart contents asOrderedCollection.
	aSalesBook add: bill.
	^bill.! !


!Cashier methodsFor: 'initialization' stamp: 'EMI 11/24/2020 18:23:53'!
initializeWithPriceList: aPriceListDictionary withMerchantProcessor: aMerchantProcessor 
	priceListDictionary := aPriceListDictionary.
	merchantProcessor := aMerchantProcessor.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error messages' stamp: 'EMI 11/24/2020 17:33:30'!
cannotCheckoutEmptyCartMessage
	^'Cannot checkout empty cart.'.! !

!Cashier class methodsFor: 'error messages' stamp: 'EMI 11/19/2020 19:46:32'!
cannotCheckoutWithExpiredCardMessage
	^'Cannot checkout with expired card.'.! !

!Cashier class methodsFor: 'error messages' stamp: 'EMI 11/19/2020 19:28:23'!
cannotCheckoutWithInvalidCardMessage
	^'Cannot checkout with invalid card.'.! !


!Cashier class methodsFor: 'instance creation' stamp: 'EMI 11/24/2020 18:24:03'!
withPriceList: aPriceListDictionary withMerchantProcessor: aMerchantProcessor 
	^self new initializeWithPriceList: aPriceListDictionary withMerchantProcessor: aMerchantProcessor ! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'id expirationDate name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'accessing' stamp: 'EMI 11/23/2020 20:18:47'!
expiration
	^expirationDate.! !

!CreditCard methodsFor: 'accessing' stamp: 'EMI 11/23/2020 19:59:01'!
expirationMonth
	^expirationDate monthNumber.! !

!CreditCard methodsFor: 'accessing' stamp: 'EMI 11/23/2020 19:58:50'!
expirationYear
	^expirationDate yearNumber.! !

!CreditCard methodsFor: 'accessing' stamp: 'EMI 11/19/2020 19:55:17'!
id
	^id.! !

!CreditCard methodsFor: 'accessing' stamp: 'EMI 11/19/2020 19:55:57'!
ownerFullName
	^name.! !


!CreditCard methodsFor: 'testing' stamp: 'EMI 11/26/2020 20:47:19'!
isExpiredOn: aDate
	^expirationDate  < aDate.! !


!CreditCard methodsFor: 'initialize' stamp: 'EMI 11/26/2020 20:56:32'!
initializeWithID: anID withExpirationDate: aDate ofOwner: aName.
	(anID isEmpty) ifTrue: [^Error signal: self class cannotCreateCardWithInvalidIDMessage].
	(aName isEmpty) ifTrue: [^Error signal: self class cannotCreateCardWithInvalidNameMessage].
	(aDate isKindOf: GregorianMonthOfYear) ifFalse: [^Error signal: self class cannotCreateCardWithInvalidDateFormatMessage.].
	
	id _ anID.
	expirationDate _ aDate.
	name _ aName copyFrom: 1 to: (30 min: aName size).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'error messages' stamp: 'EMI 11/24/2020 17:32:49'!
cannotCreateCardWithInvalidDateFormatMessage
	^'Cannot create card with invalid date format. Use GregorianMonthOfYear.'! !

!CreditCard class methodsFor: 'error messages' stamp: 'EMI 11/24/2020 17:33:00'!
cannotCreateCardWithInvalidIDMessage
	^'Cannot create card with invalid ID, must be a positive integer'.! !

!CreditCard class methodsFor: 'error messages' stamp: 'EMI 11/24/2020 17:33:12'!
cannotCreateCardWithInvalidNameMessage
	^'Cannot create card with invalid name. Must not be empty or exceed 30 characters.'.! !


!CreditCard class methodsFor: 'instance creation' stamp: 'EMI 11/19/2020 19:57:48'!
of: aName withID: anID withExpirationDate: aDate
	^self new initializeWithID: anID withExpirationDate: aDate ofOwner: aName. ! !


!classDefinition: #MerchantProcessorSimulator category: 'TusLibros'!
Object subclass: #MerchantProcessorSimulator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimulator methodsFor: 'operations' stamp: 'EMI 11/23/2020 21:22:25'!
debit: anAmount from: aCreditCard
	^self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorSimulator class' category: 'TusLibros'!
MerchantProcessorSimulator class
	instanceVariableNames: ''!

!MerchantProcessorSimulator class methodsFor: 'error messages' stamp: 'EMI 11/24/2020 17:34:19'!
cannotDebitFromCreditCardWithInvalidIDMessage
	^'Cannot debit from credit card with invalid ID.'! !

!MerchantProcessorSimulator class methodsFor: 'error messages' stamp: 'EMI 11/24/2020 17:34:30'!
cannotDebitUsingCardWithIncorrectNameMessage
	^'Cannot debit from credit card with incorrect name.'! !

!MerchantProcessorSimulator class methodsFor: 'error messages' stamp: 'EMI 11/24/2020 18:38:57'!
cannotDebitUsingCardWithInsufficientFundsMessage
	^'Cannot debit using card with insufficient funds.'.! !


!classDefinition: #AlwaysValidMerchantProcessorSimulator category: 'TusLibros'!
MerchantProcessorSimulator subclass: #AlwaysValidMerchantProcessorSimulator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!AlwaysValidMerchantProcessorSimulator methodsFor: 'operations' stamp: 'EMI 11/23/2020 20:47:48'!
debit: anAmount from: aCreditCard
	^true.! !


!classDefinition: #OnlyChecksIDsAndFundsMerchantProcessorSimulator category: 'TusLibros'!
MerchantProcessorSimulator subclass: #OnlyChecksIDsAndFundsMerchantProcessorSimulator
	instanceVariableNames: 'registeredFundsForIDs'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!OnlyChecksIDsAndFundsMerchantProcessorSimulator methodsFor: 'as yet unclassified' stamp: 'EMI 11/24/2020 18:38:57'!
debit: anAmount from: aCreditCard
	| funds |
	funds _ registeredFundsForIDs at: aCreditCard id ifAbsent:[^Error signal: self class cannotDebitFromCreditCardWithInvalidIDMessage.].
	(funds < anAmount) ifTrue: [^Error signal: self class cannotDebitUsingCardWithInsufficientFundsMessage.].
	^true.! !

!OnlyChecksIDsAndFundsMerchantProcessorSimulator methodsFor: 'as yet unclassified' stamp: 'EMI 11/24/2020 17:47:42'!
initialize: anIDToFundsDictionary
	registeredFundsForIDs _ anIDToFundsDictionary.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OnlyChecksIDsAndFundsMerchantProcessorSimulator class' category: 'TusLibros'!
OnlyChecksIDsAndFundsMerchantProcessorSimulator class
	instanceVariableNames: ''!

!OnlyChecksIDsAndFundsMerchantProcessorSimulator class methodsFor: 'as yet unclassified' stamp: 'EMI 11/24/2020 17:48:05'!
initialize: anIDToFundsDictionary
	^self new initialize: anIDToFundsDictionary.! !


!classDefinition: #OnlyChecksIDsAndNamesMerchantProcessorSimulator category: 'TusLibros'!
MerchantProcessorSimulator subclass: #OnlyChecksIDsAndNamesMerchantProcessorSimulator
	instanceVariableNames: 'registeredNamesForIDs'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!OnlyChecksIDsAndNamesMerchantProcessorSimulator methodsFor: 'initialization' stamp: 'EMI 11/23/2020 21:28:46'!
initialize: anIDToNamesDictionary
	registeredNamesForIDs _ anIDToNamesDictionary.! !


!OnlyChecksIDsAndNamesMerchantProcessorSimulator methodsFor: 'operations' stamp: 'EMI 11/24/2020 17:34:30'!
debit: anAmount from: aCreditCard
	| validName |
	validName _ registeredNamesForIDs at: aCreditCard id ifAbsent:[^Error signal: self class cannotDebitFromCreditCardWithInvalidIDMessage.].
	(validName = aCreditCard ownerFullName) ifFalse: [^Error signal: self class cannotDebitUsingCardWithIncorrectNameMessage.].
	^true.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OnlyChecksIDsAndNamesMerchantProcessorSimulator class' category: 'TusLibros'!
OnlyChecksIDsAndNamesMerchantProcessorSimulator class
	instanceVariableNames: ''!

!OnlyChecksIDsAndNamesMerchantProcessorSimulator class methodsFor: 'instance creation' stamp: 'EMI 11/23/2020 21:28:35'!
initialize: anIDToNamesDictionary
	^self new initialize: anIDToNamesDictionary.! !


!classDefinition: #OnlyChecksIDsMerchantProcessorSimulator category: 'TusLibros'!
MerchantProcessorSimulator subclass: #OnlyChecksIDsMerchantProcessorSimulator
	instanceVariableNames: 'validIDs'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!OnlyChecksIDsMerchantProcessorSimulator methodsFor: 'initialization' stamp: 'EMI 11/23/2020 20:57:26'!
initializeWith: aSetOfValidIDs
	validIDs _ aSetOfValidIDs.! !


!OnlyChecksIDsMerchantProcessorSimulator methodsFor: 'operations' stamp: 'EMI 11/24/2020 17:34:19'!
debit: anAmount from: aCreditCard
	(validIDs includes: aCreditCard id) ifFalse: [^Error signal: self class cannotDebitFromCreditCardWithInvalidIDMessage].
	^true.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OnlyChecksIDsMerchantProcessorSimulator class' category: 'TusLibros'!
OnlyChecksIDsMerchantProcessorSimulator class
	instanceVariableNames: ''!

!OnlyChecksIDsMerchantProcessorSimulator class methodsFor: 'instance creation' stamp: 'EMI 11/23/2020 20:56:54'!
initialize: aSetOfValidIDs
	^self new initializeWith: aSetOfValidIDs.! !


!classDefinition: #RESTInterface category: 'TusLibros'!
Object subclass: #RESTInterface
	instanceVariableNames: 'authenticator priceList carts currentCartID cashier purchasesByClient clientIDbyCartID'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RESTInterface methodsFor: 'API' stamp: 'EMI 11/30/2020 19:13:23'!
addToCart: aCartID productName: aProductName quantity: aProductAmount
	| cart |
	cart _ carts at: aCartID ifAbsent:[^Error signal: self class cannotAddProductToCartWithInvalidCartID.].
	cart add: aProductName amount: aProductAmount.! !

!RESTInterface methodsFor: 'API' stamp: 'EMI 11/30/2020 20:49:59'!
checkout: aCartID withCardNumber: aCardNumber withCardExpDate: aCardDateString withCardOwnerName: aCardOwnerName
	| cart card date salesBook clientID|
	salesBook _ OrderedCollection new.
	cart _ carts at: aCartID ifAbsent:[^Error signal: self class cannotCheckoutCartWithInvalidCartID.].
	date _ GregorianMonthOfYear current.
	card _ CreditCard of: aCardOwnerName withID: aCardNumber withExpirationDate: (self formatDate: aCardDateString).
	cashier checkout: cart usingCard: card onDate: date usingSalesBook: salesBook.
	clientID _ clientIDbyCartID at: aCartID.
	(purchasesByClient at: clientID) addAll: cart contents.
	carts removeKey: aCartID.
	clientIDbyCartID removeKey: aCartID.! !

!RESTInterface methodsFor: 'API' stamp: 'EMI 11/30/2020 20:50:40'!
createCart: anID withPassword: aPassword
	| password cartID |
	password _ authenticator at:anID ifAbsent:[^Error signal: self class cannotCreateCartWithInvalidID.].
	password = aPassword ifFalse:[^Error signal: self class cannotCreateCartWithInvalidPassword.].
	cartID _ self newCartID.
	carts add: cartID -> (Cart createUsingPriceList: priceList).
	clientIDbyCartID add: cartID->anID.
	(purchasesByClient includesKey: anID) ifFalse: [purchasesByClient add: anID->(Bag new)].
	^cartID.! !

!RESTInterface methodsFor: 'API' stamp: 'EMI 11/30/2020 19:03:24'!
listCart: aCartID
	(carts includesKey: aCartID) ifFalse: [^Error signal: RESTInterface cannotListCartWithInvalidCartID].
	^(carts at: aCartID) contents.! !

!RESTInterface methodsFor: 'API' stamp: 'EMI 11/30/2020 21:10:19'!
listPurchases: aClientID withPassword: aPassword
	| password purchases bill products result|
	password _ authenticator at: aClientID ifAbsent:[^Error signal: self class cannotListPurchasesUsingInvalidID.].
	(password = aPassword) ifFalse: [^Error signal: self class cannotListPurchasesUsingInvalidPassword.].
	
	result _ OrderedCollection new.
	purchases _ purchasesByClient at: aClientID ifAbsent:[^result].
	
	bill _ 0.
	purchases do: [:anItem | bill _ bill + priceList at: anItem].
	
	
	products _ purchases asSet.
	products do:[:aProduct | result add: aProduct. 
					     result add: (purchases occurrencesOf: aProduct)].
	result add: bill.
	^result
	! !


!RESTInterface methodsFor: 'private' stamp: 'EMI 11/30/2020 19:38:51'!
formatDate: aDateString
	| monthNumber yearNumber |
	monthNumber _ (aDateString copyFrom: 1 to: 2) asInteger. 
	yearNumber _ (aDateString copyFrom: 3 to: 6) asInteger.
	^GregorianMonthOfYear yearNumber: yearNumber monthNumber: monthNumber.! !

!RESTInterface methodsFor: 'private' stamp: 'EMI 11/30/2020 19:01:07'!
newCartID
	| cartID |
	cartID _ currentCartID.
	currentCartID _ currentCartID + 1.
	^cartID.! !


!RESTInterface methodsFor: 'initialization' stamp: 'EMI 11/30/2020 20:42:51'!
initializeWithAuthenticator: anAuthenticator withPriceList: aPriceList withCashier: aCashier   
	authenticator _ anAuthenticator.
	priceList _ aPriceList.
	currentCartID _ 1.
	carts _ Dictionary new.
	purchasesByClient _ Dictionary new.
	clientIDbyCartID _ Dictionary new.
	cashier _ aCashier.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RESTInterface class' category: 'TusLibros'!
RESTInterface class
	instanceVariableNames: ''!

!RESTInterface class methodsFor: 'error messages' stamp: 'EMI 11/30/2020 19:12:40'!
cannotAddProductToCartWithInvalidCartID
	^'Cannot add product to cart with invalid CartID'.! !

!RESTInterface class methodsFor: 'error messages' stamp: 'EMI 11/30/2020 19:44:13'!
cannotCheckoutCartWithInvalidCartID
	^'Cannot checkout cart with invalid cartID'.! !

!RESTInterface class methodsFor: 'error messages' stamp: 'EMI 11/30/2020 18:20:24'!
cannotCreateCartWithInvalidID
	^'Cannot create cart with invalid ID'.! !

!RESTInterface class methodsFor: 'error messages' stamp: 'EMI 11/30/2020 18:22:35'!
cannotCreateCartWithInvalidPassword
	^'Cannot create cart with invalid password'.! !

!RESTInterface class methodsFor: 'error messages' stamp: 'EMI 11/30/2020 18:34:19'!
cannotListCartWithInvalidCartID
	^'Cannot list cart using invalid cart ID'.! !

!RESTInterface class methodsFor: 'error messages' stamp: 'EMI 11/30/2020 21:08:41'!
cannotListPurchasesUsingInvalidID
	^'Cannot ListPurchases using invalid ID'.! !

!RESTInterface class methodsFor: 'error messages' stamp: 'EMI 11/30/2020 21:09:18'!
cannotListPurchasesUsingInvalidPassword
	^'Cannot ListPurchases using invalid password'.! !


!RESTInterface class methodsFor: 'instance creation' stamp: 'EMI 11/30/2020 19:31:20'!
withAuthenticator: anAuthenticator withPriceList: aPriceList withCashier: aCashier   
	^self new initializeWithAuthenticator: anAuthenticator withPriceList: aPriceList withCashier: aCashier ! !
