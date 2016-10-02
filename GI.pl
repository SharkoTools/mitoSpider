#!/usr/bin/perl


use LWP::Simple;

$query = $ARGV[3];

my $start_seq   = $ARGV[0];
my $stop_seq = $ARGV[1];
my $strand_seq = $ARGV[2];

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
open(OUT, ">>CYTB-gene.fasta") || die "Can't open file!\n";

#retrieve data in batches of 500
$retmax = 500;
for ($retstart = 0; $retstart < $count; $retstart += $retmax) {
        $efetch_url = $base ."efetch.fcgi?db=nucleotide&WebEnv=$web";
        $efetch_url .= "&query_key=$key&retstart=$retstart";
        $efetch_url .= "&seq_start=".$start_seq."&seq_stop=".$stop_seq."&strand=".$strand_seq."";
        $efetch_url .= "&retmax=$retmax&rettype=fasta&retmode=text";

        
        $efetch_out = get($efetch_url);
	  print OUT ">$ARGV[3]|";
        print OUT "$efetch_out";
}

close OUT;

