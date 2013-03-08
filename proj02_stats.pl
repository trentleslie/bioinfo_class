#!/usr/bin/perl 
# stats.pl by ___ 
use strict; use warnings;

#kills program unless there are 2 or more arguments 
die "usage: stats.pl <number1> <number2> <etc>\n" unless @ARGV > 1;

my @number_list = @ARGV;


#count the number of numbers

my $count = @number_list;
print "There are $count numbers in this list.\n";


#sum the numbers

#start sum at zero, then add each consecutive number to sum in foreach loop
my $sum = 0;
foreach my $number (@number_list) {$sum = $sum + $number;}
print "The sum of the number list is $sum.\n";


#mean

my$average = $sum / $count;
print "The mean of the number list is $average.\n";


#min & max

my @sorted_number_list = sort {$a <=> $b} @number_list;

#first item in sorted list is minimum number
my $min = $sorted_number_list[0];
#last item in sorted list is maximum number
my $max = $sorted_number_list[-1];

print "The minimum of the number list is $min.\n";
print "The maximum of the number list is $max.\n";


#median

my $median;
#find middle of array
my $mid = int @number_list/2;

#this checks if the length of the number list is odd or even by finding the 
#remainder after dividing by two (the modulus)
#if the list has an odd number of elements, the modulus is 1 and the conditional
#statement is considered true (the literal number "1" is "true" to the computer);
#if the list has an even number of elements, the modulus is 0 and the conditional
#statement is considered false (like before, the literal number "0" is "false" to
#the computer), so the "else" code is run 

if (@number_list % 2) {
    #if the list length is odd, then the median is just the middle value
    $median = $sorted_number_list[ $mid ];
} else {
    #if the list length is even, then the median is the average of the middle
    #two values
    $median = ($sorted_number_list[$mid-1] + $sorted_number_list[$mid])/2;
}

print "The median of the number list is $median\n";


#variance

#variance requires the sum of the squares of the difference between the values and the mean,
#so this sum is found just like the overall sum
my $sum_mean_diffs = 0;
foreach my $number (@number_list) {$sum_mean_diffs = $sum_mean_diffs + ($number - $average) ** 2;}
#variance is the average of these squared differences
my $variance = $sum_mean_diffs / $count;

print "The variance of the number list is $variance\n";


#standard deviation

#standard deviation is the square root of variance, which can be found using the 
#sqrt() function
my $stdev = sqrt($variance);
print "The standard deviation of the number list is $stdev\n";
