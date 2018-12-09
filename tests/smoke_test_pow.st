| low high exp sign |

low := (0 to: 3) , #(16r11111111  16r55555555 ) , #(16r1F 16r2E00 16r3D0000 16r4C000000 16r01234567 16rFEDCBA98  ).
low := (low , (low collect: [:e | e bitXor: 16rFFFFFFFF])) asSet sorted.

high := (0 to: 3) , #(16r11111  16r55555 ) , #(16r1F 16r2E0 16r3D00 16r4C000 16r1F2E3 16r5B6A7 ).
high := (high , (high collect: [:e | e bitXor: 16rFFFFF])) asSet sorted.

exp := #( 0 1 1023 2046) , ((0 to: 9) collect: [:e | 1<<e + 1023]) , ((0 to: 9) collect: [:e | 1023 - (1<<e)]).
exp := exp asSet sorted.

sign := #( 0 ).

FileDirectory default fileNamed: 'smoke_test_pow.txt' do: [:str |
sign do: [:sx | 
sign do: [:sy |
	exp do: [:ex | | sup inf |
		sup := (ex > 1022) ifTrue: [1023 / (ex - 1022) log: 2] ifFalse: [1023 / (1023 - ex) log: 2].
		inf := (ex > 1022) ifTrue: [ex - 1022 / 1023 log: 2] ifFalse: [1023 - ex / 1023 log: 2].
		high do: [:hx |
			low do: [:lx | | x |
				x := BoxedFloat64 basicNew: 2.
				x basicAt: 1 put: sx << 11 + ex << 20 + hx.
				x basicAt: 2 put: lx.
	[:exit | (((0 to: sup) collect: [:e | 1<<e + 1022 min: 2046]) , ((0 to: inf) collect: [:e | 1023 - (1<<e) max: 0])) asSet sorted do: [:ey | 
		high do: [:hy |
			low do: [:ly | | y z |
				y := BoxedFloat64 basicNew: 2.
				y basicAt: 1 put: sy << 11 + ey << 20 + hy.
				y basicAt: 2 put: ly.
				(x = 0 or: [y = 0]) ifFalse: [
				(x raisedTo: y) isFinite ifFalse: [exit value].
				z := ((x asArbitraryPrecisionFloatNumBits: 54*3) raisedTo: (y asArbitraryPrecisionFloatNumBits: 54*3)) asFloat.
				z isZero ifTrue: [exit value].
				z = 1 ifFalse: [
				str nextPutAll: '0x'.
				(x basicAt: 1) printOn: str base: 16 length: 8 padded: true.
				(x basicAt: 2) printOn: str base: 16 length: 8 padded: true. 
				str space.
				str nextPutAll: '0x'.
				(y basicAt: 1) printOn: str base: 16 length: 8 padded: true.
				(y basicAt: 2) printOn: str base: 16 length: 8 padded: true.
				str space.
				str nextPutAll: '0x'.
				(z basicAt: 1) printOn: str base: 16 length: 8 padded: true.
				(z basicAt: 2) printOn: str base: 16 length: 8 padded: true.
				str lf]]]]]] valueWithExit]]]]]].
