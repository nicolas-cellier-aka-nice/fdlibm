| low high exp sign |

low := (0 to: 7) , #(16r11111111 16r33333333 16r55555555 16r66666666 16r54442D17 16r54442D18 16r54442D19) , #(16r1F 16r2E00 16r3D0000 16r4C000000 16r01234567 16rFEDCBA98 16r1F2E3D4C 16r5B6A7980 ).
low := (low , (low collect: [:e | e bitXor: 16rFFFFFFFF])) asSet sorted.

high := (0 to: 7) , #(16r11111 16r33333 16r55555 16r66666 16r921FB) , #(16r1F 16r2E0 16r3D00 16r4C000 16r12345 16rFEDCB 16r1F2E3 16r5B6A7 ).
high := (high , (high collect: [:e | e bitXor: 16rFFFFF])) asSet sorted.

exp := #( 0 1 1023 ) , ((0 to: 9) collect: [:e | 1<<e + 1023]) , ((0 to: 9) collect: [:e | 1023 - (1<<e)]).
exp := exp asSet sorted.

sign := #( 0).

FileDirectory default fileNamed: 'smoke_test_sin.txt' do: [:str |
sign do: [:s |
	exp do: [:e | 
		high do: [:h |
			low do: [:l | | x y |
				x := BoxedFloat64 basicNew: 2.
				x basicAt: 1 put: s << 11 + e << 20 + h.
				x basicAt: 2 put: l.
				x = 0.0 ifFalse: [
				y := (x*1.0 asArbitraryPrecisionFloatNumBits: 54*3) sin asFloat.
				str nextPutAll: '0x'.
				(x basicAt: 1) printOn: str base: 16 length: 8 padded: true.
				(x basicAt: 2) printOn: str base: 16 length: 8 padded: true. 
				str space.
				str nextPutAll: '0x'.
				(y basicAt: 1) printOn: str base: 16 length: 8 padded: true.
				(y basicAt: 2) printOn: str base: 16 length: 8 padded: true.
				str lf]]]]]].
