use strict;
use warnings;
use File::Find;

# Ввод пути директории
print "Введите директорию для поиска:\n";
chomp(my $directory = <>);

# Ввод строки для поиска
print "Введите строку для поиска вхождений:\n";
chomp(my $stringToSearch = <>);

# Спрашиваем, учитывать ли регистр
print "Учитывать регистр (0 - да, 1 - нет): ";
chomp(my $flag = <>);

# Используем File::Find для поиска файлов
find(sub {
	return unless -f;  # Обрабатываем только обычные файлы

	my $file = $File::Find::name;

	open(my $txtFile, "<:encoding(UTF-8)", $file) or die "Не удалось открыть файл '$file': $!";
	my $n = 0;  # Счётчик вхождений

	while (<$txtFile>) {
		if ($flag == 0) {
			# С учётом регистра
			$n++ while (/$stringToSearch/g);
		} else {
			# Без учёта регистра
			$n++ while (/$stringToSearch/ig);
		}
	}
	close($txtFile);

	if ($n != 0) {
		print "$file : $n\n";
	} else {
		print "$file : Вхождений нет\n";
	}
}, $directory);