print "Введите файл: ";
chomp(my $file = <>);

open(my $txtFile, '<:encoding(UTF-8)', $file) or die "Could not open file ", $file;
my @numbers;
my $row = "";

while ($row = <$txtFile>) {
 	chomp $row;
 	push @numbers, "$&" while $row =~ m/(C{0,3})((XC|XL)|(L)?(X){0,3})((IX|IV)|(V)?(I){0,3})/gm;
} 

my @clear_numbers;
foreach my $m (@numbers) { 
	#заносим в массив clear_numbers только Римские числа без раделителей
 	if (defined($m) && $m =~ /[A-Z]+/) {
 		push(@clear_numbers, $m)
 	}
}
my %dictionary = ('I' => 1, 'V' => 5, 'X'=> 10, 'L' => 50, 'C'=>100);

foreach my $number (@clear_numbers) {
 	print "\n", $number, " = ";
 	my $out = 0;
 	$number =~ s/XC/LXXXX/eg; 
 	$number =~ s/IX/VIIII/eg;
 	$number =~ s/IV/IIII/eg;
 	my @numberChar = split '', $number;

 	for (@numberChar) {
	 	$out += $dictionary{$_}; 
	}
	print $out;
}
