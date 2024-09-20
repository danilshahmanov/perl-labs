use strict;
use warnings;

# Инициализация стержней
my %pegs = (
    A => [],  # Начальный стержень
    B => [],  # Вспомогательный стержень
    C => []   # Конечный стержень
);

# Функция для отображения состояния стержней
sub print_pegs {
    my %pegs = @_;
    foreach my $peg (qw(A B C)) {
        print "$peg: " . (scalar @{$pegs{$peg}} ? join(", ", reverse @{$pegs{$peg}}) : "пусто") . "\n";
    }
    print "\n";
}

# Функция для решения задачи Ханойской башни
sub hanoi {
    my ($n, $from, $to, $aux) = @_;
    
    if ($n == 1) {
        my $disk = pop @{$pegs{$from}};
        push @{$pegs{$to}}, $disk;
        print "Переместить диск $disk с $from на $to\n";
        print_pegs(%pegs);
    } else {
        # Переместить n-1 дисков с $from на $aux, используя $to как вспомогательную
        hanoi($n - 1, $from, $aux, $to);
        
        # Переместить диск n с $from на $to
        my $disk = pop @{$pegs{$from}};
        push @{$pegs{$to}}, $disk;
        print "Переместить диск $n с $from на $to\n";
        print_pegs(%pegs);
        
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

# Запуск функции с тремя столбцами: A (начальный), C (конечный), B (вспомогательный)
print_pegs(%pegs);
hanoi($n, 'A', 'C', 'B');