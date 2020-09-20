!classDefinition: #CantSuspend category: #'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'Emi 9/20/2020 19:25:30'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self assert: (self calcularTiempoDeEjecucionEnMilliDe: [customerBook addCustomerNamed: self class nombreJohnLennon .] esMenorA: (50 * millisecond)).
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Emi 9/20/2020 19:27:19'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook  |
	
	customerBook := CustomerBook new.
	
	customerBook addCustomerNamed: self class nombrePaulMcCartney .

	self assert: (self calcularTiempoDeEjecucionEnMilliDe: [customerBook removeCustomerNamed: self class nombrePaulMcCartney .] esMenorA: (100 * millisecond)).
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Emi 9/20/2020 18:57:28'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	self verSiMetodo: [customerBook addCustomerNamed: ''.] 
		respondeError: Error 
		entoncesVerificar: [ :anError | 
								self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
								self assert: customerBook isEmpty ].
	! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Emi 9/20/2020 19:25:57'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook |
			
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: self class nombreJohnLennon .
	
	self verSiMetodo: [ customerBook removeCustomerNamed: self class nombrePaulMcCartney .] 
		respondeError: NotFound 
		entoncesVerificar: [ :anError | self assert: (self verificarUnicoClienteDe: customerBook es: self class nombreJohnLennon). ].
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Emi 9/20/2020 19:26:07'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self agregarYSuspenderClienteDe: customerBook conNombre: self class nombrePaulMcCartney .
	
	self assert: (self cantidadClientesPorCondicionDe: customerBook  activos: 0  suspendidos: 1).
	self assert: (customerBook includesCustomerNamed: self class nombrePaulMcCartney ).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Emi 9/20/2020 19:26:27'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self agregarYSuspenderClienteDe: customerBook conNombre: self class nombrePaulMcCartney .
	customerBook removeCustomerNamed: self class nombrePaulMcCartney .
	
	self assert: (self cantidadClientesPorCondicionDe: customerBook activos: 0 suspendidos: 0).
	self deny: (customerBook includesCustomerNamed: self class nombrePaulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Emi 9/20/2020 19:26:39'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook |
			
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: self class nombreJohnLennon .
	
	self verSiMetodo: [ customerBook suspendCustomerNamed: 'George Harrison'.] 
		respondeError: CantSuspend 
	 	entoncesVerificar: [ :anError | self assert: (self verificarUnicoClienteDe: customerBook es: self class nombreJohnLennon ).].

! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Emi 9/20/2020 19:26:54'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook |
			
	customerBook := CustomerBook new.
	self agregarYSuspenderClienteDe: customerBook conNombre: self class nombreJohnLennon.
	
	self verSiMetodo:  [customerBook suspendCustomerNamed: self class nombreJohnLennon.]  
		respondeError: CantSuspend  
		entoncesVerificar: [ :anError | self assert: (self verificarUnicoClienteDe: customerBook es: self class nombreJohnLennon).].
	
! !


!CustomerBookTest methodsFor: 'refactor' stamp: 'Emi 9/20/2020 18:20:18'!
agregarYSuspenderClienteDe: customerBook conNombre: clienteNombreCompleto

	customerBook addCustomerNamed: clienteNombreCompleto.
	customerBook suspendCustomerNamed: clienteNombreCompleto! !

!CustomerBookTest methodsFor: 'refactor' stamp: 'Emi 9/20/2020 17:18:39'!
calcularTiempoDeEjecucionEnMilliDe: unMetodo esMenorA: unTiempoEnMilli

	| tiempoInicio tiempoFinal |

	tiempoInicio := Time millisecondClockValue * millisecond.
	unMetodo value.
	tiempoFinal := Time millisecondClockValue * millisecond.
	
	^(tiempoFinal - tiempoInicio) < unTiempoEnMilli.! !

!CustomerBookTest methodsFor: 'refactor' stamp: 'Emi 9/20/2020 18:13:38'!
cantidadClientesPorCondicionDe: unCustomerBook activos: cantidadClientesActivos suspendidos: cantidadClientesSuspendidos
	^(unCustomerBook numberOfActiveCustomers = cantidadClientesActivos) 
	and: (unCustomerBook numberOfSuspendedCustomers = cantidadClientesSuspendidos) 
	and: (unCustomerBook numberOfCustomers = (cantidadClientesActivos + cantidadClientesSuspendidos)).! !

!CustomerBookTest methodsFor: 'refactor' stamp: 'Emi 9/20/2020 17:44:12'!
verSiMetodo: unMetodo respondeError: unError entoncesVerificar: unBloque
	[unMetodo value.
	self fail.]
		on: unError 
		do: [ :anError | unBloque value: anError.].! !

!CustomerBookTest methodsFor: 'refactor' stamp: 'Emi 9/20/2020 19:04:15'!
verificarUnicoClienteDe: unCustomerBook es: clienteNombreCompleto
	^(unCustomerBook numberOfCustomers = 1) and: (unCustomerBook includesCustomerNamed: clienteNombreCompleto ).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBookTest class' category: #'CodigoRepetido-Ejercicio'!
CustomerBookTest class
	instanceVariableNames: ''!

!CustomerBookTest class methodsFor: 'as yet unclassified' stamp: 'Emi 9/20/2020 19:16:49'!
nombreJohnLennon
	^'John Lennon'! !

!CustomerBookTest class methodsFor: 'as yet unclassified' stamp: 'Emi 9/20/2020 19:20:32'!
nombrePaulMcCartney
	^'Paul McCartney'! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'refactor' stamp: 'Emi 9/20/2020 18:52:24'!
removeCustomerNamed: aName from: aCustomerCollection
 
	1 to: aCustomerCollection size do: 	
	[ :index |
		aName = (aCustomerCollection at: index)
			ifTrue: [
				aCustomerCollection removeAt: index.
				^ aName 
			] 
	].
	
	^NotFound signal.
! !


!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'Emi 9/20/2020 18:52:12'!
removeCustomerNamed: aName 

	[^self removeCustomerNamed: aName from: active.] 
	on: NotFound
	do:[^self removeCustomerNamed: aName from: suspended.].
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/17/2020 06:01:49'!
customerAlreadyExistsErrorMessage

	^'customer already exists!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/17/2020 06:02:05'!
customerCanNotBeEmptyErrorMessage

	^'customer name cannot be empty!!'! !
