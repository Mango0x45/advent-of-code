BEGIN			{ sx = sy = rx = ry = 1; homes[sx][sy] = 1; acc = 1 }
			{ santa = santa ? 0 : 1 }
santa == 0 && $0 == "^"	{ if (!homes[rx][++ry]++) acc++; next }
santa == 0 && $0 == ">"	{ if (!homes[++rx][ry]++) acc++; next }
santa == 0 && $0 == "v"	{ if (!homes[rx][--ry]++) acc++; next }
santa == 0 && $0 == "<"	{ if (!homes[--rx][ry]++) acc++; next }
santa == 1 && $0 == "^"	{ if (!homes[sx][++sy]++) acc++; next }
santa == 1 && $0 == ">"	{ if (!homes[++sx][sy]++) acc++; next }
santa == 1 && $0 == "v"	{ if (!homes[sx][--sy]++) acc++; next }
santa == 1 && $0 == "<"	{ if (!homes[--sx][sy]++) acc++; next }
END			{ print acc }
