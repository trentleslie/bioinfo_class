#!/usr/bin/perl 
# dnashuffle.pl 
use strict; use warnings;

#kill program unless exactly 1 argument is provided
die "usage: perl dnashuffle.pl <DNA sequence>\n" unless @ARGV == 1;

my ($dna) = @ARGV; 
my @dna = split("", $dna);
my @dna2 = split("", $dna);
print "@dna\n";

my $seq_length = @dna;
print "The length of the sequence is $seq_length nucleotides.\n";

############
#STRATEGY 1#
############

#Randomize number of loops in for loop (some integer between 100 times
#the length of the sequence and 1000 times the length of the sequence).

my $range = 1000 * $seq_length;
my $minimum = 100 * $seq_length;
my $forloops = int(rand($range)) + $minimum;

print "The program will now randomly switch $forloops pairs of nucleotides.\n";

for (my $i = 0; $i < $forloops; $i++) {
      #get first random position
      my $temploca = int(rand($seq_length));

      #get second random position
      my $templocb = int(rand($seq_length));

      #store nucleotides in tempory variables to switch them
      my $tempnuca = $dna[$temploca];
      my $tempnucb = $dna[$templocb];
      $dna[$temploca] = $tempnucb;
      $dna[$templocb] = $tempnuca;

      #print out everything on first loop
      if ($i == 0){print "First strategy: Random location A is $temploca (nucleotide $tempnuca should now match $dna[$templocb]), random location B is $templocb (nucleotide $tempnucb should now match $dna[$temploca]).\n";}
}

my $dna = join("", @dna);
print "The new randomized sequence using the first strategy is $dna.\n";


##############
# STRATEGY 2 #
##############

#create empty array
my @newdna = ();    

#set up while loop to run while nucleotides are still in orginal array
while(@dna2 > 0){
    #get random location in original array and store nucleotide in temporary variable
    my $templocc = int(rand(@dna2));
    my $tempnucc = $dna2[$templocc];

    #remove random nucleotide from original array
    splice(@dna2, $templocc, 1);

    #add random nucleotide to new array
    push(@newdna, $tempnucc);

    #print out everything on first loop
    if ($seq_length - 1 == @dna2) {print "Second strategy: Random location is $templocc, random nucleotide is $tempnucc, first push is @newdna.\n";}
}

my $newdna = join("", @newdna);
print "The new randomized sequence using the second strategy is $newdna.\n";
