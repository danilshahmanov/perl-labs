use strict;
use warnings;

# Доступ к элементу массива: $array[index], срез массива @array[index]
# Разименование ссылки и доступ к элементу массива $$array[index] или $array->[index]

# Инициализация стержней
my %pegs = (
    A => [],  # Начальный стержень
    B => [],  # Вспомогательный стержень
    C => []   # Конечный стержень
);

# Функция для отображения состояния стержней
sub print_pegs {
    my ($message) = @_;

	#открываем файл на запись
 	open (FILE, ">>result.txt"); 

	print FILE "$message\n";

    foreach my $peg (qw(A B C)) {
        print FILE  "$peg: " . (scalar @{$pegs{$peg}} ? join(", ", reverse @{$pegs{$peg}}) : "пусто") . "\n";
    }
    print FILE  "\n";
	#закрываем файл
 	close FILE;
}

# Функция для решения задачи Ханойской башни
sub hanoi {
    my ($n, $from, $to, $aux) = @_;
    
    if ($n == 1) {
        my $disk = pop @{$pegs{$from}};
        push @{$pegs{$to}}, $disk;
        my $message = "Переместить диск $disk с $from на $to";
        print_pegs($message);
    } else {
        # Переместить n-1 дисков с $from на $aux, используя $to как вспомогательную
        hanoi($n - 1, $from, $aux, $to);
        
        # Переместить диск n с $from на $to
        my $disk = pop @{$pegs{$from}};
        push @{$pegs{$to}}, $disk;
        my $message = "Переместить диск $n с $from на $to";
        print_pegs($message);
        
        # Переместить n-1 дисков с $aux на $to, используя $from как вспомогательную
        hanoi($n - 1, $aux, $to, $from);
    }
}

# Ввод числа дисков с консоли
print "Введите количество дисков: ";
my $n = <STDIN>;
chomp($n);

# Инициализация начального стержня с дисками
$pegs{A} = [reverse 1..$n];

# очистка файла
open (FILE, ">result.txt"); 
close FILE;

# Запуск функции с тремя столбцами: A (начальный), C (конечный), B (вспомогательный)
print_pegs("Начальное состояние: ");
hanoi($n, 'A', 'C', 'B');

