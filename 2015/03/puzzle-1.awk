BEGIN     { x = y = 1; homes[x][y] = 1; acc = 1 }
$0 == "^" { if (!homes[x][++y]++) acc++; next }
$0 == ">" { if (!homes[++x][y]++) acc++; next }
$0 == "v" { if (!homes[x][--y]++) acc++; next }
$0 == "<" { if (!homes[--x][y]++) acc++; next }
END       { print acc }
