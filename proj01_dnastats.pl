#!/usr/bin/perl 
# dnastats.pl by ___ 
use strict; use warnings;

#kills program unless exactly 1 argument is given 
die "usage: dnastats.pl <dna sequence>\n" unless @ARGV == 1; 
my ($seq) = @ARGV; 

#converts lower case to upper case
$seq =~ tr/a-z/A-Z/;

#use the length() function on $seq to get length of sequence and print it
my $seq_length = length($seq);
print "This sequence is $seq_length nucleotides long.\n";

#count and print total number of A, C, G, and T nucleotides

my $a_count = ($seq =~ tr/A/A/);
print "The letter A occurs $a_count times in $seq\n";

my $c_count = ($seq =~ tr/C/C/);
print "The letter C occurs $c_count times in $seq\n";

my $g_count = ($seq =~ tr/G/G/);
print "The letter G occurs $g_count times in $seq\n";

my $t_count = ($seq =~ tr/T/T/);
print "The letter T occurs $t_count times in $seq\n";

#as an alternative to using the length() function, you can add up the individual
#nucleotide counts to get the length of the sequence
#
#my $seq_length2 = $a_count + $c_count + $g_count + $t_count;
#print "Adding nucleotides gives a sequence length of $seq_length2 nucleotides.\n";

#compute and print fraction (percentages) of A, C, G, and T nucleotides

my $a_perc = $a_count / $seq_length * 100;
print "A nucleotides account for $a_perc\% of the sequence.\n";

my $c_perc = $c_count / $seq_length * 100;
print "C nucleotides account for $c_perc\% of the sequence.\n";

my $g_perc = $g_count / $seq_length * 100;
print "G nucleotides account for $g_perc\% of the sequence.\n";

my $t_perc = $t_count / $seq_length * 100;
print "T nucleotides account for $t_perc\% of the sequence.\n";

#comput and print GC fraction
#add $c_perc and $g_perc or add $c_length to $g_length and divide by $seq_length

my $gc_perc = (($g_count + $c_count) / $seq_length) * 100;
print "Adding nucleotides gives a GC fraction of $gc_perc\%.\n";

my $gc_perc2 = $g_perc + $c_perc;
print "Adding nucleotide percentages gives a GC fraction of $gc_perc2\%.\n";
