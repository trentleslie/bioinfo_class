#!/usr/bin/perl 
# poisson.pl (Stirling's approximation to the factorial) 
use strict; use warnings;

#set the first two inputs from the command line as $lamda and $k, respectively
my ($lamda, $k) = (@ARGV);

#Conditional statement checking if the numbers are greater than zero
#Note there are two conditions separated by the double pipe "||", which indicates an "or"
#(an "and" would be indicated by a double ampersand "&&")
#The "or" signifies that the code in braces will run if either is less than zero (or if
#both are less than zero)

if    ($lamda < 0 || $k < 0) {print "Lamda or k (or both) is less than zero. Try again.\n"}

#If both lamda and k are greater than or equal to zero, the following code is run

else  {

       #setting a new the variable $numer to be the numerator of the equation for poisson
       #probability

       my $numer = ($lamda ** $k) * (2.71828 ** -$lamda);

       #this is from the stirling program, which calculates a factorial (and therefore, the
       #the denomiator of the equation for poisson probability)

       my $ln_factorial = 
          (0.5 * log(2 * 3.14159265358979)) 
          + ($k + 0.5) * log($k) 
          - $k + 1 / (12 * $k) 
          - 1 / (360 * ($k ** 3)); 

       my $k_fac = 2.71828 ** $ln_factorial;

       #saving the final calculation as variable $poisprob, which divides the numerator by 
       #the factorial (denominator)

       my $poisprob = $numer / $k_fac;

       #printing the result to the screen!

       print "Probability is $poisprob.\n";
}

