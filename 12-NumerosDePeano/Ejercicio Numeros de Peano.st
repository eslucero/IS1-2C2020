!classDefinition: #I category: #'Ejercicio Numeros de Peano'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio Numeros de Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #'Ejercicio Numeros de Peano'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'as yet unclassified' stamp: 'Emi 9/16/2020 18:23:32'!
* unNumeroDePeano
	^unNumeroDePeano! !

!I class methodsFor: 'as yet unclassified' stamp: 'Emi 9/14/2020 22:04:56'!
+ unNumeroDePeano
	^unNumeroDePeano next.! !

!I class methodsFor: 'as yet unclassified' stamp: 'Emi 9/16/2020 18:51:19'!
- unNumeroDePeano
	^self error: self descripcionDeErrorDeNumerosNegativosNoSoportados.! !

!I class methodsFor: 'as yet unclassified' stamp: 'Emi 9/16/2020 22:59:26'!
/ unNumeroDePeano
	^self = unNumeroDePeano 
		ifTrue:[^I]
		ifFalse:[^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor].! !

!I class methodsFor: 'as yet unclassified' stamp: 'Emi 9/16/2020 22:28:48'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir al numerador por un numero mayor'.! !

!I class methodsFor: 'as yet unclassified' stamp: 'Emi 9/16/2020 18:50:41'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'No existen numeros negativos ni el cero.'.! !

!I class methodsFor: 'as yet unclassified' stamp: 'Emi 9/14/2020 22:04:42'!
next
	^self createChildNamed: self name,'I'.! !

!I class methodsFor: 'as yet unclassified' stamp: 'Emi 9/14/2020 22:04:37'!
previous
	^self error: 'El I no tiene anterior.'.! !


!classDefinition: #II category: #'Ejercicio Numeros de Peano'!
I subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio Numeros de Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #'Ejercicio Numeros de Peano'!
II class
	instanceVariableNames: ''!

!II class methodsFor: 'as yet unclassified' stamp: 'Emi 9/16/2020 18:25:57'!
* unNumeroDePeano
	^(self previous * unNumeroDePeano) + unNumeroDePeano! !

!II class methodsFor: 'as yet unclassified' stamp: 'Emi 9/14/2020 22:05:05'!
+ unNumeroDePeano
	^self previous + unNumeroDePeano next.! !

!II class methodsFor: 'as yet unclassified' stamp: 'Emi 9/16/2020 18:17:59'!
- unNumeroDePeano
	^I = unNumeroDePeano
		ifTrue: [^self previous]
		ifFalse:[^self previous - unNumeroDePeano previous.]! !

!II class methodsFor: 'as yet unclassified' stamp: 'Emi 9/16/2020 23:04:20'!
/ unNumeroDePeano
	^self = unNumeroDePeano
		ifTrue:[^I]
		ifFalse:[| resta | 
			[resta _ (self - unNumeroDePeano )] on: self descripcionDeErrorDeNumerosNegativosNoSoportados do: [^self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor ].
			^(resta/ unNumeroDePeano) next].! !

!II class methodsFor: 'as yet unclassified' stamp: 'Emi 9/14/2020 22:05:12'!
previous
	^self parent.! !


!classDefinition: #III category: #'Ejercicio Numeros de Peano'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio Numeros de Peano'!


!classDefinition: #IIII category: #'Ejercicio Numeros de Peano'!
III subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio Numeros de Peano'!


!classDefinition: #IIIII category: #'Ejercicio Numeros de Peano'!
IIII subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio Numeros de Peano'!


!classDefinition: #IIIIII category: #'Ejercicio Numeros de Peano'!
IIIII subclass: #IIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio Numeros de Peano'!


!classDefinition: #IIIIIII category: #'Ejercicio Numeros de Peano'!
IIIIII subclass: #IIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio Numeros de Peano'!


!classDefinition: #IIIIIIII category: #'Ejercicio Numeros de Peano'!
IIIIIII subclass: #IIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio Numeros de Peano'!


!classDefinition: #NumerosDePeanoTest category: #'Ejercicio Numeros de Peano'!
DenotativeObject subclass: #NumerosDePeanoTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio Numeros de Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NumerosDePeanoTest class' category: #'Ejercicio Numeros de Peano'!
NumerosDePeanoTest class
	instanceVariableNames: ''!

!NumerosDePeanoTest class methodsFor: 'as yet unclassified' stamp: 'Emi 9/14/2020 20:50:19'!
test01SiguienteDeIEsII
	Assert that: I next isEqualTo: II! !

!NumerosDePeanoTest class methodsFor: 'as yet unclassified' stamp: 'Emi 9/14/2020 20:50:12'!
test02SiguienteDeIIEsIII
	Assert that: II next isEqualTo: III! !

!NumerosDePeanoTest class methodsFor: 'as yet unclassified' stamp: 'Emi 9/14/2020 20:53:00'!
test03LaSumaDeIYIEsElSiguiente
	Assert that: I + I isEqualTo: I next! !

!NumerosDePeanoTest class methodsFor: 'as yet unclassified' stamp: 'Emi 9/14/2020 21:25:54'!
test04LaSumaDeIIYIEsElSiguiente
	Assert that: II + I isEqualTo: II next! !

!NumerosDePeanoTest class methodsFor: 'as yet unclassified' stamp: 'Emi 9/14/2020 21:26:21'!
test05LaSumaDeIIIYIEsElSiguiente
	Assert that: III + I isEqualTo: III next! !

!NumerosDePeanoTest class methodsFor: 'as yet unclassified' stamp: 'Emi 9/14/2020 21:27:26'!
test06AnteriorDeIIEsI
	Assert that: II previous isEqualTo: I! !

!NumerosDePeanoTest class methodsFor: 'as yet unclassified' stamp: 'Emi 9/14/2020 21:27:41'!
test07AnteriorDeIIIEsII
	Assert that: III previous isEqualTo: II! !

!NumerosDePeanoTest class methodsFor: 'as yet unclassified' stamp: 'Emi 9/14/2020 21:35:43'!
test08LaSumaDeIYIIEsElSiguiente
	Assert that: I + II isEqualTo: ((II previous) + I) next! !
