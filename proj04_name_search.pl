#!/usr/bin/perl 
# name_search.pl 
use strict; use warnings;

#this program searches for a string in protein sequences provided in a fasta file
#this program only works if the lines in the fasta file alternate between sequence name/info and
#the sequence
#in other words, it only works if sequence name/info is on odd-numbered lines and sequences are on
#even-numbered lines
#
#usage:
#perl name_search.pl <protein fasta file> <name>
#example:
#perl name_search.pl proteins.fasta george
#
#can test using grep:
#grep "george" proteins.fasta | wc -l
#
#grep output should match number of accession id's output by name_search.pl

#kills program if there is an error with opening the file specified in first agument of the command line
open(IN, "<$ARGV[0]") or die "error reading $ARGV[0] for reading"; 
#set the second argument in the command line as the name to be searched for
my $name = $ARGV[1];
#convert any lower case letters to upper case letters
$name =~ tr/a-z/A-Z/;
#declare variable for length of name
my $name_length = length($name);
#declare variable to store the current protein name being searched
my $current_protein;
#declare empty array that will be used to store fields in fasta sequence header line (current_protein)
my @name_fields = ();

#while loop feeds in lines of IN (fasta file opened above) while lines exist - that is, it looks at one
#line at a time until the file runs out of lines to look at (in this case, until the fasta file runs
#out of sequences to look at
while (<IN>) {
	#removes newline (\n) at end of current file line (the newline character would affect calculated
	#length of sequence)
	chomp;

	#the big conditional statement
	#
	#the main idea is that it is checking if the current line is the name and info involving the
	#sequence or the sequence itself
	#
	#it does this by using the substr() function to look at the first character of the line.
	#if the first character is '>', then it is the name and info involving the sequence that is in
	#the next line (assuming the fasta formatting is correct) - otherwise, it is assumed to be the
	#sequence itself
	#
	#if the fasta file is formatted correctly, the code being run should alternate between the "if"
	#code block and "else" code block with each loop iteration.
	#the lines containing the name and info for the sequence will trigger the "if" code to run (but
	#not the "else" code), and the lines containing the actual protein sequences will triger the
	#"else" code to run (but not the "if" code).

	if (substr($_, 0, 1) eq '>'){
		#if the first character in the line is '>', then the current line in the file is the
		#info involving the actual sequence in the next line.
		#because this information won't be available in the following loop (the next loop's line
		#from the file ($_) will be the sequence itself), the current line involving the info
		#about that sequence is stored in the variable $current_protein
		$current_protein = $_;
	}
	else {
		#this block of code won't be run if the first character in the current line is '>', but
		#will be run if the character is anything else
		#
		#presumably, this means it is the protein sequence that $current_protein has info stored
		#about from the previous line in the file (from the previous loop) 

		#store protein length
		my $protein_length = length($_);

		#the for loop
		#
		#the for loop is what scans the individual protein sequences from beginning to end in
		#chunks (call kmers) that are extracted using substr() and are the same length as the
		#name provided in the command line.
		#
		#this is done by using $i to determine the start of the kmer within the entire sequence
		#and increasing $i by one with each iteration
		#so by searching for CAT in the sequence MEJISCATQJ, the first iteration will compare
		#CAT and the kmer MEJ (when $i = 0 and $name_length = 3), the second iteration will
		#compare CAT and the kmer EJI (when $i = 1 and $name_length = 3), and so forth
		#
		#the last iteration is when $i = $protein_length - $name_length
		#in this case, it's when 10 - 3 = 7
		#so when $i is 7, the iteration is comparing CAT to TQJ (remember the first position is
		#considered position "0", not "1")
		#if $i is allowed to go beyond that, the kmer length won't be long enough to compare to
		#the name anymore (if $i is 8, the substr() function would be trying to pull an 11th
		#character from the protein sequence and cause an error)

		for (my $i = 0; $i <= $protein_length - $name_length; $i++){

			#the little conditional statement
			#
			#this conditional compares the current kmer (specified by the substr() function,
			#which uses the current file line $_, the current $i, and length of the name provided
			#in the command line) and the name provided in the command line
			#
			#if there is a match, it prints the name provided in the previous file line;
			#otherwise, nothing happens and the program moves on to the next line in the file
			if (substr($_, $i, $name_length) eq $name){
				#if there is a match between the kmer and name, the info in the previous
				#line is split and stored in an array based on space-pipe-space (" | ")
				#using the split() function
				@name_fields = split(" | ", $current_protein);
				
				#this overwrites the first element in the array (in this case, the accession
				#number of the current protein with the '>' at the beginning of the line)
				#without the first character
				#for example, ">ATg3453234" would be overwritten as "ATg3453234"
				$name_fields[0] = substr($name_fields[0], 1, length($name_fields[0])-1);

				#print the overwritten first element to the screen
				print "$name_fields[0]\n";
			}
		}
	}
} 
#closes the open file "IN"
close IN;
