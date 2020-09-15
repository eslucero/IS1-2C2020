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

!I class methodsFor: 'as yet unclassified' stamp: 'Emi 9/14/2020 22:04:56'!
+ unNumeroDePeano
	^unNumeroDePeano next.! !

!I class methodsFor: 'as yet unclassified' stamp: 'Emi 9/14/2020 22:04:51'!
- unNumeroDePeano
	^self error: 'No se puede restar al I'.! !

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

!II class methodsFor: 'as yet unclassified' stamp: 'Emi 9/14/2020 22:05:05'!
+ unNumeroDePeano
	^self previous + unNumeroDePeano next.! !

!II class methodsFor: 'as yet unclassified' stamp: 'Emi 9/14/2020 22:05:08'!
- unNumeroDePeano
	^ self.! !

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
