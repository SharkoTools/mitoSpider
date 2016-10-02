#!/usr/bin/perl


use LWP::Simple;



$query = $ARGV[0];




#assemble the esearch URL
$base = 'http://eutils.ncbi.nlm.nih.gov/entrez/eutils/';
$url = $base . "esearch.fcgi?db=nucleotide&term=$query&usehistory=y";

#post the esearch URL


$output = get($url);

#parse WebEnv, QueryKey and Count (# records retrieved)
$web = $1 if ($output =~ /<WebEnv>(\S+)<\/WebEnv>/);
$key = $1 if ($output =~ /<QueryKey>(\d+)<\/QueryKey>/);
$count = $1 if ($output =~ /<Count>(\d+)<\/Count>/);


#open output file for writing
open(OUT, ">CYTB.fasta") || die "Can't open file!\n";

#retrieve data in batches of 500
$retmax = 500;
for ($retstart = 0; $retstart < $count; $retstart += $retmax) {
        $efetch_url = $base ."efetch.fcgi?db=nucleotide&WebEnv=$web";
        $efetch_url .= "&query_key=$key&retstart=$retstart";
        $efetch_url .= "&retmax=$retmax&rettype=ft&retmode=text";

        
        $efetch_out = get($efetch_url);
        print OUT "$efetch_out";
}




open(OUT, "CYTB.fasta") || die "Can't open file!\n";


my $found_flag = 0;

while (my $row = <OUT>) 
 {
  

    chomp $row;

my @field = split(/\t/, $row);

 if ((@field[4] eq "CYTB" || @field[4] eq "cytb" || @field[4] eq "cytB" || @field[4] eq "COB" || @field[4] eq "cob" || @field[4] eq "CytB" || @field[4] eq "Cytb" || @field[4] eq  "CTYB")  &&  @coord[0] != 0) 
	{

	my $cmd = "./GI.pl @coord[0] @coord[1] 1 $ARGV[0]";
	print "$cmd \n";
	system($cmd);
	$found_flag = 1;
	}
	

@coord = (@field[0], @field[1]);

}

if ($found_flag == 0)
	{
	print "$ARGV[0] Not found \n";
	}



close OUT;
