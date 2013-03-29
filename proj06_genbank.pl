#!/usr/bin/perl 
# parse_genes.pl 
use strict; use warnings;

open(my $genbank, "<", $ARGV[0]);

my $genome;
my $line;
my @split_sequence = [];
my $joined_sequence;

while ($genbank = <>) { 
	chomp($genbank);
	if ($genbank =~ /^\s+\d+\s[acgtACGT]{10}/) {
		$line = substr($genbank, 10, length($genbank)-10); 
		@split_sequence = split(" ", $line);
		$joined_sequence = join("", @split_sequence);
		$genome = $genome . $joined_sequence;
	}
}

my $genome_length = length($genome);
my $printed_genome = substr($genome, 0, 200);
my $printed_end = substr($genome, length($genome) - 200, 200);
print "$printed_genome\n...\n$printed_end\n\nGenomic sequence is $genome_length base pairs long.\n";

close(genbank);

#open(my $genbank2, "<", $ARGV[0]);
#
#while (my $genbank2 = <>) { 
#	if ($genbank2 =~ /^\s{5}gene/) { 
#		my ($beg, $end) = $line =~ /(\d+)\.\.(\d+)/; 
#		$genbank2 = <>; 
#		my ($name) = $genbank2 =~ /="(.+)"/; 
#		print "$name $beg $end\n";
#
#		my $gene_seq = substr($genome, $beg - 1, $end - 1);
#		print "$gene_seq\n";		
#	} 
#}
