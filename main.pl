#!/usr/bin/perl


open(OUT, "id.txt") || die "Can't open file!\n";



while (my $row = <OUT>) 
 {
      chomp $row;

	my $cmd = "./CYTB.pl $row";
	system($cmd);

}

close OUT;

