#!/usr/bin/perl 
# name_search.pl 
use strict; use warnings;

open(IN, "<$ARGV[0]") or die "error reading $ARGV[0] for reading"; 
my $name = $ARGV[1];
$name =~ tr/a-z/A-Z/;
my $name_length = length($name);
my $current_protein;
my @name_fields = ();

while (<IN>) {
	chomp; 
	if (substr($_, 0, 1) eq '>'){
		$current_protein = $_;
	}
	else {
		my $protein_length = length($_);
		for (my $i = 0; $i <= $protein_length - $name_length; $i++){
			if (substr($_, $i, $name_length) eq $name){
				@name_fields = split(" | ", $current_protein);
				$name_fields[0] = substr($name_fields[0], 1, length($name_fields[0])-1);
				print "$name_fields[0]\n";
			}
		}
	}
} 
close IN;
