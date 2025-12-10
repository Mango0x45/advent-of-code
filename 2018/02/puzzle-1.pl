#!/usr/bin/perl

use strict;
use warnings;

my $file = "input";
open my $in, "<", $file or die "Failed to open ‘$file’: $!";

my ($x, $y) = (0) x 2;
while (<$in>) {
	chomp;
	my %freq;
	$freq{$_}++ for split //;
	$x++ if grep { $_ == 2 } values %freq;
	$y++ if grep { $_ == 3 } values %freq;
}

close $in;
printf "%d\n", $x * $y;
