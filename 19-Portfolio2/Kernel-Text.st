!classDefinition: #Character category: #'Kernel-Text'!
Object immediateSubclass: #Character
	instanceVariableNames: 'value'
	classVariableNames: 'CharacterTable UnaccentedTable UnicodeCodePoints LowercaseMappingTable LowercaseTruthTable UppercaseMappingTable UppercaseTruthTable LetterTruthTable'
	poolDictionaries: ''
	category: 'Kernel-Text'!
!Character commentStamp: '<historical>' prior: 0!
I represent a character by storing its associated Latin-9 code (ISO 8859-15). My instances are created uniquely, so that all instances of a character ($R, for example) are identical.!


!Character methodsFor: 'accessing' stamp: 'jmv 8/11/2016 09:49:58'!
asciiValue
	"Answer the value of the receiver that represents its ISO 8859-15 encoding.
	This is the same as ASCII for the first 128 characters."

	^self numericValue! !

!Character methodsFor: 'accessing' stamp: 'jmv 10/8/2018 18:39:19'!
codePoint
	"
	self assert: $A codePoint hex = '16r41'.
	self assert: $§ codePoint hex = '16r20AC'.
	"
	^self class unicodeCodePoints at: self numericValue + 1! !

!Character methodsFor: 'accessing' stamp: 'jmv 5/9/2017 19:49:32'!
digitValue
	"Answer 0-9 if the receiver is $0-$9, 10-35 if it is $A-$Z, and < 0 
	otherwise. This is used to parse literal numbers of radix 2-36.
	$0 numericValue = 48
	$9 numericValue = 57
	$A numericValue = 65
	$Z numericValue = 90 
	$7 digitValue = 7 
	"

	| nv |
	nv _ self numericValue.
	(nv between: 48 and: 57)
		ifTrue: [ ^ nv - 48 ].
	(nv between: 65 and: 90)
		ifTrue: [ ^ nv - 55 ].
	^ -1! !

!Character methodsFor: 'accessing' stamp: 'jmv 8/11/2016 09:43:22'!
immediateNumericValue
	"Answer the numeric value of the receiver, if instances happen to be immediate (i.e. as in Spur)"

	<primitive: 171>
	^self primitiveFailed! !

!Character methodsFor: 'accessing' stamp: 'jmv 9/2/2016 10:46:56'!
iso8859s15Code
	"Answer the value of the receiver that represents its ISO 8859-15 (Latin-9) encoding.
	Any implementation of Character like object beyond ISO-8859-15 should answer nil.
	Senders, please consider that this method might answer nil.
	See #iso8859s15CodeForUnicodeCodePoint:"

	^ self numericValue! !

!Character methodsFor: 'accessing' stamp: 'jmv 4/8/2019 14:19:18'!
leadingChar
	"See Squeak if curious."
	^ 0! !

!Character methodsFor: 'accessing' stamp: 'jmv 8/11/2016 09:46:09'!
nonImmediateNumericValue
	"Answer the numeric value of the receiver, if instances happen to be regular (i.e. not in Spur)"

	^self instVarAt: 1! !

!Character methodsFor: 'accessing' stamp: 'jmv 8/11/2016 09:47:05'!
numericValue
	"Answer the value of the receiver that represents its ISO 8859-15 (Latin-9) encoding."

	^ Character isImmediateClass
		ifTrue: [ self immediateNumericValue ]
		ifFalse: [ self nonImmediateNumericValue ]! !


!Character methodsFor: 'comparing' stamp: 'jmv 10/6/2010 18:18'!
< aCharacter 
	"Compare with the standard case sensitive collation order.
	This stuff should be in Character and not in String..."

	^String does: self collateBefore: aCharacter! !

!Character methodsFor: 'comparing' stamp: 'jmv 2/16/2016 16:06'!
<= aCharacter 
	"Answer whether the receiver is less than or equal to the argument."

	^(self > aCharacter) not! !

!Character methodsFor: 'comparing' stamp: 'jmv 4/28/2016 09:37'!
= aCharacter 
	"In Cuis, Characters are unique. Therefore #= and #== are equivalent."

"	<primitive: 110>"
	^self == aCharacter! !

!Character methodsFor: 'comparing' stamp: 'jmv 10/6/2010 18:18'!
> aCharacter 
	"Compare with the standard case sensitive collation order.
	This stuff should be in Character and not in String..."

	^String does: self collateAfter: aCharacter! !

!Character methodsFor: 'comparing' stamp: 'jmv 2/16/2016 16:06'!
>= aCharacter 
	"Answer whether the receiver is greater than or equal to the argument."

	^aCharacter <= self! !

!Character methodsFor: 'comparing' stamp: 'jmv 11/4/2019 11:03:26'!
hash
	"Hash is reimplemented because = is implemented."

	^self numericValue hash! !

!Character methodsFor: 'comparing' stamp: 'jmv 8/30/2016 11:07:40'!
identityHash
	"Answer the receiver's character code."

	"For Spur"
	<primitive: 171>

	"For preSpur (non-immediate Characters)"
	^super identityHash! !


!Character methodsFor: 'testing' stamp: 'jmv 12/8/2009 09:46'!
canBeGlobalVarInitial
	^self isUppercase! !

!Character methodsFor: 'testing' stamp: 'jmv 6/11/2019 12:14:09'!
is: aSymbol
	^ aSymbol == #Character or: [ super is: aSymbol ]! !

!Character methodsFor: 'testing' stamp: 'jmv 6/14/2011 22:53'!
isAccented
	^self isLetter and: [ self asUnaccented ~~ self ]! !

!Character methodsFor: 'testing'!
isAlphaNumeric
	"Answer whether the receiver is a letter or a digit."

	^self isLetter or: [self isDigit]! !

!Character methodsFor: 'testing' stamp: 'jmv 11/1/2016 22:06:16'!
isDigit
	"Answer whether the receiver is a digit."

	^ self numericValue between: 48 and: 57! !

!Character methodsFor: 'testing' stamp: 'pb 11/21/2017 02:29:43'!
isLetter
	"Answer whether the receiver is a letter."
	^ LetterTruthTable at: self numericValue + 1! !

!Character methodsFor: 'testing' stamp: 'jmv 11/1/2016 22:06:09'!
isLineSeparator
	"Answer whether the receiver is a line separator character:
	line feed, cr, or form feed."

	^ #(10 13 12) statePointsTo: self numericValue! !

!Character methodsFor: 'testing' stamp: 'pb 11/21/2017 02:24:10'!
isLowercase
	"Answer whether the receiver is a lowercase letter."
	^ LowercaseTruthTable at: self numericValue + 1.! !

!Character methodsFor: 'testing' stamp: 'HAW 10/2/2018 16:31:57'!
isRightBracket

	^self = $]! !

!Character methodsFor: 'testing' stamp: 'jmv 11/1/2016 22:06:06'!
isSeparator
	"Answer whether the receiver is one of the separator characters
	space, tab, lf, cr, or form feed."

	^ #(32 9 10 13 12) statePointsTo: self numericValue! !

!Character methodsFor: 'testing' stamp: 'di 4/3/1999 00:38'!
isSpecial
	"Answer whether the receiver is one of the special characters"

	^'+-/\*~<>=@,%|&?!!' includes: self! !

!Character methodsFor: 'testing' stamp: 'jmv 6/14/2011 22:53'!
isUnaccented
	^self isLetter and: [ self asUnaccented == self ]! !

!Character methodsFor: 'testing' stamp: 'pb 11/21/2017 02:24:25'!
isUppercase
	"Answer whether the receiver is an uppercase letter."
	^ UppercaseTruthTable at: self numericValue + 1.! !

!Character methodsFor: 'testing' stamp: 'jmv 12/14/2018 15:30:45'!
isValidInBinarySelectors
	"Can be part of a binary selector?
		$< isValidInBinarySelectors
		$| isValidInBinarySelectors
		$^ isValidInBinarySelectors
		$: isValidInBinarySelectors
	"
	^#(verticalBar upArrow xColon xBinary) statePointsTo: (Scanner typeTable at: self numericValue)! !

!Character methodsFor: 'testing' stamp: 'jmv 12/10/2016 01:26:44'!
isValidInIdentifiers
	"Can c be part of an identifier? (unary or keyword selector, or variable name)"

	^self isAlphaNumeric or: [ #( $_ ) statePointsTo: self ]! !

!Character methodsFor: 'testing' stamp: 'jmv 11/16/2015 14:56'!
isValidStartOfIdentifiers
	"Can c be the first character of an identifier? (unary or keyword selector, or variable name)"

	^self isLetter or: [ self  = $_ ]! !

!Character methodsFor: 'testing' stamp: 'jmv 10/6/2010 17:27'!
isVowel
	"Answer whether the receiver is one of the vowels, AEIOU, in upper or 
	lower case, and with various diacritical marks."

	^Character vowels includes: self! !

!Character methodsFor: 'testing' stamp: 'jmv 11/16/2015 14:51'!
tokenish
	"Answer whether the receiver is a valid token-character--letter, digit, or 
	colon."

	^self isValidInIdentifiers or: [self = $:]! !


!Character methodsFor: 'copying' stamp: 'eem 2/5/2014 12:53'!
shallowCopy
	"Answer the receiver, because Characters are unique."
	^self! !


!Character methodsFor: 'printing' stamp: 'jmv 7/29/2016 15:12:10'!
hex
	^ String
		with: ('0123456789ABCDEF' at: self numericValue//16+1)
		with: ('0123456789ABCDEF' at: self numericValue\\16+1)! !

!Character methodsFor: 'printing'!
isLiteral

	^true! !

!Character methodsFor: 'printing'!
printOn: aStream

	aStream nextPut: $$.
	aStream nextPut: self! !

!Character methodsFor: 'printing'!
storeOn: aStream
	"Character literals are preceded by '$'."

	aStream nextPut: $$; nextPut: self! !


!Character methodsFor: 'converting'!
asCharacter
	"Answer the receiver itself."

	^self! !

!Character methodsFor: 'converting' stamp: 'pb 11/21/2017 02:22:41'!
asLowercase
	^ LowercaseMappingTable at: self numericValue + 1.! !

!Character methodsFor: 'converting' stamp: 'sma 3/11/2000 17:21'!
asString
	^ String with: self! !

!Character methodsFor: 'converting' stamp: 'raa 5/26/2001 09:54'!
asSymbol 
	"Answer a Symbol consisting of the receiver as the only element."

	^Symbol internCharacter: self! !

!Character methodsFor: 'converting' stamp: 'tk 9/4/2000 12:05'!
asText
	^ self asString asText! !

!Character methodsFor: 'converting' stamp: 'jmv 10/8/2018 18:44:52'!
asUnaccented
	"
	$A asUnaccented
	$¡ asUnaccented
	(0 to: 255) collect: [ :i | (Character numericValue: i) asUnaccented ]
	(0 to: 255) collect: [ :i | (Character numericValue: i) asUnaccented  asLowercase]
	"
	^ Character
		numericValue: (self class unaccentedTable at: self numericValue + 1)! !

!Character methodsFor: 'converting' stamp: 'pb 11/21/2017 02:23:38'!
asUppercase
	"If the receiver is lowercase, answer its matching uppercase Character."
	^ UppercaseMappingTable at: self numericValue + 1.! !

!Character methodsFor: 'converting' stamp: 'jmv 9/2/2016 11:00:54'!
to: other
	"Answer with a collection in ascii order -- $a to: $z"
	^ (self numericValue to: other numericValue) collect:
				[:ascii | Character numericValue: ascii]! !

!Character methodsFor: 'converting' stamp: 'jmv 3/12/2018 15:47:49'!
withDiacriticalMark: anUnicodeCodePoint
	"Answer the character resulting from adding a diacritical mark (accent) to a letter.
	If the result is unsupported in ISO 8859-15, answer the receiver.
	Supported diacritical marks are:
		U+0300 	COMBINING GRAVE ACCENT
		U+0301 	COMBINING ACUTE ACCENT
		U+0302 	COMBINING CIRCUMFLEX ACCENT
		U+0303 	COMBINING TILDE
		U+0308 	COMBINING DIAERESIS
		U+030A 	COMBINING RING ABOVE
		U+030C 	COMBINING CARON
		$a withDiacriticalMark: 16r301
		$N withDiacriticalMark: $~
		$Z withDiacriticalMark: $v
		
		invalid:
		$9 withDiacriticalMark:$v
		$A withDiacriticalMark: $v
		$¡ withDiacriticalMark: $v
		$A withDiacriticalMark: 1244
		"
	| answer i |
	i _ ((anUnicodeCodePoint isNumber
			ifTrue: [#(16r300 16r301 16r302 16r303 16r308 16r30A 16r30C)]
			ifFalse: [#($` $' $^ $~ $" $∞ $v)]) indexOf: anUnicodeCodePoint
				) + 1.
	answer _ (Character accentedLetters detect: [ :group | group first = self ] ifNone: [ ^self ]) at: i.
	^answer = $- ifFalse: [answer] ifTrue: [self]! !


!Character methodsFor: 'object fileIn' stamp: 'jmv 8/11/2016 09:59:36'!
comeFullyUpOnReload: smartRefStream
	"Use existing an Character.  Don't use the new copy."

	^ self class numericValue: self numericValue! !


!Character methodsFor: 'fileman-testing' stamp: 'mu 3/2/2007 21:34'!
isDriveLetter
	^'ABCDEFGHIJKLMNOPQRSTUVWXYZ' includes: self asUppercase
	! !

!Character methodsFor: 'fileman-testing' stamp: 'mu 3/3/2007 09:45'!
isDriveSeparator
	^self == $:
	! !

!Character methodsFor: 'fileman-testing' stamp: 'mu 3/3/2007 19:37'!
isPathSeparator
	self = $\ ifTrue: [^true].
	self = $: ifTrue: [^true].
	self = $/ ifTrue: [^true].
	^false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Character class' category: #'Kernel-Text'!
Character class
	instanceVariableNames: ''!

!Character class methodsFor: 'class initialization' stamp: 'jmv 11/7/2013 18:33'!
accentedLetters
	"Answer all letters with all possible accents (combining diacritical marks).
	Order of this array is:
		unaccented
		U+0300 	COMBINING GRAVE ACCENT
		U+0301 	COMBINING ACUTE ACCENT
		U+0302 	COMBINING CIRCUMFLEX ACCENT
		U+0303 	COMBINING TILDE
		U+0308 	COMBINING DIAERESIS
		U+030A 	COMBINING RING ABOVE
		U+030C 	COMBINING CARON
	Do not include letters that can't have any accent in ISO 8859-15
	Denote unsupported combinations (for example A with caron, or N with accute accent) by a $-"
	^#(
		'A¿¡¬√ƒ≈-'
		'a‡·‚„‰Â-'
		'E»… -À--'
		'eËÈÍ-Î--'
		'IÃÕŒ-œ--'
		'iÏÌÓ-Ô--'
		'O“”‘’÷--'
		'oÚÛÙıˆ--'
		'UŸ⁄€-‹--'
		'u˘˙˚-¸--'
		'N---—---'
		'n---Ò---'
		'S------¶'
		's------®'
		'Y-›--æ--'
		'y-˝--ˇ--'
		'Z------¥'
		'z------∏'
	).! !

!Character class methodsFor: 'class initialization' stamp: 'len 5/21/2020 08:23:36'!
blackboardLetters
	"Answer the 'blackboard bold' or 'double struck' letters included in our font within the ASCII range.
	These are considered uppercase letters and can be used as identifiers (variable names, keyword or unary messages, etc)."
	^ 'ÇÉÑÖÜá'! !

!Character class methodsFor: 'class initialization' stamp: 'len 5/21/2020 08:24:19'!
greekLowercaseLetters
	"Answer the lowercase greek letters included in our font within the ASCII range.
	These are considered lowercase letters and can be used as identifiers (variable names, keyword or unary messages, etc)."
	^ 'àâäãåçéèµ'! !

!Character class methodsFor: 'class initialization' stamp: 'len 5/21/2020 08:24:46'!
greekUppercaseLetters
	"Answer the uppercase greek letters included in our font within the ASCII range.
	These are considered uppercase letters and can be used as identifiers (variable names, keyword or unary messages, etc)."
	^ 'ñóò'! !

!Character class methodsFor: 'class initialization' stamp: 'jmv 6/11/2019 11:05:22'!
initialize
	"Create the table of unique Characters.
	Character initialize
	"
	self initializeLookupTables.
	self initializeUnicodeCodePoints.! !

!Character class methodsFor: 'class initialization' stamp: 'len 5/21/2020 06:35:42'!
initializeLookupTables
	LowercaseMappingTable _ Array new: 256.
	LowercaseTruthTable _ Array new: 256.
	UppercaseMappingTable _ Array new: 256.
	UppercaseTruthTable _ Array new: 256.
	LetterTruthTable _ Array new: 256.
	UnaccentedTable _ ByteArray new: 256.
	0
		to: 255
		do: [ :idx | | char |
			"Default to an identity mapping with a false truth mapping"
			char _ self numericValue: idx.
			LowercaseMappingTable
				at: idx + 1
				put: char.
			LowercaseTruthTable
				at: idx + 1
				put: false.
			UppercaseMappingTable
				at: idx + 1
				put: char.
			UppercaseTruthTable
				at: idx + 1
				put: false.
			LetterTruthTable
				at: idx + 1
				put: false.
			UnaccentedTable at: idx + 1 put: idx].
	"Now override as needed"
	Character uppercaseLowercaseAndUnaccentedLetters do: [ :group | | uppercase lowercase |
		group size > 1
			ifTrue: [ | lowercaseChar uppercaseChar |
				uppercase _ group first numericValue.
				lowercase _ group second numericValue.
				lowercaseChar _ self numericValue: lowercase.
				uppercaseChar _ self numericValue: uppercase.
				LowercaseMappingTable
					at: lowercase + 1
					put: lowercaseChar.
				LowercaseMappingTable
					at: uppercase + 1
					put: lowercaseChar.
				LowercaseTruthTable
					at: lowercase + 1
					put: true.
				LetterTruthTable
					at: lowercase + 1
					put: true.
				UppercaseMappingTable
					at: lowercase + 1
					put: uppercaseChar.
				UppercaseMappingTable
					at: uppercase + 1
					put: uppercaseChar.
				UppercaseTruthTable
					at: uppercase + 1
					put: true.
				LetterTruthTable
					at: uppercase + 1
					put: true.
				group size > 2
					ifTrue: [|unaccentedUppercase unaccentedLowercase|
						unaccentedUppercase _ group third numericValue.
						unaccentedLowercase _ group fourth numericValue.
						UnaccentedTable at: uppercase+1 put: unaccentedUppercase.
						UnaccentedTable at: lowercase+1 put: unaccentedLowercase]]
			ifFalse: [ | lowercaseChar |
				lowercase _ group first numericValue.
				lowercaseChar _ self numericValue: lowercase.
				LowercaseMappingTable
					at: lowercase + 1
					put: lowercaseChar.
				UppercaseMappingTable
					at: lowercase + 1
					put: lowercaseChar.
				LowercaseTruthTable
					at: lowercase + 1
					put: true.
				UppercaseTruthTable
					at: lowercase + 1
					put: false.
				LetterTruthTable
					at: lowercase + 1
					put: true ]].
		Character greekLowercaseLetters do: [:each|
			LowercaseTruthTable at: each numericValue + 1 put: true.
			LetterTruthTable at: each numericValue + 1 put: true].
		Character greekUppercaseLetters do: [:each|
			LowercaseTruthTable at: each numericValue + 1 put: true.
			LetterTruthTable at: each numericValue + 1 put: true].
		Character blackboardLetters do: [:each|
			UppercaseTruthTable at: each numericValue + 1 put: true.
			LetterTruthTable at: each numericValue + 1 put: true]! !

!Character class methodsFor: 'class initialization' stamp: 'len 5/20/2020 17:34:43'!
initializeUnicodeCodePoints
	"
	Character initializeUnicodeCodePoints
	String streamContents: [ :strm | 28 to: 255 do: [ :i | strm nextPut: (Character numericValue: i) ]]
	"

	"Initialize the table of Unicode code points"
	UnicodeCodePoints _ Array new: 256.
	0 to: 255 do: [ :code |
		UnicodeCodePoints at: code + 1 put: code ].

	"Arrows"
	UnicodeCodePoints at: 28+1 put: 8592.		"left arrow"
	UnicodeCodePoints at: 29+1 put: 8594.		"right arrow"
	UnicodeCodePoints at: 30+1 put: 8593.		"up arrow"
	UnicodeCodePoints at: 31+1 put: 8595.		"down arrow"
	
	"The following codes are different in ISO 8859-15 from those in ISO 8859-1,
	so the character code is not equal to the Unicode code point"
	UnicodeCodePoints at: 16rA4+1 put: 16r20AC.		"euro sign"
	UnicodeCodePoints at: 16rA6+1 put: 16r160.		"latin capital letter S with caron"
	UnicodeCodePoints at: 16rA8+1 put: 16r161.		"latin small letter s with caron"
	UnicodeCodePoints at: 16rB4+1 put: 16r17D.		"latin capital letter Z with caron"
	UnicodeCodePoints at: 16rB8+1 put: 16r17E.		"latin small letter z with caron"
	UnicodeCodePoints at: 16rBC+1 put: 16r152.		"latin capital ligature OE"
	UnicodeCodePoints at: 16rBD+1 put: 16r153.		"latin small ligature oe"
	UnicodeCodePoints at: 16rBE+1 put: 16r178.		"latin capital letter Y with diaeresis"


	UnicodeCodePoints at: 16r80+1 put: 16r221E.		"INFINITY"
	UnicodeCodePoints at: 16r81+1 put: 16r2135.		"ALEF SYMBOL"
	UnicodeCodePoints at: 16r82+1 put: 16r2115.		"DOUBLE-STRUCK CAPITAL N"
	UnicodeCodePoints at: 16r83+1 put: 16r2124.		"DOUBLE-STRUCK CAPITAL Z"
	UnicodeCodePoints at: 16r84+1 put: 16r211A.		"DOUBLE-STRUCK CAPITAL Q"
	UnicodeCodePoints at: 16r85+1 put: 16r211D.		"DOUBLE-STRUCK CAPITAL R"
	UnicodeCodePoints at: 16r86+1 put: 16r2102.		"DOUBLE-STRUCK CAPITAL C"
	UnicodeCodePoints at: 16r87+1 put: 16r2119.		"DOUBLE-STRUCK CAPITAL P"
	UnicodeCodePoints at: 16r88+1 put: 16r03B1.		"alpha"
	UnicodeCodePoints at: 16r89+1 put: 16r03B2.		"beta"
	UnicodeCodePoints at: 16r8A+1 put: 16r03B3.		"gamma"
	UnicodeCodePoints at: 16r8B+1 put: 16r03B4.		"delta"
	UnicodeCodePoints at: 16r8C+1 put: 16r03B5.		"epsilon"
	UnicodeCodePoints at: 16r8D+1 put: 16r03BB.		"lambda"
	UnicodeCodePoints at: 16r8E+1 put: 16r03C0.		"pi"
	UnicodeCodePoints at: 16r8F+1 put: 16r03B6.		"zeta"
	UnicodeCodePoints at: 16r90+1 put: 16r2295.		"OPLUS"
	UnicodeCodePoints at: 16r91+1 put: 16r2297.		"OTIMES"
	UnicodeCodePoints at: 16r92+1 put: 16r2218.		"RING OPERATOR (circ)"
	UnicodeCodePoints at: 16r93+1 put: 16r2219.		"BULLET OPERATOR"
	UnicodeCodePoints at: 16r94+1 put: 16r22C4.		"DIAMOND OPERATOR"
	UnicodeCodePoints at: 16r95+1 put: 16r22C6.		"STAR OPERATOR"
	UnicodeCodePoints at: 16r96+1 put: 16r0394.		"Delta"
	UnicodeCodePoints at: 16r97+1 put: 16r0393.		"Gamma"
	UnicodeCodePoints at: 16r98+1 put: 16r03A9.		"Omega"
	UnicodeCodePoints at: 16r99+1 put: 16r21A0.		"SURJECTIVE ARROW"
	UnicodeCodePoints at: 16r9A+1 put: 16r21A3.		"INJECTIVE ARROW"
	UnicodeCodePoints at: 16r9B+1 put: 16r2194.		"BIJECTIVE ARROW"
	UnicodeCodePoints at: 16r9C+1 put: 16r21AA.		"INCLUSION ARROW"
	UnicodeCodePoints at: 16r9D+1 put: 16r21A6.		"MAPPING ARROW"
	UnicodeCodePoints at: 16r9E+1 put: 16r2202.		"PARTIAL DIFFERENTIAL"
	UnicodeCodePoints at: 16r9F+1 put: 16r221A.		"SQUARE ROOT"
! !

!Character class methodsFor: 'class initialization' stamp: 'jmv 10/8/2018 18:36:22'!
releaseClassState
	UnaccentedTable _ nil.
	UnicodeCodePoints _ nil! !

!Character class methodsFor: 'class initialization' stamp: 'jmv 6/14/2011 20:22'!
uppercaseLowercaseAndUnaccentedLetters
	"Answer all uppercase and lowercase letters in standard collation order.
	For accented characters, include the non-accented ones.
	Note that $ﬂ is 'LATIN SMALL LETTER SHARP S' and ISO 8859-15 doesn't have an uppercase version."
	^#(
		'Aa' '¿‡Aa' '¡·Aa' '¬‚Aa' '√„Aa' 'ƒ‰Aa' '≈ÂAa'
		'Bb' 'Cc' '«Á' 'Dd'
			'Ee' '»ËEe' '…ÈEe' ' ÍEe' 'ÀÎEe'
		'Ff' 'Gg' 'Hh'
			'Ii' 'ÃÏIi' 'ÕÌIi' 'ŒÓIi' 'œÔIi'
		'Jj' 'Kk' 'Ll' 'Mm' 'Nn' '—Ò'
			'Oo' '“ÚOo' '”ÛOo' '‘ÙOo' '’ıOo' '÷ˆOo'
		'Pp' 'Qq' 'Rr'
			'Ss' '¶®Ss'
		'Tt'
			'Uu' 'Ÿ˘Uu' '⁄˙Uu' '€˚Uu' '‹¸Uu'
		'Vv' 'Ww' 'Xx'
			'Yy' '›˝Yy' 'æˇYy'
			'Zz' '¥∏Zz' 
		'∆Ê' '–' 'ÿ¯' 'ﬁ˛' 'ﬂ' 'ºΩ'
	).! !

!Character class methodsFor: 'class initialization' stamp: 'jmv 10/6/2010 17:26'!
vowels
	"Answer a String with all the vowels"
	
	^'Aa¿‡¡·¬‚√„ƒ‰≈ÂEe»Ë…È ÍÀÎIiÃÏÕÌŒÓœÔOo“Ú”Û‘Ù’ı÷ˆUuŸ˘⁄˙€˚‹¸'! !


!Character class methodsFor: 'instance creation' stamp: 'jmv 9/19/2016 09:24:38'!
asciiValue: asciiValue
	"
	Answer the Character for the required asciiValue. Argument is a byte, i.e. in [0..255].
	values above 127, consider it an ISO 8859-15 code.
	
	self assert: (Character asciiValue: 16r41) = $A.
	self assert: (Character asciiValue: 16rA4) = $§.
	"
	^ Character numericValue: asciiValue! !

!Character class methodsFor: 'instance creation' stamp: 'jmv 9/5/2016 20:47:25'!
codePoint: codePoint
	"
	Answer nil if the Unicode codePoint is not a valid ISO 8859-15 character
	
	self assert: (Character codePoint: 16r41) = $A.
	self assert: (Character codePoint: 16r20AC) = $§.
	"
	^ (self iso8859s15CodeForUnicodeCodePoint: codePoint)
		ifNotNil: [ :code | Character numericValue: code ]! !

!Character class methodsFor: 'instance creation' stamp: 'jmv 8/11/2016 10:02:24'!
digitValue: x 
	"Answer the Character whose digit value is x. For example,
	 answer $9 for x=9, $0 for x=0, $A for x=10, $Z for x=35."

	| n |
	n := x asInteger.
	^self numericValue: (n < 10 ifTrue: [n + 48] ifFalse: [n + 55])! !

!Character class methodsFor: 'instance creation' stamp: 'jmv 8/11/2016 09:54:19'!
immediateNumericValue: anInteger
	"Answer the Character whose value is anInteger, if instances happen to be immediate (i.e. as in Spur)"

	<primitive: 170>
	^self primitiveFailed! !

!Character class methodsFor: 'instance creation'!
new
	"Creating new characters is not allowed."

	self error: 'cannot create new characters'! !

!Character class methodsFor: 'instance creation' stamp: 'jmv 8/11/2016 09:55:27'!
nonImmediateNumericValue: anInteger
	"Answer the Character whose value is anInteger, if instances happen to be regular (i.e. not in Spur)"

	^CharacterTable at: anInteger + 1! !

!Character class methodsFor: 'instance creation' stamp: 'jmv 11/1/2016 22:28:41'!
numericValue: anInteger
	"Answer the Character whose value is anInteger."

	"Just use the CharacterTable. It is faster."
	"^ Character isImmediateClass
		ifTrue: [ self immediateNumericValue: anInteger ]
		ifFalse: [ self nonImmediateNumericValue: anInteger ]."

	^CharacterTable at: anInteger + 1! !

!Character class methodsFor: 'instance creation' stamp: 'jmv 9/5/2016 21:06:16'!
safeCodePoint: asciiCodeOrCodePoint 
	"Answer the Character whose value is anInteger.
	Handle unicode code points > 255 without errors, trying to answer something reasonable"

	"Note: senders of #value:or: in '1002-RTFParser.cs' has many automatic conversion to ISO-8859-15 characters, that would be valuable here."
	(#(16r2019 16r201B) includes: asciiCodeOrCodePoint) ifTrue: [
		^$' ].
	(#(16r201C 16r201D 16r201F) includes: asciiCodeOrCodePoint) ifTrue: [
		^$" ].
	^(self codePoint: asciiCodeOrCodePoint)
		ifNil: [Character numericValue: 255 ]! !

!Character class methodsFor: 'instance creation' stamp: 'jmv 9/2/2016 11:02:15'!
separators
	^ #(32 "space"
		13 "cr"
		9 "tab"
		10 "line feed"
		12 "form feed")
		collect: [:v | Character numericValue: v]

	
! !


!Character class methodsFor: 'accessing untypeable characters' stamp: 'jmv 11/1/2016 22:31:20'!
arrowDown
	"
	Character arrowDown
	"
	^ $! !

!Character class methodsFor: 'accessing untypeable characters' stamp: 'jmv 11/1/2016 22:32:55'!
arrowLeft
	"
	Character arrowLeft
	"
	^ $! !

!Character class methodsFor: 'accessing untypeable characters' stamp: 'jmv 11/1/2016 22:32:46'!
arrowRight
	"
	Character arrowRight
	"
	^ $! !

!Character class methodsFor: 'accessing untypeable characters' stamp: 'jmv 11/1/2016 22:33:10'!
arrowUp
	"
	Character arrowUp
	"
	^ $! !

!Character class methodsFor: 'accessing untypeable characters' stamp: 'jmv 9/2/2016 11:16:40'!
backspace
	"Answer the Character representing a backspace."

	^self numericValue: 8! !

!Character class methodsFor: 'accessing untypeable characters' stamp: 'jmv 11/1/2016 21:52:42'!
cr
	"Answer the Character representing a carriage return."

	^ ($)! !

!Character class methodsFor: 'accessing untypeable characters' stamp: 'jmv 8/28/2013 10:26'!
crCharacter
	"Answer the Character representing a carriage return."
	"Deprecated. To be removed soon. Please use #cr"

	^self cr! !

!Character class methodsFor: 'accessing untypeable characters' stamp: 'jmv 9/2/2016 11:16:48'!
delete
	^ self numericValue: 127! !

!Character class methodsFor: 'accessing untypeable characters' stamp: 'jmv 9/2/2016 11:16:54'!
end
	^ self numericValue: 4! !

!Character class methodsFor: 'accessing untypeable characters' stamp: 'jmv 9/2/2016 11:16:56'!
enter
	"Answer the Character representing enter."

	^self numericValue: 3! !

!Character class methodsFor: 'accessing untypeable characters' stamp: 'jmv 9/2/2016 11:16:57'!
escape
	"Answer the ASCII ESC character"

	^self numericValue: 27! !

!Character class methodsFor: 'accessing untypeable characters' stamp: 'jmv 11/1/2016 22:33:59'!
euro
	"The Euro currency sign, that E with two dashes.
	Cuis uses ISO Latin 9 (ISO 8859-15) character encoding.
	Each character is 1 byte"

	^ $§! !

!Character class methodsFor: 'accessing untypeable characters' stamp: 'jmv 9/2/2016 11:17:29'!
home
	^ self numericValue: 1! !

!Character class methodsFor: 'accessing untypeable characters' stamp: 'jmv 9/2/2016 11:17:34'!
insert
	^ self numericValue: 5! !

!Character class methodsFor: 'accessing untypeable characters' stamp: 'jmv 11/1/2016 21:52:37'!
lf
	"Answer the Character representing a linefeed."

	^ ($
)! !

!Character class methodsFor: 'accessing untypeable characters' stamp: 'jmv 8/28/2013 10:25'!
lfCharacter
	"Answer the Character representing a linefeed."
	"Deprecated. To be removed soon. Please use #lf"

	^self lf! !

!Character class methodsFor: 'accessing untypeable characters' stamp: 'jmv 9/2/2016 11:02:08'!
nbsp
	"non-breakable space."

	^ Character numericValue: 202! !

!Character class methodsFor: 'accessing untypeable characters' stamp: 'jmv 8/28/2013 10:28'!
newLineCharacter
	"Answer the Character representing a newLine, that is, a linefeed.
	This should be the only method in the system that knows about this detail.
	Everybody else should eventually ask us."

	^self lf! !

!Character class methodsFor: 'accessing untypeable characters' stamp: 'jmv 9/2/2016 11:17:44'!
newPage
	"Answer the Character representing a form feed."

	^self numericValue: 12! !

!Character class methodsFor: 'accessing untypeable characters' stamp: 'jmv 9/2/2016 11:17:48'!
null
	"Answer the null Character."

	^self numericValue: 0! !

!Character class methodsFor: 'accessing untypeable characters' stamp: 'jmv 9/2/2016 11:17:55'!
pageDown
	^ self numericValue: 12! !

!Character class methodsFor: 'accessing untypeable characters' stamp: 'jmv 9/2/2016 11:17:56'!
pageUp
	^ self numericValue: 11! !

!Character class methodsFor: 'accessing untypeable characters' stamp: 'jmv 9/24/2017 20:34:05'!
shortUnderscore
	"Answer the Character representing very short (or invisible) underscore.
	Used to optionally mark subscript in code."

	^ Character numericValue: 127! !

!Character class methodsFor: 'accessing untypeable characters' stamp: 'jmv 11/1/2016 21:52:33'!
space
	"Answer the Character representing a space."

	^ ($ )! !

!Character class methodsFor: 'accessing untypeable characters' stamp: 'jmv 11/1/2016 21:52:28'!
tab
	"Answer the Character representing a tab."

	^ ($	)! !


!Character class methodsFor: 'constants'!
characterTable
	"Answer the class variable in which unique Characters are stored."

	^CharacterTable! !

!Character class methodsFor: 'constants' stamp: 'len 5/21/2020 08:26:58'!
namedCharactersTable
	"Table of named characters that we can enter in an editor using \name.
	Please keep the names short and try to follow the naming convention used in LaTeX."
	^ #((left $) (right $) (up $) (down $) (oplus $ê) (otimes $ë) (times $◊) (div $˜) #(circ $í) (dot $∑) (bullet $ì) (diamond $î) (star $ï) (alpha $à) (beta $â) (gamma $ä) (delta $ã) (epsilon $å) (lambda $ç) (mu $µ) (pi $é) (zeta $è) (Delta $ñ) (Gamma $ó) (Omega $ò) (N $Ç) (Z $É) (Q $Ñ) (R $Ö) (C $Ü) (P $á) (infty $Ä) (aleph $Å) (sqrt $ü) (partial $û) (degree $∞))! !

!Character class methodsFor: 'constants' stamp: 'jmv 10/8/2018 18:39:44'!
unaccentedTable
	UnaccentedTable ifNil: [ self initializeLookupTables ].
	^UnaccentedTable! !

!Character class methodsFor: 'constants' stamp: 'jmv 10/8/2018 18:37:36'!
unicodeCodePoints
	UnicodeCodePoints ifNil: [ self initializeUnicodeCodePoints ].
	^UnicodeCodePoints! !


!Character class methodsFor: 'converting' stamp: 'jmv 2/8/2013 08:32'!
evaluate: aBlock withUtf8BytesOfUnicodeCodePoint: aCodePoint
	"See senders for typical usage"

	| mask nBytes shift |
	aCodePoint < 128 ifTrue: [
		^aBlock value: aCodePoint ].
	nBytes _ aCodePoint highBit + 3 // 5.
	mask _ #(128 192 224 240 248 252 254 255) at: nBytes.
	shift _ nBytes - 1 * -6.
	aBlock value: (aCodePoint bitShift: shift) + mask.
	2 to: nBytes do: [ :i | 
		shift _ shift + 6.
		aBlock value: ((aCodePoint bitShift: shift) bitAnd: 63) + 128 ]! !

!Character class methodsFor: 'converting' stamp: 'jmv 3/31/2020 18:30:21'!
evaluateOnce: aBlock withUtf8BytesOfUnicodeCodePoint: aCodePoint
	"Similar to #evaluate:withUtf8BytesOfUnicodeCodePoint:, but aBlock is evaluated just once, and must have 4 parameters."

	| mask nBytes shift byte1 byte2 byte3 byte4 |
	aCodePoint < 128 ifTrue: [
		^aBlock value: aCodePoint value: nil value: nil value: nil ].
	nBytes _ aCodePoint highBit + 3 // 5.
	mask _ #(128 192 224 240 248 252 254 255) at: nBytes.
	shift _ nBytes - 1 * -6.
	byte1 _ (aCodePoint bitShift: shift) + mask.
	nBytes >= 2 ifTrue: [
		shift _ shift + 6.
		byte2 _  ((aCodePoint bitShift: shift) bitAnd: 63) + 128.
		nBytes >= 3 ifTrue: [
			shift _ shift + 6.
			byte3 _  ((aCodePoint bitShift: shift) bitAnd: 63) + 128.
			nBytes = 4 ifTrue: [
				shift _ shift + 6.
				byte4 _  ((aCodePoint bitShift: shift) bitAnd: 63) + 128.
				].
			].
		].
		^aBlock value: byte1 value: byte2 value: byte3 value: byte4.! !

!Character class methodsFor: 'converting' stamp: 'jmv 10/8/2018 18:37:44'!
iso8859s15CodeForUnicodeCodePoint: codePoint
	"
	Answer nil if the Unicode codePoint is not a valid ISO 8859-15 character
	
	self assert: (Character iso8859s15CodeForUnicodeCodePoint: 16r41) = $A iso8859s15Code.
	self assert: (Character iso8859s15CodeForUnicodeCodePoint: 16r20AC) = $§ iso8859s15Code.
	"
	| code |
	code _ (self unicodeCodePoints indexOf: codePoint) -1.
	code = -1 ifTrue: [ ^nil ].
	^code! !

!Character class methodsFor: 'converting' stamp: 'jmv 8/31/2011 22:06'!
latin1ToMacRoman: charCode
	"Convert the receiver from ISO 8895-1 Latin-1 to MacRoman encoding."
	
	charCode < 128 ifTrue: [^ charCode].
	^ #[
		173 176 226 196 227 201 160 224 246 228 178 220 206 179 182 183	"80-8F"
		184 212 213 210 211 165 208 209 247 170 185 221 207 186 189 217	"90-9F"
		202 193 162 163 219 180 195 164 172 169 187 199 194 197 168 248	"A0-AF"
		161 177 198 215 171 181 166 225 252 218 188 200 222 223 240 192 	"B0-BF"
		203 231 229 204 128 129 174 130 233 131 230 232 237 234 235 236 	"C0-CF"
		245 132 241 238 239 205 133 249 175 244 242 243 134 250 251 167	"D0-DF"
		136 135 137 139 138 140 190 141 143 142 144 145 147 146 148 149	"E0-EF"
		253 150 152 151 153 155 154 214 191 157 156 158 159 254 255 216	"F0-FF"
	] at: charCode - 127! !

!Character class methodsFor: 'converting' stamp: 'jmv 8/31/2011 22:07'!
macRomanToLatin1: charCode
	"Convert the receiver from MacRoman to  ISO 8895-1 Latin-1 encoding"
	
	charCode < 128 ifTrue: [^ charCode].
	^ #[
		196 197 199 201 209 214 220 225 224 226 228 227 229 231 233 232 
		234 235 237 236 238 239 241 243 242 244 246 245 250 249 251 252 
		134 176 162 163 167 149 182 223 174 169 153 180 168 128 198 216 
		129 177 138 141 165 181 142 143 144 154 157 170 186 158 230 248 
		191 161 172 166 131 173 178 171 187 133 160 192 195 213 140 156 
		150 151 147 148 145 146 247 179 255 159 185 164 139 155 188 189 
		135 183 130 132 137 194 202 193 203 200 205 206 207 204 211 212 
		190 210 218 219 217 208 136 152 175 215 221 222 184 240 253 254
	] at: charCode - 127! !

!Character class methodsFor: 'converting' stamp: 'jmv 3/22/2020 23:19:17'!
nextCodePointBytesFromUtf8: anUtf8Stream into: aBlock
	"anUtf8Stream can be over a ByteArray.
	See senders."

	| byte1 byte2 byte3 byte4 |
	byte1 _ anUtf8Stream next.
	byte1 < 128 ifTrue: [	"single byte"
		^ aBlock value: byte1 value: nil value: nil value: nil ].
	
	"At least 2 bytes"
	byte2 _ anUtf8Stream next.
	(byte2 bitAnd: 16rC0) = 16r80 ifFalse: [^nil]. "invalid UTF-8"
	(byte1 bitAnd: 16rE0) = 192 ifTrue: [ "two bytes"
		^ aBlock value: byte1 value: byte2 value: nil value: nil ].
	
	"At least 3 bytes"
	byte3 _ anUtf8Stream next.
	(byte3 bitAnd: 16rC0) = 16r80 ifFalse: [^nil]. "invalid UTF-8"
	(byte1 bitAnd: 16rF0) = 224 ifTrue: [ "three bytes"
		^ aBlock value: byte1 value: byte2 value: byte3 value: nil ].

	"4 bytes"
	byte4 _ anUtf8Stream next.
	(byte4 bitAnd: 16rC0) = 16r80 ifFalse: [^nil]. "invalid UTF-8"
	(byte1 bitAnd: 16rF8) = 240 ifTrue: [  "four bytes"
		^ aBlock value: byte1 value: byte2 value: byte3 value: byte4 ].

	^nil! !

!Character class methodsFor: 'converting' stamp: 'jmv 3/22/2020 23:33:20'!
nextUnicodeCodePointFromUtf8: anUtf8Stream
	"anUtf8Stream can be over a ByteArray
	Answer nil if conversion not possible, because of invalid UTF-8.
	Also answer nil for codePoint U+FEFF (BOM, unneededly added by Win clipboard)"

	^ self
		nextCodePointBytesFromUtf8: anUtf8Stream
		into: [ :byte1 :byte2 :byte3 :byte4 |
			byte4 notNil
				ifTrue: [ ((byte1 bitAnd: 16r7) bitShift: 18) + ((byte2 bitAnd: 63) bitShift: 12) + ((byte3 bitAnd: 63) bitShift: 6) + (byte4 bitAnd: 63) ]
				ifFalse: [
					byte3 notNil
						ifTrue: [ | codePoint |
							codePoint _  ((byte1 bitAnd: 15) bitShift: 12) + ((byte2 bitAnd: 63) bitShift: 6) + (byte3 bitAnd: 63).
							codePoint = 16rFEFF
								ifFalse: [ codePoint ]
								ifTrue: [ nil ]]
						ifFalse: [
							byte2 notNil
								ifTrue: [ ((byte1 bitAnd: 31) bitShift: 6) + (byte2 bitAnd: 63) ]
								ifFalse: [ byte1 ]]]]! !

!Character class methodsFor: 'converting' stamp: 'jmv 2/8/2013 08:33'!
unicodeCodePointOfUtf8Bytes: aByteArray

	^ Character nextUnicodeCodePointFromUtf8: aByteArray readStream! !

!Character class methodsFor: 'converting' stamp: 'jmv 2/8/2013 08:34'!
utf8BytesOfUnicodeCodePoint: aCodePoint

	^ ByteArray streamContents: [ :strm |
		Character
			evaluate: [ :byte |
				strm nextPut: byte ]
			withUtf8BytesOfUnicodeCodePoint: aCodePoint ]! !


!Character class methodsFor: 'fileIn/Out' stamp: 'HAW 4/12/2018 13:36:49'!
definition
	"Special class definition for Character, SmallInteger and SmallFloat64
	Required to have the same definition both for preSpur and Spur, and to be compatible with both."
	^
'Object immediateSubclass: #Character
	instanceVariableNames: ''value''
	classVariableNames: ''CharacterTable UnaccentedTable UnicodeCodePoints LowercaseMappingTable LowercaseTruthTable UppercaseMappingTable UppercaseTruthTable LetterTruthTable''
	poolDictionaries: ''''
	category: ''', self category, ''''
! !


!classDefinition: #CharacterSet category: #'Kernel-Text'!
Collection subclass: #CharacterSet
	instanceVariableNames: 'map'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Kernel-Text'!
!CharacterSet commentStamp: '<historical>' prior: 0!
A set of characters.  Lookups for inclusion are very fast.!


!CharacterSet methodsFor: 'collection ops' stamp: 'jmv 9/2/2016 11:06:42'!
add: aCharacter
	map at: aCharacter numericValue+1  put: 1.! !

!CharacterSet methodsFor: 'collection ops' stamp: 'jmv 10/29/2016 21:18:02'!
do: aBlock
	"evaluate aBlock with each character in the set"

	Character characterTable do: [ :c |
		(self includes: c) ifTrue: [ aBlock value: c ] ]
! !

!CharacterSet methodsFor: 'collection ops' stamp: 'jmv 6/12/2019 10:11:23'!
includes: aCharacter
	(aCharacter is: #Character) ifFalse: [ ^ false ].
	^(map at: aCharacter numericValue + 1) > 0! !

!CharacterSet methodsFor: 'collection ops' stamp: 'jmv 9/2/2016 11:06:50'!
remove: aCharacter
	map at: aCharacter numericValue + 1  put: 0! !


!CharacterSet methodsFor: 'conversion' stamp: 'ls 8/17/1998 20:39'!
complement
	"return a character set containing precisely the characters the receiver does not"
	| set |
	set _ CharacterSet allCharacters.
	self do: [ :c | set remove: c ].
	^set! !


!CharacterSet methodsFor: 'comparison' stamp: 'jmv 8/9/2016 09:35:34'!
= anObject
	self == anObject ifTrue: [ ^ true ].
	^self species == anObject species and: [
		self byteArrayMap = anObject byteArrayMap ]! !

!CharacterSet methodsFor: 'comparison' stamp: 'ls 8/17/1998 20:46'!
hash
	^self byteArrayMap hash! !


!CharacterSet methodsFor: 'private' stamp: 'ls 8/17/1998 20:35'!
byteArrayMap
	"return a ByteArray mapping each ascii value to a 1 if that ascii value is in the set, and a 0 if it isn't.  Intended for use by primitives only"
	^map! !

!CharacterSet methodsFor: 'private' stamp: 'ls 8/17/1998 20:30'!
initialize
	map _ ByteArray new: 256 withAll: 0.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CharacterSet class' category: #'Kernel-Text'!
CharacterSet class
	instanceVariableNames: ''!

!CharacterSet class methodsFor: 'instance creation' stamp: 'jmv 9/2/2016 11:02:28'!
allCharacters
	"return a set containing all characters"

	| set |
	set _ self new.
	0 to: 255 do: [ :ascii | set add: (Character numericValue: ascii) ].
	^set! !

!CharacterSet class methodsFor: 'instance creation' stamp: 'ls 1/3/1999 12:52'!
newFrom: aCollection
	| newCollection |
	newCollection _ self new.
	newCollection addAll: aCollection.
	^newCollection! !

!CharacterSet class methodsFor: 'instance creation' stamp: 'ls 8/18/1998 00:40'!
nonSeparators
	"return a set containing everything but the whitespace characters"

	^self separators complement! !

!CharacterSet class methodsFor: 'instance creation' stamp: 'jmv 12/2/2011 09:42'!
separators
	"return a set containing just the whitespace characters"

	| set |
	set _ self new.
	set addAll: Character separators.
	^set! !


!classDefinition: #String category: #'Kernel-Text'!
ArrayedCollection variableByteSubclass: #String
	instanceVariableNames: ''
	classVariableNames: 'CSLineEnders CSNonSeparators CSSeparators CaseInsensitiveOrder CaseSensitiveOrder LowercasingTable Tokenish UppercasingTable'
	poolDictionaries: ''
	category: 'Kernel-Text'!
!String commentStamp: '<historical>' prior: 0!
A String is an indexed collection of Characters. In Cuis, Characters are represented in the Latin-9 (ISO 8859-15) encoding. Each character takes 1 byte.

String support a vast array of useful methods, which can best be learned by browsing and trying out examples as you find them in the code.

Here are a few useful methods to look at...
	String match:
	String contractTo:

String also inherits many useful methods from its hierarchy, such as
	SequenceableCollection ,
	SequenceableCollection copyReplaceAll:with:

Cuis includes limited support for Unicode. A ByteArray can hold any Unicode string in utf-8. There is support for converting to and from instances of String. As String can not hold all Unicode code points, (just the ISO 8859-15 subset), others are converted to NCRs. See #fromUtf8:hex:trimLastNull: and #asUtf8: .!


!String methodsFor: 'accessing' stamp: 'jmv 9/2/2016 11:03:45'!
at: index 
	"Primitive. Answer the Character stored in the field of the receiver
	indexed by the argument. Fail if the index argument is not an Integer or
	is out of bounds. Essential. See Object documentation whatIsAPrimitive."

	<primitive: 63>
	^Character numericValue: (super at: index)! !

!String methodsFor: 'accessing' stamp: 'jmv 6/11/2019 12:14:25'!
at: index put: aCharacter 
	"Primitive. Store the Character in the field of the receiver indicated by
	the index. Fail if the index is not an Integer or is out of bounds, or if
	the argument is not a Character. Essential. See Object documentation
	whatIsAPrimitive."

	<primitive: 64>
	(aCharacter is: #Character)
		ifTrue: [	
			index isInteger
				ifTrue: [self errorSubscriptBounds: index]
				ifFalse: [self errorNonIntegerIndex]]
		ifFalse: [self error: 'Strings only store Characters']! !

!String methodsFor: 'accessing' stamp: 'jmv 9/5/2016 17:14:38'!
byteAt: index
	<primitive: 60>
	^(self at: index) numericValue! !

!String methodsFor: 'accessing' stamp: 'ar 12/27/1999 13:44'!
byteAt: index put: value
	<primitive: 61>
	self at: index put: value asCharacter.
	^value! !

!String methodsFor: 'accessing' stamp: 'tk 12/26/97 11:09'!
findAnySubStr: delimiters startingAt: start 
	"Answer the index of the character within the receiver, starting at start, that begins a substring matching one of the delimiters.  delimiters is an Array of Strings (Characters are permitted also).  If the receiver does not contain any of the delimiters, answer size + 1."

	| min ind |
	min _ self size + 1.
	delimiters do: [:delim |	"May be a char, a string of length 1, or a substring"
		delim class == Character 
			ifTrue: [ind _ self indexOfSubCollection: (String with: delim) 
						startingAt: start ifAbsent: [min]]
			ifFalse: [ind _ self indexOfSubCollection: delim 
						startingAt: start ifAbsent: [min]].
			min _ min min: ind].
	^ min! !

!String methodsFor: 'accessing' stamp: 'dew 11/15/2000 15:02'!
findBetweenSubStrs: delimiters
	"Answer the collection of String tokens that result from parsing self.  Tokens are separated by 'delimiters', which can be a collection of Strings, or a collection of Characters.  Several delimiters in a row are considered as just one separation."

	| tokens keyStart keyStop |
	tokens _ OrderedCollection new.
	keyStop _ 1.
	[keyStop <= self size] whileTrue:
		[keyStart _ self skipAnySubStr: delimiters startingAt: keyStop.
		keyStop _ self findAnySubStr: delimiters startingAt: keyStart.
		keyStart < keyStop
			ifTrue: [tokens add: (self copyFrom: keyStart to: (keyStop - 1))]].
	^tokens! !

!String methodsFor: 'accessing'!
findDelimiters: delimiters startingAt: start 
	"Answer the index of the character within the receiver, starting at start, that matches one of the delimiters. If the receiver does not contain any of the delimiters, answer size + 1."

	start to: self size do: [:i |
		delimiters do: [:delim | delim = (self at: i) ifTrue: [^ i]]].
	^ self size + 1! !

!String methodsFor: 'accessing' stamp: 'nice 10/5/2009 03:15'!
findLastOccurrenceOfString: subString startingAt: start 
	"Answer the index of the last occurrence of subString within the receiver, starting at start. If 
	the receiver does not contain subString, answer 0.  Case-sensitive match used."

	| last now |
	last := self findString: subString startingAt: start.
	last = 0 ifTrue: [^ 0].
	[last > 0] whileTrue:
		[now := last.
		last := self findString: subString startingAt: last + 1].

	^ now
! !

!String methodsFor: 'accessing' stamp: 'ar 4/11/1999 22:15'!
findString: subString
	"Answer the index of subString within the receiver, starting at start. If 
	the receiver does not contain subString, answer 0."
	^self findString: subString startingAt: 1.! !

!String methodsFor: 'accessing' stamp: 'di 11/15/1998 16:43'!
findString: subString startingAt: start 
	"Answer the index of subString within the receiver, starting at start. If 
	the receiver does not contain subString, answer 0."

	^ self findSubstring: subString in: self startingAt: start matchTable: CaseSensitiveOrder! !

!String methodsFor: 'accessing' stamp: 'di 11/15/1998 16:45'!
findString: key startingAt: start caseSensitive: caseSensitive
	"Answer the index in this String at which the substring key first occurs, at or beyond start.  The match can be case-sensitive or not.  If no match is found, zero will be returned."

	caseSensitive
	ifTrue: [^ self findSubstring: key in: self startingAt: start matchTable: CaseSensitiveOrder]
	ifFalse: [^ self findSubstring: key in: self startingAt: start matchTable: CaseInsensitiveOrder]! !

!String methodsFor: 'accessing' stamp: 'tk 8/10/2000 09:14'!
findTokens: delimiters
	"Answer the collection of tokens that result from parsing self.  Return strings between the delimiters.  Any character in the Collection delimiters marks a border.  Several delimiters in a row are considered as just one separation.  Also, allow delimiters to be a single character."

	| tokens keyStart keyStop separators |

	tokens _ OrderedCollection new.
	separators _ delimiters class == Character 
		ifTrue: [Array with: delimiters]
		ifFalse: [delimiters].
	keyStop _ 1.
	[keyStop <= self size] whileTrue:
		[keyStart _ self skipDelimiters: separators startingAt: keyStop.
		keyStop _ self findDelimiters: separators startingAt: keyStart.
		keyStart < keyStop
			ifTrue: [tokens add: (self copyFrom: keyStart to: (keyStop - 1))]].
	^tokens! !

!String methodsFor: 'accessing' stamp: 'tk 6/19/97 10:05'!
findTokens: delimiters keep: keepers
	"Answer the collection of tokens that result from parsing self.  The tokens are seperated by delimiters, any of a string of characters.  If a delimiter is also in keepers, make a token for it.  (Very useful for carriage return.  A sole return ends a line, but is also saved as a token so you can see where the line breaks were.)"

	| tokens keyStart keyStop |
	tokens _ OrderedCollection new.
	keyStop _ 1.
	[keyStop <= self size] whileTrue:
		[keyStart _ self skipDelimiters: delimiters startingAt: keyStop.
		keyStop to: keyStart-1 do: [:ii | 
			(keepers includes: (self at: ii)) ifTrue: [
				tokens add: (self copyFrom: ii to: ii)]].	"Make this keeper be a token"
		keyStop _ self findDelimiters: delimiters startingAt: keyStart.
		keyStart < keyStop
			ifTrue: [tokens add: (self copyFrom: keyStart to: (keyStop - 1))]].
	^tokens! !

!String methodsFor: 'accessing' stamp: 'sw 8/12/97 12:37'!
includesSubString: subString
	^ (self findString: subString startingAt: 1) > 0! !

!String methodsFor: 'accessing' stamp: 'di 11/15/1998 16:53'!
includesSubstring: aString caseSensitive: caseSensitive
	
	^ (self findString: aString startingAt: 1 caseSensitive: caseSensitive) > 0! !

!String methodsFor: 'accessing' stamp: 'jmv 9/5/2016 21:15:58'!
indexOf: aCharacter

	(aCharacter class == Character) ifFalse: [^ 0].
	^ String indexOfByte: aCharacter numericValue inString: self startingAt: 1! !

!String methodsFor: 'accessing' stamp: 'jmv 9/5/2016 21:16:01'!
indexOf: aCharacter  startingAt: start

	(aCharacter class == Character) ifFalse: [^ 0].
	^ String indexOfByte: aCharacter numericValue inString: self startingAt: start! !

!String methodsFor: 'accessing' stamp: 'jmv 9/5/2016 21:16:04'!
indexOf: aCharacter  startingAt: start  ifAbsent: aBlock
	| ans |
	(aCharacter class == Character) ifFalse: [ ^ aBlock value ].
	ans _ String indexOfByte: aCharacter numericValue inString: self  startingAt: start.
	^ans = 0
		ifTrue: [ aBlock value ]
		ifFalse: [ ans ]! !

!String methodsFor: 'accessing' stamp: 'jmv 4/2/2016 14:35'!
indexOfAnyOf: aCharacterSet
	"returns the index of the first character in the given set, starting from start"

	^String findFirstInString: self inSet: aCharacterSet byteArrayMap startingAt: 1! !

!String methodsFor: 'accessing' stamp: 'jmv 3/14/2012 08:14'!
indexOfAnyOf: aCharacterSet  startingAt: start ifAbsent: aBlock
	"returns the index of the first character in the given set, starting from start"

	| answer |
	answer _ String findFirstInString: self inSet: aCharacterSet byteArrayMap startingAt: start.

	^answer = 0 
		ifTrue: [ aBlock value ]
		ifFalse: [ answer]! !

!String methodsFor: 'accessing' stamp: 'di 11/15/1998 17:02'!
indexOfSubCollection: sub startingAt: start ifAbsent: exceptionBlock
	| index |
	index _ self findSubstring: sub in: self startingAt: start matchTable: CaseSensitiveOrder.
	index = 0 ifTrue: [^ exceptionBlock value].
	^ index! !

!String methodsFor: 'accessing' stamp: 'jmv 3/13/2012 22:06'!
lineCount
	"Answer the number of lines represented by the receiver, where every cr adds one line.  5/10/96 sw"


	| i |
	i _ 0.
	self lineIndicesDo: [ :start :endWithoutDelimiters :end |
		i _ i + 1 ].
	^i

"
'Fred
the
Bear' lineCount
"! !

!String methodsFor: 'accessing' stamp: 'jmv 8/28/2013 10:27'!
lineIndicesDo: aBlock
	"execute aBlock with 3 arguments for each line:
	- start index of line
	- end index of line without line delimiter
	- end index of line including line delimiter(s) CR, LF or CRLF"
	
	| start end endWithoutDelimiters |
	start _ 1.
	[
		end _ self indexOfAnyOf: CSLineEnders startingAt: start ifAbsent: [ 0 ].
		end = 0
			ifTrue: [
				"Last line was found. Evaluate and exit.
				Note. If last char in receiver is a line separator, there's an extra empty line"
				endWithoutDelimiters _ end _ self size.
				aBlock value: start value: endWithoutDelimiters value: end.
				^self ].

		"Account for CrLf sequence"
		endWithoutDelimiters _ end - 1.
		(end < self size
			and: [(self at: end + 1) = Character lf
			and: [(self at: end) = Character cr ]])
				ifTrue: [ end _ end + 1].

		aBlock value: start value: endWithoutDelimiters value: end.
		start _ end + 1 ] repeat! !

!String methodsFor: 'accessing' stamp: 'jmv 3/13/2012 22:05'!
lineNumber: anIndex
	"Answer a string containing the characters in the given line number. "
	| i |
	i _ 1.
	self lineIndicesDo: [ :start :endWithoutDelimiters :end |
		i = anIndex ifTrue: [
			^ self copyFrom: start to: endWithoutDelimiters ].
		i _ i + 1 ].
	^nil
	
"
'Fred
the
Bear' lineNumber: 3
".! !

!String methodsFor: 'accessing' stamp: 'jmv 3/13/2012 22:08'!
lines
	"Answer an array of lines composing this receiver without the line ending delimiters."

	^Array
		streamContents: [ :lines | self linesDo: [ :aLine | lines nextPut: aLine ]]
		estimatedSize: (self size // 60 max: 16)! !

!String methodsFor: 'accessing' stamp: 'jmv 3/13/2012 22:08'!
linesDo: aBlock
	"execute aBlock with each line in this string.  The terminating CR's are not included in what is passed to aBlock"
	
	self lineIndicesDo: [ :start :endWithoutDelimiters :end |
		aBlock value: (self copyFrom: start  to: endWithoutDelimiters) ]
		! !

!String methodsFor: 'accessing' stamp: 'BJP 6/12/2000 18:53'!
skipAnySubStr: delimiters startingAt: start 
	"Answer the index of the last character within the receiver, starting at start, that does NOT match one of the delimiters. delimiters is a Array of substrings (Characters also allowed).  If the receiver is all delimiters, answer size + 1."
	| any this ind ii |
	ii _ start-1.
	[(ii _ ii + 1) <= self size] whileTrue: [ "look for char that does not match"
		any _ false.
		delimiters do: [:delim |
			delim class == Character 
				ifTrue: [(self at: ii) == delim ifTrue: [any _ true]]
				ifFalse: ["a substring"
					delim size > (self size - ii + 1) ifFalse: "Here's where the one-off error was."
						[ind _ 0.
						this _ true.
						delim do: [:dd | 
							dd == (self at: ii+ind) ifFalse: [this _ false].
							ind _ ind + 1].
						this ifTrue: [ii _ ii + delim size - 1.  any _ true]]
							ifTrue: [any _ false] "if the delim is too big, it can't match"]].
		any ifFalse: [^ ii]].
	^ self size + 1! !

!String methodsFor: 'accessing'!
skipDelimiters: delimiters startingAt: start 
	"Answer the index of the character within the receiver, starting at start, that does NOT match one of the delimiters. If the receiver does not contain any of the delimiters, answer size + 1.  Assumes the delimiters to be a non-empty string."

	start to: self size do: [:i |
		delimiters detect: [:delim | delim = (self at: i)]
				ifNone: [^ i]].
	^ self size + 1! !

!String methodsFor: 'accessing' stamp: 'jmv 3/20/2013 23:10'!
string
	"Compatibility with Text"
	^self! !


!String methodsFor: 'comparing' stamp: 'jmv 10/6/2010 18:06'!
< aString 
	"Answer whether the receiver sorts before aString.
	The collation order is case sensitive."

	^ (self compare: self with: aString collated: CaseSensitiveOrder) = 1! !

!String methodsFor: 'comparing' stamp: 'jmv 10/6/2010 18:07'!
<= aString 
	"Answer whether the receiver sorts before or equal to aString.
	The collation order is case sensitive."

	^ (self compare: self with: aString collated: CaseSensitiveOrder) <= 2! !

!String methodsFor: 'comparing' stamp: 'jmv 6/11/2019 16:23:20'!
= aString 
	"Answer whether the receiver sorts equally as aString.
	This means same characters in same order."

	"Any object is equal to itself"
	self == aString ifTrue: [ ^ true ].

	"If argument is not a String or Symbol, maybe it is a Text?"
	aString species == String ifFalse: [
		(aString is: #Text) ifTrue: [ ^ self = aString string ].
		^ false].

	self size = aString size ifFalse: [
		^false ].
	
	self size > 256 ifTrue: [
		self hashQuick = aString hashQuick ifFalse: [ ^false ]].

	^ (self compare: self with: aString collated: CaseSensitiveOrder) = 2! !

!String methodsFor: 'comparing' stamp: 'jmv 10/6/2010 18:07'!
> aString 
	"Answer whether the receiver sorts after aString.
	The collation order is case sensitive."

	^ (self compare: self with: aString collated: CaseSensitiveOrder) = 3! !

!String methodsFor: 'comparing' stamp: 'jmv 10/6/2010 18:07'!
>= aString 
	"Answer whether the receiver sorts after or equal to aString.
	The collation order is case sensitive."

	^ (self compare: self with: aString collated: CaseSensitiveOrder) >= 2! !

!String methodsFor: 'comparing' stamp: 'jmv 9/5/2016 17:13:56'!
alike: aString 
	"Answer some indication of how alike the receiver is to the argument,  0 is no match, twice aString size is best score.  Case is ignored."

	| i j k minSize bonus |
	minSize _ (j _ self size) min: (k _ aString size).
	bonus _ (j - k) abs < 2 ifTrue: [ 1 ] ifFalse: [ 0 ].
	i _ 1.
	[(i <= minSize) and: [((super at: i) bitAnd: 16rDF)  = ((aString at: i) numericValue bitAnd: 16rDF)]]
		whileTrue: [ i _ i + 1 ].
	[(j > 0) and: [(k > 0) and:
		[((super at: j) bitAnd: 16rDF) = ((aString at: k) numericValue bitAnd: 16rDF)]]]
			whileTrue: [ j _ j - 1.  k _ k - 1. ].
	^ i - 1 + self size - j + bonus. ! !

!String methodsFor: 'comparing' stamp: 'jmv 2/22/2013 07:41'!
beginsWith: prefix
	"Answer whether the receiver begins with the given prefix string.
	The comparison is case-sensitive."

	^self is: prefix substringAt: 1! !

!String methodsFor: 'comparing' stamp: 'sw 4/19/1999 12:11'!
caseInsensitiveLessOrEqual: aString 
	"Answer whether the receiver sorts before or equal to aString.
	The collation order is case insensitive."

	^ (self compare: self with: aString collated: CaseInsensitiveOrder) <= 2! !

!String methodsFor: 'comparing' stamp: 'di 9/20/1998 14:33'!
caseSensitiveLessOrEqual: aString 
	"Answer whether the receiver sorts before or equal to aString.
	The collation order is case sensitive."

	^ (self compare: self with: aString collated: CaseSensitiveOrder) <= 2! !

!String methodsFor: 'comparing' stamp: 'jmv 6/23/2011 09:53'!
commonPartWith: aString startAt: startIndex stopAt: stopIndexRequested applying: aBlock
	"Return the size of the longest common subsequence with aString, only between startIndex and stopIndex.
	Apply aBlock to each character before comparing.
	Do a character-by-character comparison between the receiver and aString.  Return the index of the final character that matched exactly."
	| stopIndex |
	stopIndex _ stopIndexRequested min: aString size.
	startIndex
		to: stopIndex
		do: [ :i |
			(aBlock value: (self at: i)) = (aBlock value: (aString at: i)) ifFalse: [ ^ i - 1 ]].
	^ stopIndex! !

!String methodsFor: 'comparing' stamp: 'jmv 6/23/2011 09:54'!
commonPrefixWith: aString
	"Return the size of the longest common prefix with aString.
	Do a character-by-character comparison between the receiver and aString.  Return the index of the final character that matched exactly.
	'this is a string' commonPrefixWith: 'this is another'
	'this is a string' commonPrefixWith: ''
	'' commonPrefixWith: 'this is another'
	't' commonPrefixWith: 'this is another'
	'txxxxxxxxx' commonPrefixWith: 'this is another'
		"
	^ self commonPartWith: aString startAt: 1 stopAt: self size applying: [ :c | c ]! !

!String methodsFor: 'comparing' stamp: 'di 2/27/98 12:41'!
compare: aString 
	"Answer a comparison code telling how the receiver sorts relative to aString:
		1 - before
		2 - equal
		3 - after.
	The collation sequence is ascii with case differences ignored.
	To get the effect of a <= b, but ignoring case, use (a compare: b) <= 2."

	^ self compare: self with: aString collated: CaseInsensitiveOrder! !

!String methodsFor: 'comparing' stamp: 'ar 4/10/2005 16:42'!
compare: aString caseSensitive: aBool
	"Answer a comparison code telling how the receiver sorts relative to aString:
		1 - before
		2 - equal
		3 - after.
	"
	| map |
	map := aBool ifTrue:[CaseSensitiveOrder] ifFalse:[CaseInsensitiveOrder].
	^self compare: self with: aString collated: map! !

!String methodsFor: 'comparing' stamp: 'jmv 9/5/2016 21:14:24'!
crc16
	"Compute a 16 bit cyclic redundancy check."

	| crc |
	crc := 0.
	self do: [:c |
		crc := (crc bitShift: -8) bitXor: (
		 #(	16r0000	16rC0C1	16rC181	16r0140	16rC301	16r03C0	16r0280	16rC241
			16rC601	16r06C0	16r0780	16rC741	16r0500	16rC5C1	16rC481	16r0440
			16rCC01	16r0CC0	16r0D80	16rCD41	16r0F00	16rCFC1	16rCE81	16r0E40
			16r0A00	16rCAC1	16rCB81	16r0B40	16rC901	16r09C0	16r0880	16rC841
			16rD801	16r18C0	16r1980	16rD941	16r1B00	16rDBC1	16rDA81	16r1A40
			16r1E00	16rDEC1	16rDF81	16r1F40	16rDD01	16r1DC0	16r1C80	16rDC41
			16r1400	16rD4C1	16rD581	16r1540	16rD701	16r17C0	16r1680	16rD641
			16rD201	16r12C0	16r1380	16rD341	16r1100	16rD1C1	16rD081	16r1040
			16rF001	16r30C0	16r3180	16rF141	16r3300	16rF3C1	16rF281	16r3240
			16r3600	16rF6C1	16rF781	16r3740	16rF501	16r35C0	16r3480	16rF441
			16r3C00	16rFCC1	16rFD81	16r3D40	16rFF01	16r3FC0	16r3E80	16rFE41
			16rFA01	16r3AC0	16r3B80	16rFB41	16r3900	16rF9C1	16rF881	16r3840
			16r2800	16rE8C1	16rE981	16r2940	16rEB01	16r2BC0	16r2A80	16rEA41
			16rEE01	16r2EC0	16r2F80	16rEF41	16r2D00	16rEDC1	16rEC81	16r2C40
			16rE401	16r24C0	16r2580	16rE541	16r2700	16rE7C1	16rE681	16r2640
			16r2200	16rE2C1	16rE381	16r2340	16rE101	16r21C0	16r2080	16rE041
			16rA001	16r60C0	16r6180	16rA141	16r6300	16rA3C1	16rA281	16r6240
			16r6600	16rA6C1	16rA781	16r6740	16rA501	16r65C0	16r6480	16rA441
			16r6C00	16rACC1	16rAD81	16r6D40	16rAF01	16r6FC0	16r6E80	16rAE41
			16rAA01	16r6AC0	16r6B80	16rAB41	16r6900	16rA9C1	16rA881	16r6840
			16r7800	16rB8C1	16rB981	16r7940	16rBB01	16r7BC0	16r7A80	16rBA41
			16rBE01	16r7EC0	16r7F80	16rBF41	16r7D00	16rBDC1	16rBC81	16r7C40
			16rB401	16r74C0	16r7580	16rB541	16r7700	16rB7C1	16rB681	16r7640
			16r7200	16rB2C1	16rB381	16r7340	16rB101	16r71C0	16r7080	16rB041
			16r5000	16r90C1	16r9181	16r5140	16r9301	16r53C0	16r5280	16r9241
			16r9601	16r56C0	16r5780	16r9741	16r5500	16r95C1	16r9481	16r5440
			16r9C01	16r5CC0	16r5D80	16r9D41	16r5F00	16r9FC1	16r9E81	16r5E40
			16r5A00	16r9AC1	16r9B81	16r5B40	16r9901	16r59C0	16r5880	16r9841
			16r8801	16r48C0	16r4980	16r8941	16r4B00	16r8BC1	16r8A81	16r4A40
			16r4E00	16r8EC1	16r8F81	16r4F40	16r8D01	16r4DC0	16r4C80	16r8C41
			16r4400	16r84C1	16r8581	16r4540	16r8701	16r47C0	16r4680	16r8641
			16r8201	16r42C0	16r4380	16r8341	16r4100	16r81C1	16r8081	16r4040)
			 at: ((crc bitXor: c numericValue) bitAnd: 16rFF) + 1) ].
	^crc! !

!String methodsFor: 'comparing' stamp: 'jmv 2/22/2013 07:41'!
endsWith: suffix
	"Answer whether the tail end of the receiver is the same as suffix.
	The comparison is case-sensitive."

	^self is: suffix substringAt: self size - suffix size + 1
"
  'Elvis' endsWith: 'vis'
"! !

!String methodsFor: 'comparing' stamp: 'jmv 6/11/2019 16:13:53'!
hash
	"#hash is implemented, because #= is implemented"
	self size > 256 ifTrue: [ ^ self hashQuick ].
	^ByteArray
		hashBytes: self
		startingWith: self species hash! !

!String methodsFor: 'comparing' stamp: 'len 11/15/2015 04:23'!
is: aString substringAt: index
	"Answer whether the receiver includes aString as a subcollection at position index.
	The comparison is case-sensitive."
	| sequenceSize |
	index < 1 ifTrue: [ ^false ].
	sequenceSize _ aString size.
	sequenceSize = 0 ifTrue: [ ^true].
	self size - index + 1 < sequenceSize ifTrue: [ ^false ].
	"The following method uses a suboptimal algorithm (brute force pattern matching with O(n^2) worst case runtime), but the primitive in C is so fast (assuming large alphabets), that it's still worth using it instead of linear time pure smalltalk implementation. There are some obvious cases when the brute force algorithm is suboptimal, e.g. when the first elements don't match, so let's compare them here before using the primitive."
	(self basicAt: index) = (aString basicAt: 1) ifFalse: [ ^false ].
	^(self findSubstring: aString in: self startingAt: index matchTable: CaseSensitiveOrder) = index! !

!String methodsFor: 'comparing' stamp: 'di 11/19/1998 13:37'!
match: text
	"Answer whether text matches the pattern in this string.
	Matching ignores upper/lower case differences.
	Where this string contains #, text may contain any character.
	Where this string contains *, text may contain any sequence of characters."

	^ self startingAt: 1 match: text startingAt: 1
"
	'*'			match: 'zort' true
	'*baz'		match: 'mobaz' true
	'*baz'		match: 'mobazo' false
	'*baz*'		match: 'mobazo' true
	'*baz*'		match: 'mozo' false
	'foo*'		match: 'foozo' true
	'foo*'		match: 'bozo' false
	'foo*baz'	match: 'foo23baz' true
	'foo*baz'	match: 'foobaz' true
	'foo*baz'	match: 'foo23bazo' false
	'foo'		match: 'Foo' true
	'foo*baz*zort' match: 'foobazort' false
	'foo*baz*zort' match: 'foobazzort' false
	'*foo#zort'	match: 'afoo3zortthenfoo3zort' true
	'*foo*zort'	match: 'afoodezortorfoo3zort' true
"! !

!String methodsFor: 'comparing' stamp: 'di 2/27/98 12:19'!
sameAs: aString 
	"Answer whether the receiver sorts equal to aString. The 
	collation sequence is ascii with case differences ignored."

	^ (self compare: self with: aString collated: CaseInsensitiveOrder) = 2! !

!String methodsFor: 'comparing' stamp: 'ul 11/14/2010 06:02'!
startingAt: keyStart match: text startingAt: textStart
	"Answer whether text matches the pattern in this string.
	Matching ignores upper/lower case differences.
	Where this string contains #, text may contain any character.
	Where this string contains *, text may contain any sequence of characters."
	| anyMatch matchStart matchEnd i matchStr j ii jj |
	i := keyStart.
	j := textStart.

	"Check for any #'s"
	[i > self size ifTrue: [^ j > text size "Empty key matches only empty string"].
	(self at: i) = $#] whileTrue:
		["# consumes one char of key and one char of text"
		j > text size ifTrue: [^ false "no more text"].
		i := i+1.  j := j+1].

	"Then check for *"
	(self at: i) = $*
		ifTrue: [i = self size ifTrue:
					[^ true "Terminal * matches all"].
				"* means next match string can occur anywhere"
				anyMatch := true.
				matchStart := i + 1]
		ifFalse: ["Otherwise match string must occur immediately"
				anyMatch := false.
				matchStart := i].

	"Now determine the match string"
	matchEnd := self size.
	(ii := self indexOf: $* startingAt: matchStart) > 0 ifTrue:
		[ii = matchStart ifTrue: [self error: '** not valid -- use * instead'].
		matchEnd := ii-1].
	(ii := self indexOf: $# startingAt: matchStart) > 0 ifTrue:
		[ii = matchStart ifTrue: [self error: '*# not valid -- use #* instead'].
		matchEnd := matchEnd min: ii-1].
	matchStr := self copyFrom: matchStart to: matchEnd.

	"Now look for the match string"
	[jj := text findString: matchStr startingAt: j caseSensitive: false.
	anyMatch ifTrue: [jj > 0] ifFalse: [jj = j]]
		whileTrue:
		["Found matchStr at jj.  See if the rest matches..."
		(self startingAt: matchEnd+1 match: text startingAt: jj + matchStr size) ifTrue:
			[^ true "the rest matches -- success"].
		"The rest did not match."
		anyMatch ifFalse: [^ false].
		"Preceded by * -- try for a later match"
		j := j+1].
	^ false "Failed to find the match string"! !


!String methodsFor: 'copying' stamp: 'KenD 9/4/2016 16:50:54'!
, aStringOrText
	^ aStringOrText appendToString: self! !

!String methodsFor: 'copying' stamp: 'KenD 9/4/2016 15:49:17'!
append: aStringOrText

	^ aStringOrText appendToString: self! !

!String methodsFor: 'copying' stamp: 'KenD 9/4/2016 16:21:53'!
appendToString: aString

	| stringSize |
	stringSize := aString size.
	^ aString copyReplaceFrom: stringSize + 1
		 	    to: stringSize
		   	    with: self! !

!String methodsFor: 'copying' stamp: 'KenD 9/4/2016 18:22:51'!
appendToText: aText

	| textStringSize |
	textStringSize := aText string size.
	^ aText replaceFrom: textStringSize + 1
			 to: textStringSize 
			 with: self asText! !

!String methodsFor: 'copying'!
copyReplaceTokens: oldSubstring with: newSubstring 
	"Replace all occurrences of oldSubstring that are surrounded
	by non-alphanumeric characters"
	^ self copyReplaceAll: oldSubstring with: newSubstring asTokens: true
	"'File asFile Files File''s File' copyReplaceTokens: 'File' with: 'Snick'"! !

!String methodsFor: 'copying' stamp: 'HAW 3/4/2019 15:30:11'!
copyReplacing: rangesToNewStrings

	^self class streamContents: [ :replacementStream | self copyReplacing: rangesToNewStrings into: replacementStream ].! !

!String methodsFor: 'copying' stamp: 'HAW 3/4/2019 15:30:14'!
copyReplacing: rangesToNewStrings into: replacementStream

	| lastFrom |

	lastFrom := rangesToNewStrings inject: 1 into: [ :from :aRangeToNewString |
		self
			newFromAfterAppending: aRangeToNewString value
			into: replacementStream
			keepingFrom: from
			skipping: aRangeToNewString key ].

	replacementStream nextPutAll: (self copyFrom: lastFrom to: self size).
! !

!String methodsFor: 'copying' stamp: 'HAW 3/4/2019 15:30:18'!
copyReplacing: ranges with: newString

	"Ranges must be in order, with first ranges first. If not, result is unexpected - Hernan"

	^ self class streamContents: [ :replacementStream | self copyReplacing: ranges with: newString into: replacementStream ]
		! !

!String methodsFor: 'copying' stamp: 'HAW 3/4/2019 15:30:22'!
copyReplacing: ranges with: newString into: replacementStream

	| lastFrom |

	lastFrom := ranges
		inject: 1
		into: [ :from :aRange |
			self newFromAfterAppending: newString into: replacementStream keepingFrom: from skipping: aRange ].

	replacementStream nextPutAll: (self copyFrom: lastFrom to: self size).! !

!String methodsFor: 'copying' stamp: 'HAW 5/18/2019 17:10:29'!
flattenTo: flattenedStream

	flattenedStream nextPut: self! !

!String methodsFor: 'copying' stamp: 'hjh 5/9/2015 16:32'!
join: aCollection 
	"'*' join: #('WWWWW' 'W  EW' 'zzzz')
		->  'WWWWW*W  EW*zzzz' "

	| w |		
	w := WriteStream on: String new.
	aCollection do: [ :elem | w nextPutAll: elem asString] separatedBy: [w nextPutAll: self].
	^String fromString: w contents! !

!String methodsFor: 'copying' stamp: 'HAW 3/4/2019 15:30:28'!
newFromAfterAppending: aNewString into: replacementStream keepingFrom: from skipping: aRange

	replacementStream
		nextPutAll: (self copyFrom: from to: aRange first - 1);
		nextPutAll: aNewString.

	^ aRange last + 1! !

!String methodsFor: 'copying' stamp: 'di 2/15/98 22:54'!
padded: leftOrRight to: length with: char
	leftOrRight = #left ifTrue:
		[^ (String new: (length - self size max: 0) withAll: char) , self].
	leftOrRight = #right ifTrue:
		[^ self , (String new: (length - self size max: 0) withAll: char)].! !


!String methodsFor: 'converting' stamp: 'di 11/6/1998 13:47'!
adaptToCollection: rcvr andSend: selector
	"If I am involved in arithmetic with a collection, convert me to a number."

	^ rcvr perform: selector with: self asNumber! !

!String methodsFor: 'converting' stamp: 'jmv 5/28/2015 10:03'!
adaptToNumber: rcvr andSend: selector
	"If I am involved in arithmetic with a number, convert me to a number."

"	^ rcvr perform: selector with: self asNumber"
	self shouldNotImplement.! !

!String methodsFor: 'converting' stamp: 'jmv 5/28/2015 10:03'!
adaptToPoint: rcvr andSend: selector
	"If I am involved in arithmetic with a point, convert me to a number."

"	^ rcvr perform: selector with: self asNumber"
	self shouldNotImplement.! !

!String methodsFor: 'converting' stamp: 'HAW 8/3/2018 10:57:30'!
afterBlanksEndsWith: aTail

	^(self endsWith: aTail) and: [ self firstNoBlankIndex = (self size - aTail size + 1) ]
! !

!String methodsFor: 'converting' stamp: 'jmv 11/30/2010 19:39'!
asCamelCase
	"Answer a new String, without any whitespace, and with words capitalized (Except for the first one)
	' how do you do? ' asCamelCase
	"
	^ String streamContents: [ :outStream | | inStream capitalize wroteSome |
		wroteSome _ false.
		capitalize _ false.
		inStream _ self readStream.
		[ inStream atEnd ] whileFalse: [ | c |
			c _ inStream next.
			c isSeparator
				ifTrue: [ capitalize _ true ]
				ifFalse: [
					capitalize & wroteSome ifTrue: [ c _ c asUppercase ].
					outStream nextPut: c.
					wroteSome _ true.
					capitalize _ false ]]]! !

!String methodsFor: 'converting' stamp: 'jmv 5/12/2017 11:22:17'!
asDate
	"Many allowed forms, see Date>>#readFrom:
		'2014/6/30' asDate.
		'70/12/30' asDate.
		'12/30/70' asDate.
		'30/12/70' asDate.
		'4/5/6' asDate.
		'15 April 1982' asDate.
	"

	^ Date fromString: self! !

!String methodsFor: 'converting' stamp: 'pb 5/25/2016 01:21'!
asFileName
	"Answer a String made up from the receiver that is an acceptable file 
	name."

	^FileIOAccessor default checkName: self fixErrors: true! !

!String methodsFor: 'converting' stamp: 'nk 2/21/2001 20:06'!
asHex
	| stream |
	stream _ WriteStream on: (String new: self size * 2).
	self do: [ :ch | stream nextPutAll: ch hex ].
	^stream contents! !

!String methodsFor: 'converting' stamp: 'jmv 3/6/2018 17:19:56'!
asIdentifier: shouldBeCapitalized
	"Return a legal identifier, with first character in upper case if shouldBeCapitalized is true, else lower case.  This will always return a legal identifier, even for an empty string"

	| aString |
	aString _ self select: [ :el | el isValidInIdentifiers ].
	(aString size = 0 or: [aString first isValidStartOfIdentifiers not])
		ifTrue:	 [aString _ 'a', aString].
	^ shouldBeCapitalized ifTrue: [ aString capitalized ] ifFalse: [ aString uncapitalized ]

"
'234Fred987' asIdentifier: false
'235Fred987' asIdentifier: true
'' asIdentifier: true
'()87234' asIdentifier: false
'())z>=PPve889  U >' asIdentifier: false
"! !

!String methodsFor: 'converting' stamp: 'jmv 6/2/2011 08:52'!
asInteger 
	"Answer the Integer created by interpreting the receiver as the string representation of an integer.  Answer nil if no digits, else find the first digit and then all consecutive digits after that"

	| startPosition tail endPosition |
	startPosition _ self findFirst: [:ch | ch isDigit].
	startPosition = 0 ifTrue: [^ nil].
	tail _ self copyFrom: startPosition to: self size.
	endPosition _ tail findFirst: [:ch | ch isDigit not].
	endPosition = 0 ifTrue: [endPosition _ tail size + 1].
	^ Number readFrom: (tail copyFrom: 1 to: endPosition - 1) readStream

"
'1796exportFixes-tkMX' asInteger
'1848recentLogFile-sw'  asInteger
'donald' asInteger
'abc234def567' asInteger
"! !

!String methodsFor: 'converting' stamp: 'sma 6/12/2000 11:40'!
asLowercase
	"Answer a String made up from the receiver whose characters are all 
	lowercase."

	^ self copy asString translateToLowercase! !

!String methodsFor: 'converting' stamp: 'jmv 5/12/2017 11:24:09'!
asMonth
	"Many allowed forms, see Month>>#readFrom:
		'July 1998' asMonth.
		'1998/7'asMonth.
	"

	^ Month fromString: self! !

!String methodsFor: 'converting' stamp: 'jmv 6/2/2011 08:51'!
asNumber 
	"Answer the Number created by interpreting the receiver as the string 
	representation of a number."
	^Number readFrom: self readStream! !

!String methodsFor: 'converting' stamp: 'ls 10/28/2003 12:24'!
asSmalltalkComment
	"return this string, munged so that it can be treated as a comment in Smalltalk code.  Quote marks are added to the beginning and end of the string, and whenever a solitary quote mark appears within the string, it is doubled"

	^String streamContents:  [ :str |
		| quoteCount first |

		str nextPut: $".
	
		quoteCount := 0.
		first := true.
		self do: [ :char |
			char = $"
				ifTrue: [
					first ifFalse: [
						str nextPut: char.
						quoteCount := quoteCount + 1 ] ]
				ifFalse: [
					quoteCount odd ifTrue: [
						"add a quote to even the number of quotes in a row"
						str nextPut: $" ].
					quoteCount := 0.
					str nextPut: char ].
			first := false ]. 

		quoteCount odd ifTrue: [
			"check at the end"
			str nextPut: $". ].

		str nextPut: $".
	].
	! !

!String methodsFor: 'converting' stamp: 'jm 5/14/1998 10:40'!
asString
	"Answer this string."

	^ self
! !

!String methodsFor: 'converting'!
asSymbol
	"Answer the unique Symbol whose characters are the characters of the 
	string."

	^Symbol intern: self! !

!String methodsFor: 'converting'!
asText
	"Answer a Text whose string is the receiver."

	^Text fromString: self! !

!String methodsFor: 'converting' stamp: 'jmv 9/2/2016 11:03:36'!
asUnHtml
	"Strip out all Html stuff (commands in angle brackets <>) and convert
the characters &<> back to their real value.  Leave actual cr and tab as
they were in text."
	| in out char rest did inString |

	"Hack in some minimal workaround for Unicode stuff"
	inString _ self copyReplaceAll: '‚Äô' with: $' asString.
	"Check if we can handle this in #safeValue: in some way..."
	inString = self ifFalse: [ self halt ].
	
	in _ ReadStream on: inString.
	out _ WriteStream on: (String new: self size).
	[ in atEnd ] whileFalse: [
		in peek = $<
			ifTrue: [in unCommand] 	"Absorb <...><...>"
			ifFalse: [(char _ in next) = $&
						ifTrue: [rest _ in upTo: $;.
								did _ out position.
								rest = 'lt' ifTrue: [out nextPut: $<].
								rest = 'gt' ifTrue: [out nextPut: $>].
								rest = 'amp' ifTrue: [out nextPut: $&].
								rest = 'deg' ifTrue: [out nextPut: $°].
								rest = 'quot' ifTrue: [out nextPut: $"].
								rest first = $# ifTrue: [ out nextPut: (Character numericValue: rest asInteger) ].
								did = out position ifTrue: [
									out nextPut: $&; nextPutAll: rest.
									"self error: 'unknown encoded HTML char'."
									"Please add it to this method"]]
						ifFalse: [out nextPut: char]].
		].
	^ out contents! !

!String methodsFor: 'converting' stamp: 'jmv 4/10/2015 22:42'!
asUnaccented
	"
	'Hello' asUnaccented
	'·ÈÓÙÛ¸' asUnaccented
	"
	^(self anySatisfy: [ :c | c isAccented])
		ifFalse: [ self ]
		ifTrue: [ self collect: [ :c | c asUnaccented ]]! !

!String methodsFor: 'converting' stamp: 'SqR 6/13/2000 20:10'!
asUppercase
	"Answer a String made up from the receiver whose characters are all 
	uppercase."

	^self copy asString translateToUppercase! !

!String methodsFor: 'converting' stamp: 'jmv 2/8/2013 08:40'!
asUtf8
	"Convert the given string to UTF-8 from the internal encoding: ISO Latin 9 (ISO 8859-15)
	Answer a ByteArray.
	
	See #fromUtf8: "

	^self asUtf8: false! !

!String methodsFor: 'converting' stamp: 'jmv 9/4/2016 13:12:15'!
asUtf8: convertEmbeddedNCRs
	"Convert the given string to UTF-8 from the internal encoding: ISO Latin 9 (ISO 8859-15)
	Answer a ByteArray.
	
	If convertEmbeddedNCRs, then convert embedded NCRs such as '&#956;' (decimal) or '&#x03BC;' (hex) to CodePoints.
	See http://en.wikipedia.org/wiki/Numeric_character_reference
	
	
	Note: The conversion of NCRs is reversible. See #fromUtf8:hex:trimLastNull:
	This allows handling the full Unicode in Cuis tools, that can only display the Latin alphabet, by editing the NCRs.
	The conversions can be done when reading / saving files, or when pasting from Clipboard and storing back on it.

Copy the following and paste in your external text editor
&#913;&#945; 	Alpha 	
&#914;&#946; 	Beta 	
&#915;&#947; 	Gamma 	
&#916;&#948; 	Delta 	
&#917;&#949; 	Epsilon 	
&#918;&#950; 	Zeta 	
&#919;&#951; 	Eta 	
&#920;&#952; 	Theta 	
&#921;&#953; 	Iota 	
&#922;&#954; 	Kappa 	
&#923;&#955; 	Lambda 	
&#924;&#956; 	Mu 	
&#925;&#957; 	Nu
&#926;&#958; 	Xi
&#927;&#959; 	Omicron
&#928;&#960; 	Pi
&#929;&#961; 	Rho
&#931;&#963;&#962; 	Sigma
&#932;&#964; 	Tau
&#933;&#965; 	Upsilon
&#934;&#966; 	Phi
&#935;&#967; 	Chi
&#936;&#968; 	Psi
&#937;&#969; 	Omega
&# 937;&# 969; 	Not a NCR, just regular ASCII chars!!
	"

	| str |
	^ByteArray streamContents: [ :outStream | | inStream nextChar prevPos maybeUnicodeNCR ncrEnd codePoint |
		inStream _ self readStream.
		[ inStream atEnd ] whileFalse: [
			nextChar _ inStream next.
			(convertEmbeddedNCRs and: [ nextChar = $& ])
				ifTrue: [
					prevPos _ inStream position.
					ncrEnd _ 0.
					maybeUnicodeNCR _ inStream next: 9.
					(maybeUnicodeNCR notEmpty and: [ maybeUnicodeNCR first = $# ]) ifTrue: [
						ncrEnd _ maybeUnicodeNCR indexOf: $; ].
					ncrEnd = 0
						ifFalse: [
							maybeUnicodeNCR second = $x
								ifTrue: [
									str _ (maybeUnicodeNCR copyFrom: 3 to: ncrEnd) asUppercase.
									(str first isDigit or: [ str first asciiValue between: $A asciiValue and: $F asciiValue])
										ifTrue: [ codePoint _  ('16r', str) asNumber ]
										ifFalse: [ ncrEnd _ 0 ]]
								ifFalse: [
									str _ maybeUnicodeNCR copyFrom: 2 to: ncrEnd.
									str first isDigit
										ifTrue: [ codePoint _  codePoint _ str asNumber ]
										ifFalse: [ ncrEnd _ 0 ]]].
					ncrEnd = 0
						ifTrue: [
							"Not an NCR after all. Just add the $& and continue from there"
							codePoint _ nextChar codePoint ].
					Character
						evaluate: [ :byte | outStream nextPut: byte ]
						withUtf8BytesOfUnicodeCodePoint: codePoint.
					inStream position: prevPos + ncrEnd ]
				ifFalse: [
					codePoint _ nextChar codePoint.
					Character
						evaluate: [ :byte | outStream nextPut: byte ]
						withUtf8BytesOfUnicodeCodePoint: codePoint ]]]! !

!String methodsFor: 'converting' stamp: 'jmv 3/6/2018 17:40:38'!
asValidInstanceVariableName
	| answer |
	answer _ self asIdentifier: false.
	(Scanner pseudoVariableNames includes: answer)
		ifTrue: [ answer _ answer , 'x' ].
	^ answer

"
'234znak 43 ) 2' asValidInstanceVariableName
'234 xx\ Uml /ler42342380-4' asValidInstanceVariableName
"! !

!String methodsFor: 'converting' stamp: 'jmv 3/6/2018 17:32:02'!
asValidSelector
	^ self asIdentifier: false

"
'234znak 43 ) 2' asValidSelector
"! !

!String methodsFor: 'converting' stamp: 'jmv 5/12/2017 16:39:13'!
asWeek
	"
		'2008-W52' asWeek.
		'2008-W53' asWeek. 'Invalid format!!'.
		'2009-W01' asWeek
		'2009-W02' asWeek
		'2009-W53' asWeek
		'2010-W01' asWeek
		'2010-W02' asWeek
		'2008-W52' asWeek start.
		'2009-W01' asWeek start
		'2009-W02' asWeek start
		'2009-W53' asWeek start
		'2010-W01' asWeek start
		'2010-W02' asWeek start
	"

	^ Week fromString: self! !

!String methodsFor: 'converting' stamp: 'jmv 5/12/2017 16:37:23'!
asYear
	"
		'2008' asYear.
		'2008' asYear start.
	"

	^ Year fromString: self! !

!String methodsFor: 'converting' stamp: 'jmv 9/19/2016 09:33:15'!
base64Decoded
	"Decode the receiver from base 64"
	"
	'SGVsbG8gV29ybGQ=' base64Decoded
	'SGVsbG8gV29ybGQ=' base64Decoded asString
	"
	^(Base64MimeConverter mimeDecode: self)! !

!String methodsFor: 'converting' stamp: 'ls 9/10/1998 08:48'!
capitalized
	"Return a copy with the first letter capitalized"
	| cap |
	self isEmpty ifTrue: [ ^self copy ].
	cap _ self copy.
	cap at: 1 put: (cap at: 1) asUppercase.
	^ cap! !

!String methodsFor: 'converting' stamp: 'di 1/16/98 16:33'!
contractTo: smallSize
	"return myself or a copy shortened by ellipsis to smallSize"
	| leftSize |
	self size <= smallSize
		ifTrue: [^ self].  "short enough"
	smallSize < 5
		ifTrue: [^ self copyFrom: 1 to: smallSize].    "First N characters"
	leftSize _ smallSize-2//2.
	^ self copyReplaceFrom: leftSize+1		"First N/2 ... last N/2"
		to: self size - (smallSize - leftSize - 3)
		with: '...'
"
	'A clear but rather long-winded summary' contractTo: 18
"! !

!String methodsFor: 'converting'!
correctAgainst: wordList
	"Correct the receiver: assume it is a misspelled word and return the (maximum of five) nearest words in the wordList.  Depends on the scoring scheme of alike:"
	| results |
	results _ self correctAgainst: wordList continuedFrom: nil.
	results _ self correctAgainst: nil continuedFrom: results.
	^ results! !

!String methodsFor: 'converting' stamp: 'jmv 3/2/2010 16:36'!
correctAgainst: wordList continuedFrom: oldCollection
	"Like correctAgainst:.  Use when you want to correct against several lists, give nil as the first oldCollection, and nil as the last wordList."

	^ wordList
		ifNil: [
			self correctAgainstEnumerator: nil continuedFrom: oldCollection ]
		ifNotNil: [
			self
				correctAgainstEnumerator: [ :action | wordList do: action without: nil]
				continuedFrom: oldCollection ]! !

!String methodsFor: 'converting' stamp: 'jmv 3/2/2010 16:37'!
correctAgainstDictionary: wordDict continuedFrom: oldCollection
	"Like correctAgainst:continuedFrom:.  Use when you want to correct against a dictionary."

	^ wordDict
		ifNil: [
			self correctAgainstEnumerator: nil continuedFrom: oldCollection ]
		ifNotNil: [
			self
				correctAgainstEnumerator: [ :action | wordDict keysDo: action ]
				continuedFrom: oldCollection ]! !

!String methodsFor: 'converting' stamp: 'jmv 1/7/2014 22:05'!
displayStringOrText
	"To be used in the UI"
	"Answer this string."

	^ self
! !

!String methodsFor: 'converting' stamp: 'jmv 12/14/2018 15:40:54'!
findSelector
	"Revised to use scanner for better removal of extraneous stuff"
	| sel colonIndex |
	sel _ self withBlanksTrimmed.
	colonIndex _ sel indexOf: $:.
	"possible keyword selector"
	(colonIndex > 1 and: [ (self at: colonIndex - 1) isLetter ]) ifTrue: [
		sel _ Scanner findSelectorIn: sel ].
	sel isEmpty ifTrue: [ ^ nil ].
	Symbol
		hasInterned: sel
		ifTrue: [ :aSymbol |
			^ aSymbol ].
	^ nil.! !

!String methodsFor: 'converting' stamp: 'HAW 8/3/2018 11:12:15'!
firstNoBlankIndex 

	^self findFirst: [:aChar | aChar isSeparator not ]! !

!String methodsFor: 'converting' stamp: 'jmv 12/8/2008 15:44'!
initialIntegerOrNil
	"Answer the integer represented by the leading digits of the receiver, or nil if the receiver does not begin with a digit"
	| firstNonDigit |
	(self size = 0 or: [self first isDigit not]) ifTrue: [^ nil].
	firstNonDigit _ (self findFirst: [:m | m isDigit not]).
	firstNonDigit = 0 ifTrue: [firstNonDigit _ self size + 1].
	^ (self copyFrom: 1  to: (firstNonDigit - 1)) asNumber
"
'234Whoopie' initialIntegerOrNil
'wimpy' initialIntegerOrNil
'234' initialIntegerOrNil
'2N' initialIntegerOrNil
'2' initialIntegerOrNil
'  89Ten ' initialIntegerOrNil
'78 92' initialIntegerOrNil
"
! !

!String methodsFor: 'converting' stamp: 'HAW 12/17/2018 18:03:42'!
keywords
	"Answer an array of the keywords that compose the receiver."
	| kwd char keywords isAllValidInIdentifiers |
	keywords _ Array streamContents: [ :kwds |
		kwd _ WriteStream on: (String new: 16).
		isAllValidInIdentifiers _ true.
		1
			to: self size
			do: [ :i |
				char _ self at: i.
				kwd nextPut: char.
				char = $: & isAllValidInIdentifiers
					ifTrue: [
						kwds nextPut: kwd contents.
						kwd reset.
						isAllValidInIdentifiers _ true ]
					ifFalse: [
						char isValidInIdentifiers ifFalse: [ isAllValidInIdentifiers _ false ]]].
		kwd isEmpty ifFalse: [ kwds nextPut: kwd contents ]].
	
	^ keywords.! !

!String methodsFor: 'converting' stamp: 'HAW 8/3/2018 11:12:25'!
lastNoBlankIndex

	^ self findLast: [:aChar | aChar isSeparator not].
	! !

!String methodsFor: 'converting' stamp: 'jmv 12/6/2011 10:34'!
prefixAndSuffix: aCharacter
	"Answer an array with the prefix up to the last occurrence of aCharacter, and the suffix after it.
	Answer nil if aCharacter is not in self
	'1164-ReferenceStreamFix-jmv.1.cs' prefixAndSuffix: $-
	"
	| i |
	i _ self findLast: [ :c | c = aCharacter ].
	i = 0 ifTrue: [ ^ nil ].
	^ { self copyFrom: 1 to: i-1 . self copyFrom: i+1 to: self size }! !

!String methodsFor: 'converting' stamp: 'sma 5/20/2000 17:17'!
romanNumber
	| value v1 v2 |
	value _ v1 _ v2 _ 0.
	self reverseDo:
		[:each |
		v1 _ #(1 5 10 50 100 500 1000) at: ('IVXLCDM' indexOf: each).
		v1 >= v2
			ifTrue: [value _ value + v1]
			ifFalse: [value _ value - v1].
		v2 _ v1].
	^ value! !

!String methodsFor: 'converting' stamp: 'jmv 6/14/2012 22:01'!
squeezedTo: n
	"
Examples:
	Do nothing:
		'This one is a rather long phrase' squeezedTo: 32

	1-remove blanks (result can be shorter than asked):
		'This one is a rather long phrase' squeezedTo: 30

	2-remove necessary trailing vowels
		'This one is a rather long phrase' squeezedTo: 24

	3-truncate as needed (and add ellipsis)
		'This one is a rather long phrase' squeezedTo: 15

	4-avoid ellipsis
		'This one is a rather long phrase' squeezedTo: 5
	"
	| vowelCount read write i char allowedVowels str desiredSize postFix j |
	str := self.
	desiredSize := n.
	str size <= n ifTrue: [^str].
	str := str asCamelCase.
	str size <= n ifTrue: [^str].
	postFix := ''.
	desiredSize := n - postFix size.
	vowelCount := str
		inject: 0
		into: [:prev :each | each isVowel ifTrue: [prev + 1] ifFalse: [prev]].
	str size - vowelCount <= desiredSize
		ifTrue: [allowedVowels := vowelCount - (str size - desiredSize)]
		ifFalse: [
			allowedVowels := 0.
			postFix := '...'.
			n - postFix size < 5 ifTrue: [postFix := ''].
			desiredSize := n - postFix size].

	read := str readStream.
	write := String new writeStream.
	i := 0.
	j := 0.
	[read atEnd not and: [j < desiredSize]] whileTrue: [
		char := read next.
		(char isVowel not or: [i < allowedVowels]) ifTrue: [
			char isVowel ifTrue: [i := i + 1].
			write nextPut: char.
			j := j + 1]].
	str := write contents , postFix.
	^ str! !

!String methodsFor: 'converting' stamp: 'jmv 3/2/2010 10:10'!
substrings
	"Answer an array of the substrings that compose the receiver."
	| result end beginning |

	result _ WriteStream on: (Array new: 10).



	end _ 0.
	"find one substring each time through this loop"
	[ 
		"find the beginning of the next substring"
		beginning _ self indexOfAnyOf: CSNonSeparators startingAt: end+1 ifAbsent: nil.
		beginning notNil ] 
	whileTrue: [
		"find the end"
		end _ self indexOfAnyOf: CSSeparators startingAt: beginning ifAbsent: [ self size + 1 ].
		end _ end - 1.

		result nextPut: (self copyFrom: beginning to: end).

	].

	^result contents! !

!String methodsFor: 'converting' stamp: 'sw 11/25/96'!
surroundedBySingleQuotes
	"Answer the receiver with leading and trailing quotes.  "

	^ $' asString, self, $' asString! !

!String methodsFor: 'converting' stamp: 'ls 8/15/1998 10:31'!
translateFrom: start  to: stop  table: table
	"translate the characters in the string by the given table, in place"
	String translate: self  from: start to: stop table: table! !

!String methodsFor: 'converting' stamp: 'ls 8/18/1998 07:44'!
translateToLowercase
	"Translate all characters to lowercase, in place"

	self translateWith: LowercasingTable! !

!String methodsFor: 'converting' stamp: 'SqR 6/13/2000 20:10'!
translateToUppercase
	"Translate all characters to lowercase, in place"

	self translateWith: UppercasingTable! !

!String methodsFor: 'converting' stamp: 'ls 8/15/1998 08:30'!
translateWith: table
	"translate the characters in the string by the given table, in place"
	^self translateFrom: 1 to: self size table: table! !

!String methodsFor: 'converting'!
truncateTo: smallSize
	"return myself or a copy shortened to smallSize.  1/18/96 sw"

	^ self size <= smallSize
		ifTrue:
			[self]
		ifFalse:
			[self copyFrom: 1 to: smallSize]! !

!String methodsFor: 'converting' stamp: 'sw 9/2/1998 17:09'!
truncateWithElipsisTo: maxLength
	"Return myself or a copy suitably shortened but with elipsis added"

	^ self size <= maxLength
		ifTrue:
			[self]
		ifFalse:
			[(self copyFrom: 1 to: (maxLength - 3)), '...']


	"'truncateWithElipsisTo:' truncateWithElipsisTo: 20"! !

!String methodsFor: 'converting' stamp: 'jmv 3/6/2018 17:15:13'!
uncapitalized
	"Answer an object like the receiver but with first character downshifted if necesary"
	"'MElViN' uncapitalized"
	"#Will uncapitalized"
	| answer |
	self isEmpty ifTrue: [^ self].
	answer _ self isString
				ifTrue: ["don't modify receiver"
					self copy]
				ifFalse: [self asString].
	answer at: 1 put: (answer at: 1) asLowercase.
	^ self isString
		ifTrue: [answer]
		ifFalse: [answer as: self class]! !

!String methodsFor: 'converting' stamp: 'jmv 3/13/2012 16:10'!
withBlanksCondensed
	"Return a copy of the receiver with leading/trailing blanks removed
	 and consecutive white spaces condensed as a single space."

	| trimmed lastWasBlank |
	trimmed _ self withBlanksTrimmed.
	^String streamContents: [ :stream |
		lastWasBlank _ false.
		trimmed do: [ :c |
			c isSeparator
				ifTrue: [ lastWasBlank ifFalse: [ stream space ]]
				ifFalse: [ stream nextPut: c ].
			lastWasBlank _ c isSeparator ]].

	" 
	' abc  d   ' withBlanksCondensed
	' abc  d
	s
	as   zz 	q 			q' withBlanksCondensed
	"! !

!String methodsFor: 'converting' stamp: 'HAW 8/3/2018 11:13:24'!
withBlanksTrimmed
	"Return a copy of the receiver from which leading and trailing blanks have been trimmed."

	| first |
	
	first _ self firstNoBlankIndex.
	first = 0 ifTrue: [^ ''].  "no non-separator character"
	
	^ self copyFrom: first to: self lastNoBlankIndex 

	" ' abc  d   ' withBlanksTrimmed"
! !

!String methodsFor: 'converting' stamp: 'jmv 4/25/2012 10:59'!
withCuisLineEndings
	"assume the string is textual, and that CR, LF, and CRLF are all 
	valid line endings.  Replace each occurence with a single Lf
	('aLine', String crlfString, 'anotherOne') withCuisLineEndings
	"

	^ self withLineEndings: String newLineString! !

!String methodsFor: 'converting' stamp: 'jmv 1/18/2015 10:05'!
withDescriptiveLineEndings
	^ self withLineEndings: '[enter]'! !

!String methodsFor: 'converting' stamp: 'jmv 8/28/2013 10:27'!
withLineEndings: lineEndingString
	"assume the string is textual, and that CR, LF, and CRLF are all valid line endings. 
	Answer a new String, where each occurence with is replaced with lineEndingString"
	| cr lf crlf inPos outPos outString lineEndPos newOutPos lineEndingSize |
	cr _ Character cr.
	lf _ Character lf.
	crlf _ CharacterSet new.
	crlf add: cr; add: lf.

	inPos _ 1.
	outPos _ 1.
	lineEndingSize _ lineEndingString size.
	"This could be extremely inefficient if lineEndingString size > 1"
	outString _ String new: self size * lineEndingSize.

	[
		lineEndPos _ self indexOfAnyOf: crlf startingAt: inPos ifAbsent: [0].
		lineEndPos ~= 0 ] whileTrue: [
			newOutPos _ outPos + (lineEndPos - inPos).
			outString replaceFrom: outPos to: newOutPos - 1 with: self startingAt: inPos.
			1 to: lineEndingSize do: [ :i |
				outString at: newOutPos put: (lineEndingString at: i).
				newOutPos _ newOutPos + 1 ].
			outPos _ newOutPos.
			((self at: lineEndPos) = cr and: [ lineEndPos < self size and: [ (self at: lineEndPos+1) = lf ] ]) ifTrue: [
				"CRLF ending"
				inPos _ lineEndPos + 2 ]
			ifFalse: [ 
				"CR or LF ending"
				inPos _ lineEndPos + 1 ]. ].

	"no more line endings.  copy the rest"
	newOutPos _ outPos + (self size - inPos).
	outString replaceFrom: outPos to: newOutPos with: self startingAt: inPos.

	^outString copyFrom: 1 to: newOutPos! !

!String methodsFor: 'converting' stamp: 'jmv 3/14/2012 09:14'!
withNewLines
	"Return a copy of the receiver in which backslash (\) characters have been replaced with newLine (i.e. Lf)."

	^ self collect: [ :c | c = $\ ifTrue: [ Character newLineCharacter ] ifFalse: [ c ]].! !

!String methodsFor: 'converting' stamp: 'jmv 6/16/2016 11:30'!
withoutEnclosing: aCharacter
	"
	'*Hello*' withoutEnclosing: $*
	"
	| s |
	s _ self size.
	^((self at: 1) = aCharacter and: [ (self at: s) = aCharacter ])
		ifTrue: [ self copyFrom: 2 to: s-1 ]
		ifFalse: [ self ]! !

!String methodsFor: 'converting' stamp: 'HAW 8/3/2018 11:02:05'!
withoutLeadingBlanks
	
	"Return a copy of the receiver from which leading blanks have been trimmed."
	
	| first |
	
	first := self firstNoBlankIndex.
	first = 0 ifTrue: [^ ''].  
	first = 1 ifTrue: [^ self ].
	
	"no non-separator character"	
	^ self copyFrom: first to: self size
		
	" '    abc  d  ' withoutLeadingBlanks"
! !

!String methodsFor: 'converting' stamp: 'jmv 10/18/2016 10:57:38'!
withoutPrefix: aString
	"
	'Elvis' withoutPrefix: 'El'
	'Elvis' withoutPrefix: 'Paul'
	"
	^(self beginsWith: aString)
		ifTrue: [ self copyFrom: aString size+1 to: self size ]! !

!String methodsFor: 'converting' stamp: 'HAW 6/8/2019 18:20:03'!
withoutSeparators
	
	^self reject: [ :aCharacter | aCharacter isSeparator ]! !

!String methodsFor: 'converting' stamp: 'jmv 12/16/2013 22:51'!
withoutSuffix: aString
	"
	'Elvis' withoutSuffix: 'vis'
	'Elvis' withoutSuffix: 'Paul'
	"
	^(self endsWith: aString)
		ifTrue: [ self copyFrom: 1 to: self size - aString size ]! !

!String methodsFor: 'converting' stamp: 'HAW 8/3/2018 11:08:59'!
withoutTrailingBlanks
	"Return a copy of the receiver from which trailing blanks have been trimmed."

	| last |
	
	last _ self lastNoBlankIndex.
	last = 0 ifTrue: [^ ''].  "no non-separator character"
	last = self size ifTrue: [ ^self ].
	
	^ self copyFrom: 1 to: last

	" ' abc  d   ' withoutTrailingBlanks"
! !


!String methodsFor: 'enumerating' stamp: 'jmv 6/11/2019 12:23:44'!
collect: aBlock 
	"Refer to the comment in Collection|collect:."
	| result value stillAString |
	result _ self species new: self size.
	stillAString _ true.
	1 to: self size do: [ :index |
		value _ aBlock value: (self at: index).
		(stillAString and: [ (value is: #Character) not]) ifTrue: [
			result _ result asArray.
			stillAString _ false ].
		result at: index put: value].
	^ result! !


!String methodsFor: 'displaying' stamp: 'jmv 7/27/2015 17:13'!
displayAt: aPoint 
	"Display the receiver as a DisplayText at aPoint on the display screen."

	self displayOn: Display at: aPoint.
	DisplayScreen screenUpdateRequired: nil! !

!String methodsFor: 'displaying' stamp: 'jmv 3/12/2018 15:56:28'!
displayOn: aDisplayMedium
	"Display the receiver on the given DisplayMedium.  5/16/96 sw"

	self displayOn: aDisplayMedium at: `0 @ 0`! !

!String methodsFor: 'displaying' stamp: 'jmv 4/5/2020 21:19:20'!
displayOn: aDisplayMedium at: aPoint 
	"Show a representation of the receiver as a DisplayText at location aPoint on aDisplayMedium, using black-colored text."

	^self displayOn: aDisplayMedium at: aPoint textColor: `Color black`
	"
	'Display' displayOn: Display at: 10@10. Display forceToScreen.
	"! !

!String methodsFor: 'displaying' stamp: 'jmv 5/12/2015 14:51'!
displayOn: aDisplayMedium at: aPoint textColor: aColor
	"Show a representation of the receiver as a DisplayText at location aPoint on aDisplayMedium, rendering the text in the designated color"

	^aDisplayMedium getCanvas drawString: self at: aPoint font: nil color: aColor! !

!String methodsFor: 'displaying' stamp: 'jmv 7/17/2017 15:41:46'!
displayProgressAt: aPoint from: minVal to: maxVal during: workBlock
	"Display this string as a caption over a progress bar while workBlock is evaluated.

EXAMPLE (Select next 6 lines and Do It)

'Now here''s some Real Progress'
	displayProgressAt: Sensor mousePoint
	from: 0 to: 100
	during: [:barBlock |
		1 to: 100 do: [:x | 
			(Delay forMilliseconds: 10) wait.
			barBlock value: x.]].

['Now here''s some Real Progress'
	displayProgressAt: Sensor mousePoint
	from: 0 to: 100
	during: [:barBlock |
	1 to: 100 do: [:x | barBlock value: x.
			(Delay forMilliseconds: 100) wait]].] fork
	
['Now here''s some Real Progress'
	displayProgressAt: Sensor mousePoint
	from: 0 to: 10
	during: [:barBlock |
	1 to: 30 do: [:x | barBlock value: x \\ 11.
			(Delay forMilliseconds: 100) wait]]] fork

'Now here''s some Real Progress'
	displayProgressAt: Sensor mousePoint
	from: 0 to: 10
	during: [:barBlock |
	1 to: 30 do: [:x | barBlock value: nil.
			(Delay forMilliseconds: 200) wait]].

HOW IT WORKS (Try this in any other language :-)
Since your code (the last 2 lines in the above example) is in a block,
this method gets control to display its heading before, and clean up 
the screen after, its execution.
The key, though, is that the block is supplied with an argument,
named 'bar' in the example, which will update the bar image every 
it is sent the message value: x, where x is in the from:to: range.

The use of ProgressInitiationException allows for avoiding actual
progress display, by catching the exception.
"
	^ProgressInitiationException 
		display: self
		at: aPoint 
		from: minVal 
		to: maxVal 
		during: workBlock! !


!String methodsFor: 'printing'!
isLiteral

	^true! !

!String methodsFor: 'printing' stamp: 'jmv 3/13/2012 12:48'!
print
	Transcript show: self; newLine! !

!String methodsFor: 'printing' stamp: 'sma 6/1/2000 09:48'!
printOn: aStream 
	"Print inside string quotes, doubling inbedded quotes."

	self storeOn: aStream! !

!String methodsFor: 'printing'!
storeOn: aStream 
	"Print inside string quotes, doubling inbedded quotes."
	| x |
	aStream nextPut: $'.
	1 to: self size do:
		[:i |
		aStream nextPut: (x _ self at: i).
		x == $' ifTrue: [aStream nextPut: x]].
	aStream nextPut: $'! !


!String methodsFor: 'private' stamp: 'jmv 3/2/2010 16:38'!
correctAgainstEnumerator: wordBlock continuedFrom: oldCollection
	"The guts of correction, instead of a wordList, there is a block that should take another block and enumerate over some list with it."

	| choices scoreMin results score maxChoices |
	scoreMin _ self size // 2 min: 3.
	maxChoices _ 10.
	choices _ oldCollection
		ifNil: [ SortedCollection sortBlock: [ :x :y | x value > y value ] ].
	wordBlock
		ifNil: [
			results _ OrderedCollection new.
			1 to: (maxChoices min: choices size) do: [ :i | results add: (choices at: i) key ] ]
		ifNotNil: [
			wordBlock value: [ :word |
				(score _ self alike: word) >= scoreMin ifTrue: [
					choices add: (Association key: word value: score).
						(choices size >= maxChoices) ifTrue: [ scoreMin _ (choices at: maxChoices) value] ] ].
			results _ choices ].
	^ results! !

!String methodsFor: 'private' stamp: 'dgd 8/27/2003 19:42'!
evaluateExpression: aString parameters: aCollection 
	"private - evaluate the expression aString with  
	aCollection as the parameters and answer the  
	evaluation result as an string"
	| index |
	index := ('0' , aString) asNumber.

	index isZero
		ifTrue: [^ '[invalid subscript: {1}]' format: {aString}].

	index > aCollection size
		ifTrue: [^ '[subscript is out of bounds: {1}]' format: {aString}].

	^ (aCollection at: index) asString! !

!String methodsFor: 'private' stamp: 'dgd 8/27/2003 19:41'!
getEnclosedExpressionFrom: aStream 
	"private - get the expression enclosed between '{' and 
	'}' and remove all the characters from the stream"
	| result currentChar |
	result := String new writeStream.

	[aStream atEnd 
		or: [(currentChar := aStream next) == $}]]
		whileFalse: [result nextPut: currentChar].

	^ result contents withBlanksTrimmed! !

!String methodsFor: 'private' stamp: 'jmv 1/13/2017 09:58:04'!
replaceFrom: start to: stop with: replacement startingAt: repStart 
	"Primitive. This destructively replaces elements from start to stop in the receiver starting at index, repStart, in the collection, replacement. Answer the receiver. Range checks are performed in the primitive only. Optional. See Object documentation whatIsAPrimitive."

	<primitive: 105 error: ec>
	super replaceFrom: start to: stop with: replacement startingAt: repStart! !


!String methodsFor: 'system primitives' stamp: 'ar 2/3/2001 16:12'!
compare: string1 with: string2 collated: order
	"Return 1, 2 or 3, if string1 is <, =, or > string2, with the collating order of characters given by the order array."

	| len1 len2 c1 c2 |
	<primitive: 'primitiveCompareString' module: 'MiscPrimitivePlugin'>
	self var: #string1 declareC: 'unsigned char *string1'.
	self var: #string2 declareC: 'unsigned char *string2'.
	self var: #order declareC: 'unsigned char *order'.

	len1 _ string1 size.
	len2 _ string2 size.
	1 to: (len1 min: len2) do:
		[:i |
		c1 _ order at: (string1 basicAt: i) + 1.
		c2 _ order at: (string2 basicAt: i) + 1.
		c1 = c2 ifFalse: 
			[c1 < c2 ifTrue: [^ 1] ifFalse: [^ 3]]].
	len1 = len2 ifTrue: [^ 2].
	len1 < len2 ifTrue: [^ 1] ifFalse: [^ 3].
! !

!String methodsFor: 'system primitives' stamp: 'jmv 9/5/2016 17:14:46'!
findSubstring: key in: body startingAt: start matchTable: matchTable
	"Answer the index in the string body at which the substring key first occurs, at or beyond start.  The match is determined using matchTable, which can be used to effect, eg, case-insensitive matches.  If no match is found, zero will be returned.

	The algorithm below is not optimum -- it is intended to be translated to C which will go so fast that it wont matter."
	| index |
	<primitive: 'primitiveFindSubstring' module: 'MiscPrimitivePlugin'>
	self var: #key declareC: 'unsigned char *key'.
	self var: #body declareC: 'unsigned char *body'.
	self var: #matchTable declareC: 'unsigned char *matchTable'.

	key size = 0 ifTrue: [^ 0].
	start to: body size - key size + 1 do:
		[:startIndex |
		index _ 1.
			[(matchTable at: (body at: startIndex+index-1) numericValue + 1)
				= (matchTable at: (key at: index) numericValue + 1)]
				whileTrue:
				[index = key size ifTrue: [^ startIndex].
				index _ index+1]].
	^ 0
"
' ' findSubstring: 'abc' in: 'abcdefabcd' startingAt: 1 matchTable: CaseSensitiveOrder 1
' ' findSubstring: 'abc' in: 'abcdefabcd' startingAt: 2 matchTable: CaseSensitiveOrder 7
' ' findSubstring: 'abc' in: 'abcdefabcd' startingAt: 8 matchTable: CaseSensitiveOrder 0
' ' findSubstring: 'abc' in: 'abcdefABcd' startingAt: 2 matchTable: CaseSensitiveOrder 0
' ' findSubstring: 'abc' in: 'abcdefABcd' startingAt: 2 matchTable: CaseInsensitiveOrder 7
"! !

!String methodsFor: 'system primitives' stamp: 'jmv 12/14/2018 15:27:30'!
numArgs
	"Answer either the number of arguments that the receiver would take if considered a selector. 
	Answer -1 if it couldn't be a selector. 
		Note that currently this will answer -1 for anything begining with an uppercase letter even though 
		the system will accept such symbols as selectors.  It is intended mostly for the assistance of spelling correction."
	| firstChar numColons start ix |
	self size = 0 ifTrue: [ ^ -1 ].
	"Binary messages"
	(self allSatisfy: [ :c | c isValidInBinarySelectors ])
		ifTrue: [ ^1 ].
	"Unary and keyword messages"
	firstChar _ self at: 1.
	firstChar isValidStartOfIdentifiers ifTrue: [
		"Fast reject if any chars are non-alphanumeric"
		(self
			findSubstring: '~'
			in: self
			startingAt: 1
			matchTable: Tokenish) > 0 ifTrue: [ ^ -1 ].
		"Fast colon count"
		numColons _ 0.
		start _ 1.
		[
		(ix _ self
			findSubstring: ':'
			in: self
			startingAt: start
			matchTable: CaseSensitiveOrder) > 0 ] whileTrue: [
			numColons _ numColons + 1.
			start _ ix + 1 ].
		^ numColons ].
	^ -1.! !


!String methodsFor: 'testing' stamp: 'RAA 6/21/1999 11:28'!
hasContentsInExplorer

	^false! !

!String methodsFor: 'testing' stamp: 'jpb 8/3/2019 00:01:22'!
is: aSymbol
	"Note: Senders might prefer #isString for perfomance reasons. Still, Cuis tries to keep isXXX testing selectors to a minimum."
	^#String = aSymbol or: [ super is: aSymbol]! !

!String methodsFor: 'testing' stamp: 'len 11/26/2016 09:05:35'!
isAlphaNumeric
	"Answer true if the receiver contains only letters or digits."
	^ self allSatisfy: [:each| each isAlphaNumeric]! !

!String methodsFor: 'testing' stamp: 'jmv 7/4/2016 22:01'!
isRemote
	^false! !

!String methodsFor: 'testing' stamp: 'sma 6/15/2000 15:48'!
isString
	^ true! !


!String methodsFor: 'paragraph support' stamp: 'jmv 3/14/2012 08:22'!
encompassLine: anInterval
	"Return an interval that includes anInterval, and that comprises one or several whole paragraphs in the receiver.
	Answer starts at the position following a newLine (or eventually 1) and ends before a newLine (or eventually at self size)
	See also encompassParagraph:"
	| left rightCr rightNull |
	left _ (self lastIndexOf: Character newLineCharacter startingAt: anInterval first - 1 ifAbsent:[0]) + 1.
	rightCr _ (self indexOf: Character newLineCharacter startingAt: (anInterval last max: anInterval first) ifAbsent: [self size+1])-1.
	rightNull _ (self indexOf: Character null startingAt: (anInterval last max: anInterval first) ifAbsent: [self size+1])-1.
	^left to: (rightCr min: rightNull)! !

!String methodsFor: 'paragraph support' stamp: 'jmv 3/14/2012 08:22'!
encompassParagraph: anInterval
	"Return an interval that includes anInterval, and that comprises one or several whole paragraphs in the receiver.
	Answer starts at the position following a newLine (or eventually 1) and ends at a newLine (or eventually at self size).
	Look also for null characters. Never include null characters in the answer.
	See also #encompassLine:"
	| left rightCr rightNull |
	left _ (self lastIndexOf: Character newLineCharacter startingAt: anInterval first - 1 ifAbsent:[0]) + 1.
	rightCr _ (self indexOf: Character newLineCharacter startingAt: (anInterval last max: anInterval first) ifAbsent: [self size]).
	rightNull _ (self indexOf: Character null startingAt: (anInterval last max: anInterval first) ifAbsent: [self size+1])-1.
	^left to: (rightCr min: rightNull)! !

!String methodsFor: 'paragraph support' stamp: 'jmv 3/14/2012 08:34'!
endOfParagraphBefore: aNumber
	"Return the index of the last Character newLineCharacter before position aNumber, or zero if this is the first paragraph.
	'ddd' endOfParagraphBefore: 3
	'dd
	d' endOfParagraphBefore: 4
	"
	^ self lastIndexOf: Character newLineCharacter startingAt: aNumber - 1 ifAbsent: [ 0 ]! !

!String methodsFor: 'paragraph support' stamp: 'jmv 3/16/2012 12:12'!
indentationIfBlank: aBlock
	"Answer the number of leading tabs in the receiver.  If there are
	 no visible characters, pass the number of tabs to aBlock and return its value."
	| reader leadingTabs lastSeparator tab ch |
	tab _ Character tab.
	reader _ ReadStream on: self.
	leadingTabs _ 0.
	[ reader atEnd not and: [ (ch _ reader next) == tab ]] whileTrue: [
		leadingTabs _ leadingTabs + 1 ].
	lastSeparator _ leadingTabs + 1.
	[ reader atEnd not and: [
		ch isSeparator and: [ ch isLineSeparator not ]]] whileTrue: [
			lastSeparator _ lastSeparator + 1.
			ch _ reader next ].
	lastSeparator = self size | (ch notNil and: [ch isLineSeparator]) ifTrue: [
		^ aBlock value: leadingTabs ].
	^ leadingTabs! !


!String methodsFor: 'arithmetic' stamp: 'jmv 9/7/2011 07:30'!
* arg

	self shouldNotImplement.
"	^ arg adaptToString: self andSend: #*"! !

!String methodsFor: 'arithmetic' stamp: 'jmv 9/7/2011 07:29'!
+ arg

	self shouldNotImplement.
"	^ arg adaptToString: self andSend: #+"! !

!String methodsFor: 'arithmetic' stamp: 'jmv 9/7/2011 07:30'!
- arg

	self shouldNotImplement.
"	^ arg adaptToString: self andSend: #-"! !

!String methodsFor: 'arithmetic' stamp: 'pb 5/25/2016 01:13'!
/ arg
	"If working with file paths, just use $/
	Or better yet, use DirectoryEntry protocol"

	self shouldNotImplement! !

!String methodsFor: 'arithmetic' stamp: 'jmv 9/7/2011 07:30'!
// arg

	self shouldNotImplement.
"	^ arg adaptToString: self andSend: #//"! !

!String methodsFor: 'arithmetic' stamp: 'jmv 9/7/2011 07:30'!
\\ arg

	self shouldNotImplement.
"	^ arg adaptToString: self andSend: #\\"! !


!String methodsFor: 'user interface' stamp: 'jmv 1/2/2013 15:26'!
edit

	self editLabel: 'Text Editor'! !

!String methodsFor: 'user interface' stamp: 'jmv 1/2/2013 15:26'!
editLabel: labelString

	TextModel new contents: self; openLabel: labelString! !


!String methodsFor: 'formatting' stamp: 'dgd 8/27/2003 19:49'!
format: aCollection 
	"format the receiver with aCollection  
	 
	simplest example:  
	'foo {1} bar' format: {Date today}.
	 
	complete example:  
	'\{ \} \\ foo {1} bar {2}' format: {12. 'string'}.  
	"
	| result stream |
	result := String new writeStream.
	stream := self readStream.

	[stream atEnd]
		whileFalse: [| currentChar | 
			currentChar := stream next.
			currentChar == ${
				ifTrue: [| expression | 
					expression := self getEnclosedExpressionFrom: stream.
					result
						nextPutAll: (self evaluateExpression: expression parameters: aCollection)]
				ifFalse: [
					currentChar == $\
						ifTrue: [stream atEnd
								ifFalse: [result nextPut: stream next]]
						ifFalse: [result nextPut: currentChar]]].

	^ result contents! !


!String methodsFor: 'uCompletion' stamp: 'jmv 11/1/2011 23:20'!
separateKeywords

	^self, ' '! !


!String methodsFor: 'fileman-converting' stamp: 'pb 5/25/2016 01:21'!
asAbsolutePathName
	"See comment at #isAbsolutePathName"

	| slash |
	slash _ FileIOAccessor default slash.
	^ String streamContents: [ :childPath |
		childPath nextPutAll: slash.
		(FileIOAccessor default absolutePathComponentsFor: self)
			do: [ :each | childPath nextPutAll: each]
			separatedBy: [childPath nextPutAll: slash]]! !

!String methodsFor: 'fileman-converting' stamp: 'jmv 8/1/2018 16:17:21'!
asDirectoryEntry
	"See examples in #asFileEntry method comment"
	^DirectoryEntry withPathName: self! !

!String methodsFor: 'fileman-converting' stamp: 'pb 5/25/2016 01:21'!
asDriveName
	"Answer a real drive name, or else answer nil.
	(Original FileMan implementation would answer first token on Mac even if it is not a Drive Name,
	and self in any case in other Unix variants)
	
Windows
	'C:\' asDriveName 'C:'
	'NotAChance' asDriveName nil
	
Linux
	'/media/cdrom' asDriveName nil

MacOsX
    '/SanDisk32-NTFS' asDriveName nil
	
	"

	| candidate |
	FileIOAccessor default onWindows ifTrue: [
		self beginsWithWindowsDriveName ifTrue: [ 
		^self copyFrom: 1 to: 2 ]].

	(FileIOAccessor default onMacClassic) ifTrue: [
		candidate _ self upToFirstPathSeparator.
		"Aparently on Mac Classic, 
			xxx/yyy means xxx must be a drive name
			/xxx/yyy means xxx could be any folder in root. Check to make sure!!
		"
		('/' asDirectoryEntry directoryNames includes: candidate) ifTrue: [
			^candidate ]].
	
	^ nil! !

!String methodsFor: 'fileman-converting' stamp: 'jmv 8/1/2018 16:17:23'!
asFileEntry
	"

Windows	
	'C:\Windows' asFileEntry exists false
	'C:\Windows' asDirectoryEntry exists true
	'/' asFileEntry exists false
	'/' asDirectoryEntry exists false
	'C:\' asFileEntry exists false
	'C:\' asDirectoryEntry exists true
	('C:' asDirectoryEntry // 'Windows') exists false
	('C:' asDirectoryEntry / 'Windows') exists true
	
Linux
    '/var' asFileEntry exists
    '/var' asDirectoryEntry exists true
    '/' asFileEntry exists false
    '/' asDirectoryEntry exists true
    '/media/cdrom' asFileEntry exists false
    '/media/cdrom' asDirectoryEntry exists true
    ('/bin' asDirectoryEntry / 'more') exists false
    ('/bin' asDirectoryEntry // 'more') exists true

MacOsX
    '/var' asFileEntry exists false
    '/var' asDirectoryEntry exists true
    '/' asFileEntry exists false
    '/' asDirectoryEntry exists  true
    '/Volumes/SanDisk32-NTFS' asFileEntry exists false
    '/Volumes/SanDisk32-NTFS' asDirectoryEntry exists true
    'SanDisk32-NTFS' asFileEntry exists false
    'SanDisk32-NTFS' asDirectoryEntry exists false
	
	"
	self isRelativeMark ifTrue: [ ^self error: 'Maybe you need to call #asDirectoryEntry!!' ].
	^FileEntry withPathName: self! !

!String methodsFor: 'fileman-converting' stamp: 'mu 3/4/2007 11:04'!
asPathComponents
	| tokens |

	self isRelativePathName ifTrue: [self error: 'relative form is invaild!!'].

	tokens := self asPathTokens.
	^tokens! !

!String methodsFor: 'fileman-converting' stamp: 'jmv 6/6/2015 23:56'!
asPathTokens

	^self beginsWithWindowsDriveName
		ifTrue: [
			(OrderedCollection with: (self copyFrom: 1 to: 2)), 
				((self copyFrom: 3 to: self size) findTokens: String pathSeparators) ]
		ifFalse: [
			self findTokens: String pathSeparators ]! !

!String methodsFor: 'fileman-converting' stamp: 'jmv 6/6/2015 23:44'!
withoutWindowsDriveName
	^self beginsWithWindowsDriveName 
		ifFalse: [ self ]
		ifTrue: [ self copyFrom: 3 to: self size ]! !


!String methodsFor: 'fileman-testing' stamp: 'mu 3/4/2007 10:22'!
beginsWithPathSeparator
	self ifEmpty: [^false].
	^self first isPathSeparator! !

!String methodsFor: 'fileman-testing' stamp: 'jmv 9/17/2015 10:36'!
beginsWithWindowsDriveName
	"Answer doesn't depend on running on Windows or not"
	self size < 2 ifTrue: [ ^false ].
	^self first isDriveLetter
		and: [ self second isDriveSeparator
			and: [ self size = 2 or: [ self third isPathSeparator ]]]! !

!String methodsFor: 'fileman-testing' stamp: 'pb 5/25/2016 01:21'!
isAbsolutePathName
	"Note: On Windows, both 'C:\Users\Someone\file.txt' and '\Users\Someone\file.txt'
	and even '/Users/Someone/file.txt' are considered an absolute pathName.
	This is essentially because FilePlugin can handle them. The gained uniformity with Unix is nice."
	| upperName |
	self isEmpty ifTrue: [^ false].
	self first isPathSeparator ifTrue: [^ true].

	FileIOAccessor default onWindows
		ifTrue: [
			^ self beginsWithWindowsDriveName and: [ self size = 2 or: [ (self at: 3) isPathSeparator ]]].

	FileIOAccessor default onMacClassic ifTrue: [
		upperName := self asUppercase.
		^'/' asDirectoryEntry directoryNames anySatisfy: [ :each |
			(upperName beginsWith: each)
					and: [| nextPos | 
						nextPos := each size + 1 min: self size max: 1.
						(self at: nextPos) isPathSeparator ]]].

	^ false! !

!String methodsFor: 'fileman-testing' stamp: 'pb 5/25/2016 01:21'!
isDriveName
	FileIOAccessor default onWindows
		ifTrue: [
			^ (self size between: 2 and: 3)
				and: [self beginsWithWindowsDriveName]].

	FileIOAccessor default onMacClassic ifTrue: [
		^'/' asDirectoryEntry directoryNames includes: self].

	^false! !

!String methodsFor: 'fileman-testing' stamp: 'mu 3/2/2007 22:05'!
isPathSeparator
	self = '\' ifTrue: [^true].
	self = ':' ifTrue: [^true].
	self = '/' ifTrue: [^true].
	^false! !

!String methodsFor: 'fileman-testing' stamp: 'mu 6/11/2006 22:41'!
isRelativeMark
	
	self = '.' ifTrue: [^true].
	self = '..' ifTrue: [^true].

	^false! !

!String methodsFor: 'fileman-testing' stamp: 'mu 3/4/2007 10:46'!
isRelativePathName
	self ifEmpty: [^false].
	self isRelativeMark ifTrue: [^true].
	^#('.' '..') includes: self upToFirstPathSeparator ! !


!String methodsFor: 'fileman-actions' stamp: 'mu 6/11/2006 22:12'!
fileContents
	^self asFileEntry fileContents! !

!String methodsFor: 'fileman-actions' stamp: 'mu 6/11/2006 22:19'!
fileContents: aString
	self asFileEntry fileContents: aString.
	^aString! !


!String methodsFor: 'fileman-accessing' stamp: 'jmv 4/2/2016 23:07'!
indexOfFirstPathSeparator
	self
		withIndexDo: [:each :idx | each isPathSeparator
				ifTrue: [^ idx]].
	^ 0! !

!String methodsFor: 'fileman-accessing' stamp: 'jmv 10/16/2015 14:21'!
indexOfLastPathSeparator
	"
	'pp.txt' indexOfLastPathSeparator
	'/pp.txt' indexOfLastPathSeparator
	'a/pp.txt' indexOfLastPathSeparator
	'b/a/pp.txt' indexOfLastPathSeparator
	'/b/a/pp.txt' indexOfLastPathSeparator
	"
	^self findLast: [ :char | char isPathSeparator ]! !

!String methodsFor: 'fileman-accessing' stamp: 'mu 5/7/2007 15:55'!
pathAndLocalName
	| index path localName |
	index := self indexOfLastPathSeparator.
	index = 0 ifTrue: [^{''. self}].

	path := self copyFrom: 1 to: index-1.
	localName := self copyFrom: index+1 to: self size.

	^{path. localName}

	! !

!String methodsFor: 'fileman-accessing' stamp: 'mu 3/4/2007 10:45'!
upToFirstPathSeparator
	| index |
	self ifEmpty: [^self].
	index := self indexOfFirstPathSeparator.
	index = 0 ifTrue: [^self].
	^self copyFrom: 1 to: index - 1
	! !

!String methodsFor: 'fileman-accessing' stamp: 'mu 5/7/2007 15:49'!
upToLastPathSeparator
	| index |
	self ifEmpty: [^self].
	index := self indexOfLastPathSeparator.
	index = 0 ifTrue: [^self].
	^self copyFrom: 1 to: index - 1
	! !


!String methodsFor: 'text conversion emphasis' stamp: 'len 6/3/2019 10:24:00'!
bold
	"Stuff like
	('X' italic, '2' super, ' + ', 'H' bold, 'ij' sub, ' + ', 'lim' italic under, 'z  Å' sub, '(1 / z)' ) edit
	"
	^self asText bold! !

!String methodsFor: 'text conversion emphasis' stamp: 'len 6/3/2019 10:24:16'!
italic
	"Stuff like
	('X' italic, '2' super, ' + ', 'H' bold, 'ij' sub, ' + ', 'lim' italic under, 'z  Å' sub, '(1 / z)' ) edit
	"
	^self asText italic! !

!String methodsFor: 'text conversion emphasis' stamp: 'jmv 9/3/2019 10:17:21'!
pointSize: pointSize
	"Stuff like
	('Hello World' pointSize: 22) edit
	"
	^self asText pointSize: pointSize! !

!String methodsFor: 'text conversion emphasis' stamp: 'len 6/6/2016 02:14'!
struck
	^self asText struck! !

!String methodsFor: 'text conversion emphasis' stamp: 'len 6/3/2019 10:24:18'!
sub
	"Stuff like
	('X' italic, '2' super, ' + ', 'H' bold, 'ij' sub, ' + ', 'lim' italic under, 'z  Å' sub, '(1 / z)' ) edit
	"
	^self asText sub! !

!String methodsFor: 'text conversion emphasis' stamp: 'len 6/3/2019 10:24:20'!
super
	"Stuff like
	('X' italic, '2' super, ' + ', 'H' bold, 'ij' sub, ' + ', 'lim' italic under, 'z  Å' sub, '(1 / z)' ) edit
	"
	^self asText super! !

!String methodsFor: 'text conversion emphasis' stamp: 'len 6/3/2019 10:24:24'!
under
	"Stuff like
	('X' italic, '2' super, ' + ', 'H' bold, 'ij' sub, ' + ', 'lim' italic under, 'z  Å' sub, '(1 / z)' ) edit
	"
	^self asText under! !


!String methodsFor: 'text conversion attributes' stamp: 'jmv 9/3/2019 10:08:21'!
centered
	"Stuff like
	('Hello world' centered ) edit
	"
	^self asText centered! !

!String methodsFor: 'text conversion attributes' stamp: 'jmv 9/3/2019 10:08:52'!
justified
	"Stuff like
	('Hello world' justified ) edit
	"
	^self asText justified! !

!String methodsFor: 'text conversion attributes' stamp: 'jmv 9/3/2019 10:09:50'!
leftFlush
	"Stuff like
	('Hello world' leftFlush ) edit
	"
	^self asText leftFlush! !

!String methodsFor: 'text conversion attributes' stamp: 'jmv 9/3/2019 10:10:05'!
rightFlush
	"Stuff like
	('Hello world' rightFlush ) edit
	"
	^self asText rightFlush! !


!String methodsFor: 'text conversion color' stamp: 'jmv 9/3/2019 10:29:49'!
black
	"Stuff like
	'Hello world' black edit
	"
	^self asText black! !

!String methodsFor: 'text conversion color' stamp: 'jmv 9/3/2019 10:29:58'!
blue
	"Stuff like
	'Hello world' blue edit
	"
	^self asText blue! !

!String methodsFor: 'text conversion color' stamp: 'jmv 9/3/2019 10:30:04'!
cyan
	"Stuff like
	'Hello world' cyan edit
	"
	^self asText cyan! !

!String methodsFor: 'text conversion color' stamp: 'jmv 9/3/2019 10:30:11'!
gray
	"Stuff like
	'Hello world' gray edit
	"
	^self asText gray! !

!String methodsFor: 'text conversion color' stamp: 'jmv 9/3/2019 10:30:19'!
green
	"Stuff like
	'Hello world' green edit
	"
	^self asText green! !

!String methodsFor: 'text conversion color' stamp: 'jmv 9/3/2019 10:31:04'!
magenta
	"Stuff like
	'Hello world' magenta edit
	"
	^self asText magenta! !

!String methodsFor: 'text conversion color' stamp: 'jmv 9/3/2019 10:31:17'!
red
	"Stuff like
	'Hello world' red edit
	"
	^self asText red! !

!String methodsFor: 'text conversion color' stamp: 'jmv 9/3/2019 10:31:27'!
yellow
	"Stuff like
	'Hello world' yellow edit
	"
	^self asText yellow! !


!String methodsFor: 'grammar' stamp: 'LC 7/5/2020 16:47:58'!
article
	| article first letter second |
	self isEmpty ifTrue: [^self].
	article := self first isVowel ifTrue: ['an'] ifFalse: ['a'].
	first := self first asLowercase.
	letter := self size = 1.
	second := letter ifFalse: [self second asLowercase].
	(first = $f and: [letter orNot: ['aeiloru' includes: second]])
		ifTrue: [^'an'].
	first = $u ifTrue: [
		(letter or: ['cks' includes: second]) ifTrue: [^'a'].
		second = $n
			ifTrue: [(self size = 2 or: [self third isVowel]) ifTrue: [^'a']]].
	(first = $e and: [second = $u]) ifTrue: [^'a'].
	^article! !

!String methodsFor: 'grammar' stamp: 'LC 4/25/2020 10:29:48'!
asPlural
	| k trimmed plural n |
	k := self findFirst: [:ch | ch isSeparator not].
	k > 1
		ifTrue: [^(self copyFrom: 1 to: k - 1) , (self allButFirst: k - 1) asPlural].
	trimmed := self withBlanksTrimmed.
	trimmed isEmpty ifTrue: [^''].
	plural := trimmed asLowercase lowercasePlural.
	n := trimmed size min: plural size.
	1 to: n do: [:i |
		(trimmed at: i) isUppercase
			ifTrue: [plural at: i put: (plural at: i) asUppercase]].
	^plural! !

!String methodsFor: 'grammar' stamp: 'LC 6/19/2020 12:52:49'!
exceptionalPlural
	| singular plural index |
	singular := #(
		'addendum' 'aircraft' 'alga' 'alumna' 'alumnus' 'amoeba' 'antenna' 'appendix' 'automaton'
		'bacillus' 'bacterium' 'barracks'
		'cactus' 'calculus' 'child' 'cicatrix' 'colossus' 'corpus' 'corrigendum' 'criterion' 'curriculum'
		'datum' 'deer' 'desideratum' 'dwarf'
		'echo' 'embargo' 'ephemeris' 'erratum' 'extremum'
		'fish' 'focus' 'foot' 'forum' 'fungus'
		'gallows' 'genus' 'goose'
		'hero'
		'index' 'infimum' 'is'
		'lacuna' 'larva' 'louse'
		'matrix' 'maximum' 'means' 'memorandum' 'minimum' 'mythos' 'money' 'mouse'
		'nucleus'
		'offspring' 'optimum' 'opus' 'ox'
		'person' 'phenomenon' 'phylum' 'potato' 'proof'
		'quantum'
		'roof'
		'series' 'sheep' 'species' 'spoof' 'stimulus' 'stratum' 'syllabus'
		'tomato' 'tooth' 'torpedo' 'trilby'
		'vertebra' 'vertex' 'veto'
		'was').
	plural := #(
		'addenda' 'aircraft' 'algae' 'alumnae' 'alumni' 'amoebae' 'antennae' 'appendices' 'automata'
		'bacilli' 'bacteria' 'barracks'
		'cacti' 'calculi' 'children' 'cicatrices' 'colossi' 'corpora' 'corrigenda' 'criteria' 'curricula'
		'data' 'deer' 'desiderata' 'dwarfs'
		'echoes' 'embargoes' 'ephemerides' 'errata' 'extrema'
		'fish' 'foci' 'feet' 'fora' 'fungi'
		'gallows' 'genera' 'geese'
		'heroes'
		'indices' 'infima' 'are'
		'lacunae' 'larvae' 'lice'
		'matrices' 'maxima' 'means' 'memoranda' 'minima' 'mythoi' 'moneys' 'mice'
		'nuclei'
		'offspring' 'optima' 'opera' 'oxen'
		'people' 'phenomena' 'phyla' 'potatoes' 'proofs'
		'quanta'
		'roofs'
		'series' 'sheep' 'species' 'spoofs' 'stimuli' 'strata' 'syllabi'
		'tomatoes' 'teeth' 'torpedoes' 'trilbys'
		'vertebrae' 'vertices' 'vetoes'
		'were').
	index := singular indexOf: self.
	^index > 0 ifTrue: [plural at: index]! !

!String methodsFor: 'grammar' stamp: 'LC 4/25/2020 10:25:45'!
isUninflictedNoun
	| nouns |
	nouns := #(
		'bison' 'bream' 'breeches' 'britches'
		'carp' 'chassis' 'clippers' 'cod' 'contretemps' 'corps'
		'debris' 'diabetes' 'djinn'
		'eland' 'elk'
		'flounder'
		'gallows' 'graffiti'
		'headquarters' 'herpes' 'high-jinks' 'homework'
		'innings'
		'jackanapes'
		'mackerel' 'measles' 'mews' 'mumps'
		'news'
		'pincers' 'pliers' 'proceedings'
		'rabies'
		'salmon' 'scissors' 'sea-bass' 'series' 'shears' 'species' 'swine'
		'trout' 'tuna'
		'whiting' 'wildebeest').
	^nouns includes: self! !

!String methodsFor: 'grammar' stamp: 'LC 4/25/2020 10:24:38'!
lowercasePlural
	| last |
	self exceptionalPlural ifNotNil: [:pl | ^pl].
	self isUninflictedNoun ifTrue: [^self].
	last := self last.
	last = $y ifTrue: [
		#('ay' 'ey' 'oy' 'uy') do: [:t |
			(self endsWith: t) ifTrue: [^self , 's'].
			^self allButLast , 'ies']].
	#('zz' 'ch' 'sh') do: [:t | (self endsWith: t) ifTrue: [^self , 'es']].
	last = $s ifTrue: [
		self = 'its' ifTrue: [^'their'].
		#('bs' 'cs' 'ds' 'ks' 'ls' 'ms' 'rs' 'ts' 'ws')
			do: [:t | (self endsWith: t) ifTrue: [^self]].
		#('sis' 'xis')
			do: [:t | (self endsWith: t) ifTrue: [^(self allButLast: 2) , 'es']]].
	last = $z ifTrue: [^self , 'zes'].
	(last = $x or: [last = $s]) ifTrue: [^self , 'es'].
	(self endsWith: 'man') ifTrue: [^(self allButLast: 2) , 'en'].
	last = $f ifTrue: [^self allButLast , 'ves'].
	(self endsWith: 'fe') ifTrue: [^(self allButLast: 2) , 'ves'].
	^self , 's'! !

!String methodsFor: 'grammar' stamp: 'LC 4/25/2020 10:26:19'!
pluralize: aBoolean
	^aBoolean ifTrue: [self asPlural] ifFalse: [self]! !

!String methodsFor: 'grammar' stamp: 'LC 4/25/2020 10:45:49'!
withArticle
	^self article , ' ' , self! !


!String methodsFor: '*Portfolio2' stamp: 'EMI 11/16/2020 16:17:50'!
identByAmount: anAmount
	^(String new: anAmount withAll: Character space), self.! !


!String methodsFor: '*Cuis-University-Model' stamp: 'HAW 10/8/2019 15:40:22'!
asInstanceVariableName
	
	self hasAnPrefix ifTrue: [ ^self asInstanceVariableNameWithoutAnPrefix ].
	self hasAPrefix ifTrue: [ ^self asInstanceVariableNameWithoutAPrefix ].
	
	^self asInstanceVariableNameUncapitilized 
	! !

!String methodsFor: '*Cuis-University-Model' stamp: 'HAW 10/8/2019 15:42:10'!
asInstanceVariableNameUncapitilized 

	| instVarName |
	
	instVarName := self uncapitalized.
	^self = instVarName 
		ifTrue: [ instVarName, '_CHANGE_ME' ]
		ifFalse: [ instVarName ]! !

!String methodsFor: '*Cuis-University-Model' stamp: 'HAW 10/8/2019 15:25:13'!
asInstanceVariableNameWithoutAPrefix
	
	^self allButFirst uncapitalized ! !

!String methodsFor: '*Cuis-University-Model' stamp: 'HAW 10/8/2019 15:26:43'!
asInstanceVariableNameWithoutAnPrefix
	
	^(self allButFirst: 2) uncapitalized ! !

!String methodsFor: '*Cuis-University-Model' stamp: 'HAW 10/8/2019 15:23:38'!
hasAPrefix
	
	^(self beginsWith: 'a') and: [ self size > 1 and: [ self second isUppercase ]]! !

!String methodsFor: '*Cuis-University-Model' stamp: 'HAW 10/8/2019 15:22:54'!
hasAnPrefix
	
	^(self beginsWith: 'an') and: [ self size > 2 and: [ self third isUppercase ]]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'String class' category: #'Kernel-Text'!
String class
	instanceVariableNames: ''!

!String class methodsFor: 'instance creation' stamp: 'jmv 9/4/2016 13:11:06'!
addUnicodeCodePoint: codePoint to: strm hex: useHexForNCRs
	"Convert the given Unicode codePoint to  the internal encoding: ISO Latin 9 (ISO 8859-15)"
	"For unicode chars not in ISO Latin 9 (ISO 8859-15), embed Decimal NCRs or Hexadecimal NCRs according to useHex.
	
	See http://en.wikipedia.org/wiki/Numeric_character_reference
	See http://rishida.net/tools/conversion/. Tests prepared there.
	
	Note: The conversion of NCRs is reversible. See #asUtf8:
	This allows handling the full Unicode in Cuis tools, that can only display the Latin alphabet, by editing the NCRs.
	The conversions can be done when reading / saving files, or when pasting from Clipboard and storing back on it."

	(Character codePoint: codePoint)
		ifNotNil: [ :char | strm nextPut: char]
		ifNil: [
			useHexForNCRs
				ifTrue: [
					strm nextPutAll: '&#x'.
					codePoint printOn: strm base: 16 length: 4 padded: true.
					strm nextPut: $; ]
				ifFalse: [
					strm nextPutAll: '&#'.
					codePoint printOn: strm base: 10.
					strm nextPut: $; ]]! !

!String class methodsFor: 'instance creation' stamp: 'jmv 8/28/2013 10:27'!
crString
	"Answer a string containing a single carriage return character."

	^ self with: Character cr! !

!String class methodsFor: 'instance creation' stamp: 'jmv 8/28/2013 10:27'!
crlfString
	"Answer a string containing a carriage return and a linefeed."

	^ self with: Character cr with: Character lf
! !

!String class methodsFor: 'instance creation' stamp: 'di 1/14/98 10:26'!
fromString: aString 
	"Answer an instance of me that is a copy of the argument, aString."
	
	^ aString copyFrom: 1 to: aString size! !

!String class methodsFor: 'instance creation' stamp: 'jmv 2/14/2013 14:29'!
fromUtf8: aByteArray
	"Convert the given bytes from UTF-8 to  the internal encoding: ISO Latin 9 (ISO 8859-15).
	See #asUtf8 "
	"For any unicode chars not in ISO Latin 9 (ISO 8859-15), embed an NCR.
	See http://en.wikipedia.org/wiki/Numeric_character_reference"

	^self fromUtf8: aByteArray hex: false trimLastNull: false! !

!String class methodsFor: 'instance creation' stamp: 'jmv 8/28/2013 12:09'!
fromUtf8: aByteArray hex: useHexForNCRs trimLastNull: doTrimLastNullChar
	"Convert the given string from UTF-8 to  the internal encoding: ISO Latin 9 (ISO 8859-15)"
	"For unicode chars not in ISO Latin 9 (ISO 8859-15), embed Decimal NCRs or Hexadecimal NCRs according to useHex.
	
	See http://en.wikipedia.org/wiki/Numeric_character_reference
	See http://rishida.net/tools/conversion/. Tests prepared there.
	
	Note: The conversion of NCRs is reversible. See #asUtf8:
	This allows handling the full Unicode in Cuis tools, that can only display the Latin alphabet, by editing the NCRs.
	The conversions can be done when reading / saving files, or when pasting from Clipboard and storing back on it."

	^String streamContents: [ :strm | | bytes codePoint |
		bytes _ aByteArray readStream.
		[ bytes atEnd ] whileFalse: [
			codePoint _ (Character nextUnicodeCodePointFromUtf8: bytes).
			codePoint ifNotNil: [
				"Add just one char if possible, or the apropriate sequence for the NCR"
				self addUnicodeCodePoint: codePoint to: strm hex: useHexForNCRs ]].
			(doTrimLastNullChar and: [ codePoint = 0 ]) ifTrue: [
				strm position: strm position - 1 ]]! !

!String class methodsFor: 'instance creation' stamp: 'jmv 8/28/2013 10:28'!
lfString
	"Answer a string containing a single Lf character."

	^ self with: Character lf! !

!String class methodsFor: 'instance creation' stamp: 'jmv 3/14/2012 08:33'!
newLineString
	"Answer a string containing a single newLine (i.e. Lf) character."

	^ self with: Character newLineCharacter! !

!String class methodsFor: 'instance creation'!
readFrom: inStream
	"Answer an instance of me that is determined by reading the stream, 
	inStream. Embedded double quotes become the quote Character."

	| outStream char done |
	outStream _ WriteStream on: (String new: 16).
	"go to first quote"
	inStream skipTo: $'.
	done _ false.
	[done or: [inStream atEnd]]
		whileFalse: 
			[char _ inStream next.
			char = $'
				ifTrue: 
					[char _ inStream next.
					char = $'
						ifTrue: [outStream nextPut: char]
						ifFalse: [done _ true]]
				ifFalse: [outStream nextPut: char]].
	^outStream contents! !

!String class methodsFor: 'instance creation' stamp: 'sw 6/15/1999 22:59'!
tab
	"Answer a string containing a single tab character."

	^ self with: Character tab
! !

!String class methodsFor: 'instance creation' stamp: 'jmv 3/31/2020 16:22:54'!
utf32FromUtf8: aByteArray
	"Convert the given string from UTF-8 to UTF-32"

	^IntegerArray streamContents: [ :strm | | bytes codePoint |
		bytes _ aByteArray readStream.
		[ bytes atEnd ] whileFalse: [
			codePoint _ (Character nextUnicodeCodePointFromUtf8: bytes).
			codePoint ifNotNil: [
				strm nextPut: codePoint ]]]! !

!String class methodsFor: 'instance creation' stamp: 'jmv 3/31/2020 16:25:01'!
utf8FromUtf32: anIntegerArray
	"Convert the given string from UTF-8 to UTF-32"

	^ByteArray streamContents: [ :strm |
		anIntegerArray do: [ :codePoint |
			Character
				evaluate: [ :byte | strm nextPut: byte ]
				withUtf8BytesOfUnicodeCodePoint: codePoint ]]! !


!String class methodsFor: 'initialization' stamp: 'len 5/13/2019 13:50:16'!
initialize
	"
	String initialize
	"

	| order newOrder lowercase |
	"Case insensitive compare sorts null, space, digits, letters, all the rest..."
	newOrder _ Array new: 256.
	order _ -1.
	newOrder at: 0+1 put:  (order _ order+1).
	32 to: 64 do: [ :c |
		newOrder at: c + 1 put: (order _ order+1)].
	#(92 94 124 126 183 215 247) do: [ :c | "\^|~∑˜◊"
		newOrder at: c + 1 put: (order _ order+1)].
	16r90 to: 16r9F do: [:c| "special math operators"
		newOrder at: c + 1 put: (order _ order+1)].
	Character uppercaseLowercaseAndUnaccentedLetters do: [ :upperAndLowercase |
		order _ order+1.
		newOrder at: upperAndLowercase first numericValue + 1 put: order.
		upperAndLowercase size > 1 ifTrue: [
			newOrder at: upperAndLowercase second numericValue + 1 put: order ]].
	1 to: newOrder size do: [ :i |
		(newOrder at: i) ifNil: [
			newOrder at: i put: (order _ order+1)]].
	CaseInsensitiveOrder _ newOrder asByteArray.
	
	"Case sensitive compare sorts null, space, digits, letters, all the rest..."
	newOrder _ Array new: 256.
	order _ -1.
	newOrder at: 0+1 put:  (order _ order+1).
	32 to: 64 do: [ :c |
		newOrder at: c + 1 put: (order _ order+1)].
	#(92 94 124 126 183 215 247) do: [ :c | "\^|~∑˜◊"
		newOrder at: c + 1 put: (order _ order+1)].
	16r90 to: 16r9F do: [:c| "special math operators"
		newOrder at: c + 1 put: (order _ order+1)].
	Character uppercaseLowercaseAndUnaccentedLetters do: [ :upperAndLowercase |
		upperAndLowercase size > 1 ifTrue: [
			newOrder at: upperAndLowercase first numericValue + 1 put: (order _ order+1) ]].
	Character uppercaseLowercaseAndUnaccentedLetters do: [ :upperAndLowercase |
		lowercase _ upperAndLowercase size = 1
			ifTrue: [ upperAndLowercase first ]
			ifFalse: [ upperAndLowercase second ].
		newOrder at: lowercase numericValue + 1 put: (order _ order+1) ].
	1 to: newOrder size do: [ :i |
		(newOrder at: i) ifNil: [
			newOrder at: i put: (order _ order+1)]].
	order = 255 ifFalse: [self error: 'order problem'].
	CaseSensitiveOrder _ newOrder asByteArray.

	"a table for translating to lower case"
	LowercasingTable _ String withAll: (Character characterTable collect: [:c | c asLowercase]).

	"a table for translating to upper case"
	UppercasingTable _ String withAll: (Character characterTable collect: [:c | c asUppercase]).

	"a table for testing tokenish (for fast numArgs)"
	Tokenish _ String withAll: (Character characterTable collect:
									[:c | c tokenish ifTrue: [c] ifFalse: [$~]]).

	"CR and LF--characters that terminate a line"
	CSLineEnders _ CharacterSet new.
	CSLineEnders add: Character cr.
	CSLineEnders add: Character lf.

 	"separators and non-separators"
	CSSeparators _ CharacterSet separators.
	CSNonSeparators _ CSSeparators complement! !


!String class methodsFor: 'primitives' stamp: 'jmv 9/5/2016 17:15:52'!
findFirstInString: aString  inSet: inclusionMap  startingAt: start
	| i stringSize |
	<primitive: 'primitiveFindFirstInString' module: 'MiscPrimitivePlugin'>
	self var: #aString declareC: 'unsigned char *aString'.
	self var: #inclusionMap  declareC: 'char *inclusionMap'.

	inclusionMap size ~= 256 ifTrue: [ ^0 ].

	i _ start.
	stringSize _ aString size.
	[ i <= stringSize and: [ (inclusionMap at: (aString at: i) numericValue+1) = 0 ] ] whileTrue: [ 
		i _ i + 1 ].

	i > stringSize ifTrue: [ ^0 ].
	^i! !

!String class methodsFor: 'primitives' stamp: 'jmv 4/18/2018 17:21:32'!
indexOfByte: anInteger inString: aString startingAt: start

	| stringSize |
	<primitive: 'primitiveIndexOfAsciiInString' module: 'MiscPrimitivePlugin'>

	self var: #aCharacter declareC: 'int anInteger'.
	self var: #aString declareC: 'unsigned char *aString'.

	start > 0 ifFalse: [ ^ 0 ].
	stringSize _ aString size.
	start to: stringSize do: [:pos |
		(aString at: pos) asciiValue = anInteger ifTrue: [^ pos]].
	^ 0
! !

!String class methodsFor: 'primitives' stamp: 'jmv 9/5/2016 17:16:54'!
stringHash: aString initialHash: speciesHash

	| stringSize hash low |
	<primitive: 'primitiveStringHash' module: 'MiscPrimitivePlugin'>

	self var: #aHash declareC: 'int speciesHash'.
	self var: #aString declareC: 'unsigned char *aString'.

	stringSize _ aString size.
	hash _ speciesHash bitAnd: 16rFFFFFFF.
	1 to: stringSize do: [:pos |
		hash _ hash + (aString at: pos) numericValue.
		"Begin hashMultiply"
		low _ hash bitAnd: 16383.
		hash _ (16r260D * low + ((16r260D * (hash bitShift: -14) + (16r0065 * low) bitAnd: 16383) * 16384)) bitAnd: 16r0FFFFFFF.
	].
	^ hash! !

!String class methodsFor: 'primitives' stamp: 'jmv 9/5/2016 17:16:57'!
translate: aString from: start  to: stop  table: table
	"translate the characters in the string by the given table, in place"
	<primitive: 'primitiveTranslateStringWithTable' module: 'MiscPrimitivePlugin'>
	self var: #table  declareC: 'unsigned char *table'.
	self var: #aString  declareC: 'unsigned char *aString'.

	start to: stop do: [ :i |
		aString at: i put: (table at: (aString at: i) numericValue+1) ]! !


!String class methodsFor: 'character collation' stamp: 'jmv 9/5/2016 17:15:31'!
does: aCharacter caseInsensitiveCollateBefore: otherCharacter
	"
	String does: $a caseInsensitiveCollateBefore: $b
	String does: $a caseInsensitiveCollateBefore: $B
	String does: $A caseInsensitiveCollateBefore: $b
	"
	^ (CaseInsensitiveOrder at: aCharacter numericValue + 1) < (CaseInsensitiveOrder at: otherCharacter numericValue + 1)! !

!String class methodsFor: 'character collation' stamp: 'jmv 9/5/2016 17:15:39'!
does: aCharacter collateAfter: otherCharacter
	^ (CaseSensitiveOrder at: aCharacter numericValue + 1) > (CaseSensitiveOrder at: otherCharacter numericValue + 1)! !

!String class methodsFor: 'character collation' stamp: 'jmv 9/5/2016 17:15:44'!
does: aCharacter collateBefore: otherCharacter
	^ (CaseSensitiveOrder at: aCharacter numericValue + 1) < (CaseSensitiveOrder at: otherCharacter numericValue + 1)! !


!String class methodsFor: 'fileman-constants' stamp: 'jmv 6/6/2015 23:54'!
pathSeparators
	^'\:/'! !


!classDefinition: #Symbol category: #'Kernel-Text'!
String variableByteSubclass: #Symbol
	instanceVariableNames: ''
	classVariableNames: 'NewSymbols OneCharacterSymbols SymbolTable'
	poolDictionaries: ''
	category: 'Kernel-Text'!
!Symbol commentStamp: '<historical>' prior: 0!
I represent Strings that are created uniquely. Thus, someString asSymbol == someString asSymbol.!


!Symbol methodsFor: 'accessing'!
at: anInteger put: anObject 
	"You cannot modify the receiver."

	self errorNoModification! !

!Symbol methodsFor: 'accessing' stamp: 'jmv 12/14/2018 15:41:59'!
precedence
	"Answer the receiver's precedence, assuming it is a valid Smalltalk
	message selector or 0 otherwise.  The numbers are 1 for unary,
	2 for binary and 3 for keyword selectors."

	| c |
	self size = 0 ifTrue: [^ 0].
	"Consider selectors starting with an underscore $_ as unary, even if Preferences allowUnderscoreSelectors is not set."
	c _ self first.
	c isValidInBinarySelectors ifTrue: [^ 2].
	self last = $: ifTrue: [^ 3].
	^ 1! !

!Symbol methodsFor: 'accessing'!
replaceFrom: start to: stop with: replacement startingAt: repStart

	self errorNoModification! !


!Symbol methodsFor: 'comparing' stamp: 'jmv 12/28/2011 19:23'!
= another

	"Use == between two symbols..."
	self == another ifTrue: [
		^ true].  "Was == "
	another class == Symbol ifTrue: [
		^ false].  "Was not == "

	"Otherwise use string =..."
	^ super = another! !


!Symbol methodsFor: 'copying'!
shallowCopy
	"Answer with the receiver, because Symbols are unique."! !


!Symbol methodsFor: 'converting'!
asString 
	"Refer to the comment in String|asString."

	| newString |
	newString _ String new: self size.
	1 to: self size do: [:index | newString at: index put: (self at: index)].
	^newString! !

!Symbol methodsFor: 'converting'!
asSymbol 
	"Refer to the comment in String|asSymbol."! !

!Symbol methodsFor: 'converting' stamp: 'sw 1/28/98 18:18'!
capitalized
	^ self asString capitalized asSymbol! !


!Symbol methodsFor: 'printing' stamp: 'jmv 3/13/2012 12:48'!
print
	Transcript show: self printString; newLine! !

!Symbol methodsFor: 'printing' stamp: 'jmv 5/20/2015 12:52'!
storeOn: aStream 

	aStream nextPut: $#.
	(Scanner isLiteralSymbol: self)
		ifTrue: [aStream nextPutAll: self]
		ifFalse: [super storeOn: aStream]! !


!Symbol methodsFor: 'system primitives' stamp: 'di 1/2/1999 17:00'!
flushCache
	"Tell the interpreter to remove all entries with this symbol as a selector from its method lookup cache, if it has one.  This primitive must be called whenever a method is defined or removed.
	NOTE:  Only one of the two selective flush methods needs to be used.
	Squeak 2.3 and later uses 116 (See CompiledMethod flushCache)."

	<primitive: 119>
! !

!Symbol methodsFor: 'system primitives' stamp: 'jmv 4/14/2015 15:15'!
numArgs: n
	"Answer a string that can be used as a selector with n arguments.
	 TODO: need to be extended to support shrinking and for selectors like #+ 
	
	Note: Unrelated, but remember that we inherit #numArgs " 

	| selector numArgs aStream offs |
	
	selector _ self.
	(numArgs _ selector numArgs) >= n ifTrue: [ ^self ].	
	aStream _ WriteStream on: (String new: 16).
	aStream nextPutAll: self.
	
	(numArgs = 0) ifTrue: [ aStream nextPutAll: ':'. offs _ 0 ] ifFalse: [offs _ 1].
	2 to: n - numArgs + offs do: [ :i | aStream nextPutAll: 'with:' ].	
	^aStream contents asSymbol! !


!Symbol methodsFor: 'private'!
errorNoModification

	self error: 'symbols can not be modified.'! !

!Symbol methodsFor: 'private'!
species

	^String! !

!Symbol methodsFor: 'private'!
string: aString

	1 to: aString size do: [:j | super at: j put: (aString at: j)].
	^self  ! !


!Symbol methodsFor: 'testing' stamp: 'KenD 4/30/2020 11:52:10'!
is: aSymbol
	"Answer false if I am not a Symbol.
	 ??Note: A Symbol is also a String; should we check for #String and answer false??"
	^#Symbol = aSymbol or: [ super is: aSymbol]! !

!Symbol methodsFor: 'testing' stamp: 'jmv 12/8/2008 15:45'!
isInfix
	"Answer whether the receiver is an infix message selector."

	^ self precedence = 2! !

!Symbol methodsFor: 'testing' stamp: 'jmv 6/13/2019 08:54:44'!
isInitializePvtSelector
	"Answer whether the receiver is a private instance initialization message selector, that is,
	begins with 'initializePvt' (followed or not by additional stuff, as a unary message, or as keyword with arguments)"

	^ self beginsWith: 'initializePvt'! !

!Symbol methodsFor: 'testing' stamp: 'jmv 3/1/2010 10:07'!
isKeyword
	"Answer whether the receiver is a message keyword."

	^ self precedence = 3! !

!Symbol methodsFor: 'testing' stamp: 'di 4/25/2000 12:32'!
isLiteral
	"Answer whether the receiver is a valid Smalltalk literal."

	^ true! !

!Symbol methodsFor: 'testing' stamp: 'sma 2/5/2000 12:13'!
isPvtSelector
	"Answer whether the receiver is a private message selector, that is,
	begins with 'pvt' followed by an uppercase letter, e.g. pvtStringhash."

	^ (self beginsWith: 'pvt') and: [self size >= 4 and: [(self at: 4) isUppercase]]! !

!Symbol methodsFor: 'testing' stamp: 'md 4/30/2003 15:31'!
isSymbol
	^ true ! !

!Symbol methodsFor: 'testing' stamp: 'jmv 12/8/2008 15:45'!
isUnary
	"Answer whether the receiver is an unary message selector."

	^ self precedence = 1! !

!Symbol methodsFor: 'testing' stamp: 'RNG 3/29/2020 19:56:14'!
isValidBinarySelector

	^ self isInfix and: [ self allSatisfy: [ :character | character isValidInBinarySelectors ] ]! !

!Symbol methodsFor: 'testing' stamp: 'RNG 3/29/2020 19:56:38'!
isValidKeywordSelector

	^ self isKeyword and: [ self keywords allSatisfy: [ :keywordString | keywordString allButLast asSymbol isValidSelector ] ]! !

!Symbol methodsFor: 'testing' stamp: 'RNG 3/29/2020 19:56:45'!
isValidSelector

	^ self isValidUnarySelector
		or: [ self isValidBinarySelector ]
		or: [ self isValidKeywordSelector ]! !

!Symbol methodsFor: 'testing' stamp: 'RNG 3/29/2020 19:56:03'!
isValidUnarySelector

	^ self isUnary and: [ self allSatisfy: [ :character | character isValidInIdentifiers ] ]! !


!Symbol methodsFor: 'uCompletion' stamp: 'jmv 11/1/2011 23:21'!
separateKeywords

	^self isKeyword
		ifFalse: [ self, ' ' ]
		ifTrue: [
			String streamContents: [ :strm |
				self keywords
					do: [ :keyword | strm nextPutAll: keyword ]
					separatedBy: [ strm space; space ].
				strm space]]! !


!Symbol methodsFor: '*DenotativeObject' stamp: 'HAW 8/22/2017 17:05:08'!
asMessage

	^self asMessageWithAll: #()! !

!Symbol methodsFor: '*DenotativeObject' stamp: 'HAW 9/7/2017 15:32:22'!
asMessageWith: aCollaborator

	^self asMessageWithAll: (Array with: aCollaborator)! !

!Symbol methodsFor: '*DenotativeObject' stamp: 'HAW 9/7/2017 15:32:30'!
asMessageWithAll: aCollaborators

	^Message selector: self arguments: aCollaborators ! !

!Symbol methodsFor: '*DenotativeObject' stamp: 'HAW 8/22/2017 17:06:29'!
sendTo: aReceiver

	^self asMessage sendTo: aReceiver ! !

!Symbol methodsFor: '*DenotativeObject' stamp: 'HAW 9/7/2017 15:32:35'!
sendTo: aReceiver with: aCollaborator

	^(self asMessageWith: aCollaborator) sendTo: aReceiver ! !

!Symbol methodsFor: '*DenotativeObject' stamp: 'HAW 9/7/2017 15:32:41'!
sendTo: aReceiver withAll: aCollaborators

	^(self asMessageWithAll: aCollaborators) sendTo: aReceiver ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Symbol class' category: #'Kernel-Text'!
Symbol class
	instanceVariableNames: ''!

!Symbol class methodsFor: 'access' stamp: 'jmv 12/30/2009 22:37'!
allSymbols
	"Answer all interned symbols"
	^Array streamContents:[:s|
		s nextPutAll: NewSymbols.
		s nextPutAll: OneCharacterSymbols.
		s nextPutAll: SymbolTable.
	]! !

!Symbol class methodsFor: 'access' stamp: 'dvf 10/17/2003 16:00'!
findInterned: aString

	self hasInterned: aString ifTrue: [:symbol | ^symbol].
	^nil.! !

!Symbol class methodsFor: 'access' stamp: 'jmv 3/6/2018 17:15:26'!
selectorsContaining: aString
	"Answer a list of selectors that contain aString within them. Case-insensitive.  Does return symbols that begin with a capital letter."

	| size selectorList ascii |

	selectorList _ OrderedCollection new.
	(size _ aString size) = 0 ifTrue: [^selectorList].

	aString size = 1 ifTrue:
		[
			ascii _ aString first numericValue.
			ascii < 128 ifTrue: [selectorList add: (OneCharacterSymbols at: ascii+1)]
		].

	aString first isValidInIdentifiers ifFalse:
		[
			aString size = 2 ifTrue: 
				[Symbol hasInterned: aString ifTrue:
					[:s | selectorList add: s]].
			^selectorList
		].

	selectorList _ selectorList copyFrom: 2 to: selectorList size.

	self allSymbolTablesDo: [:each |
		each size >= size ifTrue:
			[(each findSubstring: aString in: each startingAt: 1 
				matchTable: CaseInsensitiveOrder) > 0
						ifTrue: [selectorList add: each]]].

	^selectorList reject: [:each | "reject non-selectors, but keep ones that begin with an uppercase"
		each numArgs < 0 and: [each asString uncapitalized numArgs < 0]].

"Symbol selectorsContaining: 'scon'"! !

!Symbol class methodsFor: 'access' stamp: 'jmv 3/6/2018 17:15:29'!
selectorsMatching: aStringPattern
	"Answer a list of selectors that match aStringPattern within them. Case-insensitive.
	 Does return symbols that begin with a capital letter."

	| selectorList |

	selectorList := OrderedCollection new.

	aStringPattern isEmpty ifTrue: [^selectorList].

	self allSymbolTablesDo:
		[:each | (aStringPattern match: each) ifTrue: [selectorList add: each]].

	^selectorList reject: "reject non-selectors, but keep ones that begin with an uppercase"
		[:each | each numArgs < 0 and: [each asString uncapitalized numArgs < 0]]

	"Symbol selectorsMatching: 'parse:*'"! !

!Symbol class methodsFor: 'access' stamp: 'RAA 5/29/2001 14:35'!
thatStarts: leadingCharacters skipping: skipSym
	"Answer a selector symbol that starts with leadingCharacters.
	Symbols beginning with a lower-case letter handled directly here.
	Ignore case after first char.
	If skipSym is not nil, it is a previous answer; start searching after it.
	If no symbols are found, answer nil.
	Used by Alt-q (Command-q) routines"

	| size firstMatch key |

	size _ leadingCharacters size.
	size = 0 ifTrue: [^skipSym ifNil: [#''] ifNotNil: [nil]].

	firstMatch _ leadingCharacters at: 1.
	size > 1 ifTrue: [key _ leadingCharacters copyFrom: 2 to: size].

	self allSymbolTablesDo: [:each |
			each size >= size ifTrue:
				[
					((each at: 1) == firstMatch and:
						[key == nil or:
							[(each findString: key startingAt: 2 caseSensitive: false) = 2]])
								ifTrue: [^each]
				]
		] after: skipSym.

	^nil

"Symbol thatStarts: 'sf' skipping: nil"
"Symbol thatStarts: 'sf' skipping: #sfpGetFile:with:with:with:with:with:with:with:with:"
"Symbol thatStarts: 'candidate' skipping: nil"
! !

!Symbol class methodsFor: 'access' stamp: 'jmv 7/14/2011 14:37'!
thatStartsCaseSensitive: leadingCharacters
	"Same as thatStarts:skipping: but caseSensitive"
	"Note: Only answers symbols for which there is some implementor"
	| size firstMatch key |

	"Use optimized implementation if available,"
	Smalltalk at: #SmalltalkCompleter ifPresent: [ :cls | ^cls thatStartsCaseSensitive: leadingCharacters ].

	size := leadingCharacters size.
	size = 0 ifTrue: [^#''].
	firstMatch := leadingCharacters at: 1.
	size > 1 ifTrue: [ key _ leadingCharacters copyFrom: 2 to: size ].
	self allSymbolTablesDo: [ :each |
			each size >= size ifTrue: [
				((each at: 1) == firstMatch and: [
					key == nil or: [
						(each findString: key startingAt: 2 caseSensitive: true) = 2]])
							ifTrue: [
								(Smalltalk isThereAnImplementorOf: each) ifTrue: [
									^each]]]].
	^nil! !


!Symbol class methodsFor: 'class initialization' stamp: 'RAA 5/29/2001 08:21'!
allSymbolTablesDo: aBlock

	NewSymbols do: aBlock.
	SymbolTable do: aBlock.! !

!Symbol class methodsFor: 'class initialization' stamp: 'ul 9/12/2010 03:25'!
allSymbolTablesDo: aBlock after: aSymbol

	(NewSymbols includes: aSymbol) 
		ifTrue: [
			NewSymbols do: aBlock after: aSymbol.
			SymbolTable do: aBlock after: aSymbol ]
		ifFalse: [
			SymbolTable do: aBlock after: aSymbol.
			NewSymbols do: aBlock after: aSymbol ]
	! !

!Symbol class methodsFor: 'class initialization' stamp: 'RAA 12/17/2000 18:05'!
compactSymbolTable
	"Reduce the size of the symbol table so that it holds all existing symbols + 25% (changed from 1000 since sets like to have 25% free and the extra space would grow back in a hurry)"

	| oldSize |

	Smalltalk garbageCollect.
	oldSize _ SymbolTable array size.
	SymbolTable growTo: SymbolTable size * 4 // 3 + 100.
	^oldSize printString,'  ',(oldSize - SymbolTable array size) printString, ' slot(s) reclaimed'! !

!Symbol class methodsFor: 'class initialization' stamp: 'jmv 12/12/2014 16:54'!
initialize

	"
	Symbol initialize.
	SystemDictionary initialize.
	"
	Symbol rehash.
	OneCharacterSymbols _ nil.
	OneCharacterSymbols _ (1 to: 256) collect: [ :i | (i - 1) asCharacter asSymbol]! !


!Symbol class methodsFor: 'instance creation' stamp: 'HAW 3/4/2019 15:31:05'!
fromCollectionOfStrings: aCollectionOfStrings

	^self newFrom: aCollectionOfStrings concatenation ! !

!Symbol class methodsFor: 'instance creation' stamp: 'jmv 9/2/2013 09:05'!
intern: aStringOrSymbol

	^(self lookup: aStringOrSymbol)
		ifNil:
			[
				NewSymbols add:
					(aStringOrSymbol isSymbol
						ifTrue: [ aStringOrSymbol ]
						ifFalse: [ (self new: aStringOrSymbol size) string: aStringOrSymbol ])
			]! !

!Symbol class methodsFor: 'instance creation' stamp: 'jmv 9/5/2016 17:17:00'!
internCharacter: aCharacter

	OneCharacterSymbols ifNil: [^self intern: aCharacter asString].

	^OneCharacterSymbols at: aCharacter numericValue + 1
! !

!Symbol class methodsFor: 'instance creation' stamp: 'RAA 5/29/2001 08:09'!
lookup: aStringOrSymbol

	^(SymbolTable like: aStringOrSymbol) ifNil: [
		NewSymbols like: aStringOrSymbol
	]! !

!Symbol class methodsFor: 'instance creation'!
newFrom: aCollection 
	"Answer an instance of me containing the same elements as aCollection."

	^ (aCollection as: String) asSymbol

"	Symbol newFrom: {$P. $e. $n}
	{$P. $e. $n} as: Symbol
"! !

!Symbol class methodsFor: 'instance creation' stamp: 'jmv 8/15/2015 10:21'!
readFrom: strm
	"
	Symbol readFrom: '#abc' readStream
	"

	strm peek = $# ifFalse: [self error: 'Symbols must be introduced by #'].
	^ (Scanner new scan: strm) advance  "Just do what the code scanner does"! !


!Symbol class methodsFor: 'private' stamp: 'RAA 5/29/2001 08:01'!
rehash		"Symbol rehash"
	"Rebuild the hash table, reclaiming unreferenced Symbols."

	SymbolTable _ WeakSet withAll: self allInstances.
	NewSymbols _ WeakSet new.! !

!Symbol class methodsFor: 'private' stamp: 'jmv 12/12/2014 16:24'!
shutDown

	SymbolTable addAll: NewSymbols.
	NewSymbols _ WeakSet new! !


!Symbol class methodsFor: 'services' stamp: 'jmv 3/23/2011 17:44'!
hasInterned: aString and: oneArgBlock 
	"Answer with false if aString hasnt been interned (into a Symbol), 
	otherwise supply the symbol to symBlock and return the result of the evaluation."

	| symbol |

	^ (symbol _ self lookup: aString)
		ifNil: [ false ]
		ifNotNil: [ oneArgBlock value: symbol ]! !

!Symbol class methodsFor: 'services' stamp: 'jmv 3/23/2011 17:44'!
hasInterned: aString ifTrue: symBlock 
	"Answer with false if aString hasnt been interned (into a Symbol), 
	otherwise supply the symbol to symBlock and return true."

	| symbol |

	^(symbol _ self lookup: aString)
		ifNil: [false]
		ifNotNil: [symBlock value: symbol. true]! !

!Symbol class methodsFor: 'services' stamp: 'jmv 7/14/2011 14:37'!
hasInternedAndImplemented: aString
	"Answer with false if aString hasnt been interned (into a Symbol), 
	or if there are no implemetors of the selector."

	"Use optimized implementation if available,"
	Smalltalk at: #SmalltalkCompleter ifPresent: [ :cls | 
		^self hasInterned: aString and: [ :symbol | cls isThereAnImplementorOf: symbol ]].

	^self hasInterned: aString and: [ :symbol | Smalltalk isThereAnImplementorOf: symbol ]! !

!Symbol class methodsFor: 'services' stamp: 'jmv 3/23/2011 17:44'!
hasInternedAndImplementedOrReferenced: aString
	"Answer with false if aString hasnt been interned (into a Symbol), 
	or if there are no implemetors of the selector."

	^self hasInterned: aString and: [ :symbol |
		(Smalltalk isThereAnImplementorOf: symbol) or: [
			Smalltalk isThereAReferenceTo: symbol ]]! !

!Symbol class methodsFor: 'services' stamp: 'jmv 3/23/2011 17:44'!
possibleSelectorsFor: misspelled 
	"Answer an ordered collection of possible corrections
	for the misspelled selector in order of likelyhood"

	| numArgs candidates lookupString best binary short long first ss |
	lookupString _ misspelled asLowercase. "correct uppercase selectors to lowercase"
	numArgs _ lookupString numArgs.
	(numArgs < 0 or: [lookupString size < 2]) ifTrue: [^ OrderedCollection new: 0].
	first _ lookupString first.
	short _ lookupString size - (lookupString size // 4 max: 3) max: 2.
	long _ lookupString size + (lookupString size // 4 max: 3).

	"First assemble candidates for detailed scoring"
	candidates _ OrderedCollection new.
	self allSymbolTablesDo: [:s | (((ss _ s size) >= short	"not too short"
			and: [ss <= long			"not too long"
					or: [(s at: 1) = first]])	"well, any length OK if starts w/same letter"
			and: [s numArgs = numArgs])	"and numArgs is the same"
			ifTrue: [candidates add: s]].

	"Then further prune these by correctAgainst:"
	best _ lookupString correctAgainst: candidates.
	((misspelled last ~~ $:) and: [misspelled size > 1]) ifTrue: [
		binary _ misspelled, ':'.		"try for missing colon"
		Symbol hasInterned: binary ifTrue: [:him | best addFirst: him]].
	^ best! !

Character initialize!
String initialize!
Symbol initialize!