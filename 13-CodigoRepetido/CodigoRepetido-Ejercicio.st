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
	instanceVariableNames: 'testCustomerBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'Emi 9/21/2020 17:10:58'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds
	self assert: (self calcularTiempoDeEjecucionEnMilliDe: [testCustomerBook addCustomerNamed: self class nombreJohnLennon .] esMenorA: (50 * millisecond)).
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Emi 9/21/2020 17:11:30'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds
	testCustomerBook addCustomerNamed: self class nombrePaulMcCartney .

	self assert: (self calcularTiempoDeEjecucionEnMilliDe: [testCustomerBook removeCustomerNamed: self class nombrePaulMcCartney .] esMenorA: (100 * millisecond)).
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Emi 9/23/2020 18:13:13'!
test03CanNotAddACustomerWithEmptyName 
	self verSiBloque: [testCustomerBook addCustomerNamed: ''.] 
		respondeError: Error 
		entoncesVerificar: [ :anError | 
								self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
								self assert: testCustomerBook isEmpty ].
	! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Emi 9/23/2020 18:13:13'!
test04CanNotRemoveAnInvalidCustomer
	testCustomerBook addCustomerNamed: self class nombreJohnLennon .
	
	self verSiBloque: [ testCustomerBook removeCustomerNamed: self class nombrePaulMcCartney .] 
		respondeError: NotFound 
		entoncesVerificar: [ :anError | self assert: (self verificarUnicoClienteDe: testCustomerBook es: self class nombreJohnLennon). ].
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Emi 9/23/2020 18:49:06'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook
	self agregarYSuspenderClienteDe: testCustomerBook conNombre: self class nombrePaulMcCartney .
	
	self assert: (self verificarClientesDe: testCustomerBook conActivos: 0 conSuspendidos: 1 PaulMcCartneyEsta: true).

	"self assert: (self verificarCantidadClientesPorCondicionDe: testCustomerBook  activos: 0  suspendidos: 1).
	self assert: (testCustomerBook includesCustomerNamed: self class nombrePaulMcCartney )."
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Emi 9/23/2020 18:45:37'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook
	self agregarYSuspenderClienteDe: testCustomerBook conNombre: self class nombrePaulMcCartney .
	testCustomerBook removeCustomerNamed: self class nombrePaulMcCartney .
	
	self assert: (self verificarClientesDe: testCustomerBook conActivos: 0 conSuspendidos: 0 PaulMcCartneyEsta: false).
	
	"self assert: (self verificarCantidadClientesPorCondicionDe: testCustomerBook activos: 0 suspendidos: 0).
	self deny: (testCustomerBook includesCustomerNamed: self class nombrePaulMcCartney)."


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Emi 9/23/2020 18:21:53'!
test07CanNotSuspendAnInvalidCustomer
	testCustomerBook addCustomerNamed: self class nombreJohnLennon .
	
	self verSiBloque: [testCustomerBook suspendCustomerNamed: 'George Harrison'.] 
		respondeError: CantSuspend 
	 	entoncesVerificar: [ :anError | self assert: (self verificarUnicoClienteDe: testCustomerBook es: self class nombreJohnLennon).].

! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Emi 9/23/2020 18:22:00'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	self agregarYSuspenderClienteDe: testCustomerBook conNombre: self class nombreJohnLennon.
	
	self verSiBloque: [testCustomerBook suspendCustomerNamed: self class nombreJohnLennon.]  
		respondeError: CantSuspend  
		entoncesVerificar: [ :anError | self assert: (self verificarUnicoClienteDe: testCustomerBook es: self class nombreJohnLennon).].
	
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

!CustomerBookTest methodsFor: 'refactor' stamp: 'Emi 9/21/2020 17:09:43'!
setUp
	testCustomerBook _ CustomerBook new.! !

!CustomerBookTest methodsFor: 'refactor' stamp: 'Emi 9/23/2020 18:14:38'!
verSiBloque: unBloque respondeError: unError entoncesVerificar: unBloqueDeCondiciones
	[unBloque value.
	self fail.]
		on: unError 
		do: [ :anError | unBloqueDeCondiciones value: anError.].! !

!CustomerBookTest methodsFor: 'refactor' stamp: 'Emi 9/23/2020 18:31:38'!
verificarCantidadClientesPorCondicionDe: unCustomerBook activos: cantidadClientesActivos suspendidos: cantidadClientesSuspendidos
	^(unCustomerBook numberOfActiveCustomers = cantidadClientesActivos) 
	and: (unCustomerBook numberOfSuspendedCustomers = cantidadClientesSuspendidos) 
	and: (unCustomerBook numberOfCustomers = (cantidadClientesActivos + cantidadClientesSuspendidos)).! !

!CustomerBookTest methodsFor: 'refactor' stamp: 'Emi 9/23/2020 18:49:33'!
verificarClientesDe: unCustomerBook conActivos: cantActivos conSuspendidos: cantSuspendidos PaulMcCartneyEsta: boolEsta

	| t |
       t _ self verificarCantidadClientesPorCondicionDe: unCustomerBook  activos: cantActivos  suspendidos: cantSuspendidos.
	
	(boolEsta)
	ifTrue: [^t and: (unCustomerBook includesCustomerNamed: self class nombrePaulMcCartney)] 
	ifFalse: [^t and: (unCustomerBook includesCustomerNamed: self class nombrePaulMcCartney) not].
! !

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
