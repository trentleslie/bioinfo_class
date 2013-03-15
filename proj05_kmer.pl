#!/usr/bin/perl 
# kmer.pl
# adding " | sort -n -k 2" will numerically sort log-odds ratio output 
use strict; use warnings;

die "usage: perl kmer.pl <fasta file> <kmer length>\n" unless @ARGV == 2; 
open(IN, "<$ARGV[0]") or die "error reading $ARGV[0] for reading"; 
my $kmer = int($ARGV[1]);
my $current_intron;
my $intron_length;
my @name_fields = ();
my %count1 = ();
my %count2 = ();
my $total1 = 0;
my $total2 = 0;
my $frequency;
my %freq1 = ();
my %freq2 = ();

while (<IN>) {
	chomp; 
	if (substr($_, 0, 1) eq '>'){
		$current_intron = $_;
	}
	else {
		$intron_length = length($_);
		@name_fields = split("_", $current_intron);
		if ($name_fields[1] eq 'i1'){
			for (my $i = 0; $i <= length($_) - $kmer; $i++) { 
				my $codon = substr($_, $i, $kmer); 
				if (exists $count1{$codon}) {$count1{$codon}++} 
				else                        {$count1{$codon} = 1} 
				$total1++; 
			}
		}
		if ($name_fields[1] ne 'i1'){
                        for (my $i = 0; $i <= length($_) - $kmer; $i++) {
                                my $codon = substr($_, $i, $kmer);
                                if (exists $count2{$codon}) {$count2{$codon}++}
                                else                        {$count2{$codon} = 1}
                                $total2++;
			}
		}
	}
} 
close IN;

foreach my $codon (sort keys %count1) { 
	$frequency = $count1{$codon}/$total1;
	$freq1{$codon} = $frequency;
	printf "first introns - %s\t%d\t%.4f\n", $codon, $count1{$codon}, $frequency; 
}

foreach my $codon (sort keys %count2) {
        $frequency = $count2{$codon}/$total2;
	$freq2{$codon} = $frequency;
        printf "other introns - %s\t%d\t%.4f\n", $codon, $count2{$codon}, $frequency;
}

foreach my $codon (sort keys %freq1) {
	my $odds_ratio = $freq1{$codon} / $freq2{$codon};
	my $lod = log($odds_ratio);  # Perl’s log() function uses base e, so...
	my $lod2 = $lod / log(2);    # ...need to convert base e to base 2
	printf "%s %.3f\n", $codon, $lod2;
}
