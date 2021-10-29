{ ids[NR] = $0 }

END {
	n = asort(ids)
	for (i = 1; i <= n; i++) {
		if ((i + 35) != ids[i]) {
			print i + 35
			exit
		}
	}
}
