print "Введите файл: ";
chomp(my $file = <>);

open(my $txtFile, '<:encoding(UTF-8)', $file) or die "Could not open file ", $file; 

my @numbers; 
my $row = "";

# =~ оператор сопоставления с шаблоном
# m - match
# g - поиск до конца строки, а не до первого совпадения
while (chomp($row = <$txtFile>)) { 
	 push(@numbers, $row =~ m/\d+/g); 
} 

my %dictionary = (1 => 'I', 5 => 'V', 10 => 'X', 50 => 'L', 100 => 'C'); 

my @divisions = (100, 50, 10, 5, 1); 

foreach my $number (@numbers) {
	 print $number, " = ";
	 my $out = "";

	 my $n = 1;
	 my $i = 0;

	#определяем разрядность числа и заменяем соответствующими римскими значениями
	while ($i < 5) { 
		 $n = int $number / $divisions[$i]; 
		 $number = $number % $divisions[$i]; 
		 $out = $out . $dictionary{$divisions[$i]} x $n; 
		 $i++;
	}                     
	 
	#s- оператор замены /../../
	$out =~ s/LXXXX/XC/eg;
	$out =~ s/XXXX/XL/eg;
	$out =~ s/VIIII/IX/eg;
	$out =~ s/IIII/IV/eg;
	print $out, "\n";
}
