#!/usr/bin/perl
# perl script.pl

use strict;

open (FF, "CYTB/Lepidoptera.CYTB.fasta"); 


my @file = openfile();

#open file
#subroutines
sub openfile {
my $filename;
my $x;
    my $datafile;
    my $file;

for  ($x = 0; $x<5; $x++) {
print "\n\nPlease enter file name: ";
chomp ($filename = <STDIN>);

if (-e $filename) {
print "File found!\n\n";
    exit;
         } else {
        if ($x<4) {
        print "Invalid file name!\n\n";
        } else { 
                print "Five tries were unsuccessful! Please check and try again!\n\n";
                        }
                    }
                }
        return;
        }

my @fields;

while (my $line = <FF>) 
{
chomp $line;

#my @fields = split(/\t/, $line);

if ($line =~ />/) 
    {
    my @fields = split(/\|/, $line);
    print "@fields[0]\n";      
	
    }
else
	{
       print "$line\n";
	}



}

close FF;