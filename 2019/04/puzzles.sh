IFS=- read lo hi <input
seq $lo $hi |
	grep -E '([0-9])\1' |
	grep -E '^0*1*2*3*4*5*6*7*8*9*$' |
	# START PART 2
	grep -E '^(0{2}1*2*3*4*5*6*7*8*9*|0*1{2}2*3*4*5*6*7*8*9*|0*1*2{2}3*4*5*6*7*8*9*|0*1*2*3{2}4*5*6*7*8*9*|0*1*2*3*4{2}5*6*7*8*9*|0*1*2*3*4*5{2}6*7*8*9*|0*1*2*3*4*5*6{2}7*8*9*|0*1*2*3*4*5*6*7{2}8*9*|0*1*2*3*4*5*6*7*8{2}9*|0*1*2*3*4*5*6*7*8*9{2})$' |
	# END PART 2
	wc -l