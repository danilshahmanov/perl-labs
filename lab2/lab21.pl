use strict;
use warnings;


my @masA = get_array('A');
my @masB = get_array('B');

# Передача массива по ссылке
print_arrays(\@masA, \@masB);

my @merged = merge_arrays(\@masA, \@masB);
print "\nОбъединенный массив: @merged\n";

my @intersection = intersect_arrays(\@masA, \@masB);
print "\nПересечение: @intersection\n";

my @sym_diff = symmetric_difference(\@masA, \@masB);
print "\nРезультат симметричной разности: @sym_diff\n";

my @diffAB = difference(\@masA, \@masB);
print "\nРазность A-B: @diffAB\n";

my @diffBA = difference(\@masB, \@masA);
print "\nРазность B-A: @diffBA\n";

print "Длина массива A: " . scalar(@masA) . "\n";
print "Длина массива B: " . scalar(@masB) . "\n";

my @masA_rearranged = rearrange_array(\@masA);
print "\nМассив A после перестановок:\n @masA_rearranged\n";

my @masC = merge_arrays_and_print(\@masA, \@masB);
print "\nМассив C:\n @masC\n";


sub get_array {
    my ($name) = @_;
    my @array;
    print "Введите массив $name (пустая строка для завершения):\n";

    # last = break
    while (1) {
        chomp(my $input = <STDIN>);
        if ($input eq ''){
             last; 
        }
        push @array, int($input);
    }
    return @array;
}

sub print_arrays {
    # Получение ссылки на массив
    my ($masA_ref, $masB_ref) = @_;
    # Разименование ссылки для получения массива
    print "\nМассив A: @$masA_ref\n";
    print "\nМассив B: @$masB_ref\n";
}

# Функция для объединения массивов
sub merge_arrays {
    # Получение ссылки на массив
    my ($masA_ref, $masB_ref) = @_;
    # Вспомогательный хэш 
    my %seen;
    my @merged = (@$masA_ref, @$masB_ref);

    # grep - Создание нового массива на основе переданного 
    return grep { !$seen{$_} } @merged;
}

# Функция для пересечения двух массивов
sub intersect_arrays {
     # Получение ссылки на массив
    my ($masA_ref, $masB_ref) = @_;
    # Заполняем хэш массивом B со значением по умолчанию 1
    my %seen = map { $_ => 1 } @$masB_ref;
    # Если в хэше присутствует элемент из A, то добавляем в итоговый массив 
    return grep { $seen{$_} } @$masA_ref;
}

# Функция для симметричной разности
sub symmetric_difference {
    my ($masA_ref, $masB_ref) = @_;

     # Заполняем хэш массивом A со значением по умолчанию 1
    my %seenA = map { $_ => 1 } @$masA_ref;
    my %seenB = map { $_ => 1 } @$masB_ref;

    # Итоговый массив
    my @sym_diff;

    foreach my $item (@$masA_ref) {
        if(!$seenB{$item}){
            push @sym_diff, $item;
        }
    }

    foreach my $item (@$masB_ref) {
        if(!$seenA{$item}){
            push @sym_diff, $item;
        }
    }
    return @sym_diff;
}

# Функция для разности двух массивов
sub difference {
    my ($masA_ref, $masB_ref) = @_;
    # Заполняем хэш массивом B со значением по умолчанию 1
    my %seenB = map { $_ => 1 } @$masB_ref;
    # Если в массиве B нет элемента, то добавляем в итоговый массив
    return grep { !$seenB{$_} } @$masA_ref;
}

# Перестановка элементов массива A
sub rearrange_array {
    my ($mas_ref) = @_;
    my @mas = @$mas_ref;

    for (my $i = 1; $i < @mas; $i += 2) {
        @mas[$i, $i - 1] = @mas[$i - 1, $i];
    }

    return @mas;
}

# Объединение массивов
# элементы с четными индексами взяты из первого массива, а 
# элементы с нечетными индексами — из второго
sub merge_arrays_and_print {
     my ($mas1_ref, $mas2_ref) = @_;
    my @mas1 = @$mas1_ref;
    my @mas2 = @$mas2_ref;
    my @mas3;

    my $max_length = @mas1 > @mas2 ? 2 * @mas1 : 2 * @mas2;

    my ($a, $b) = (0, 0);

    for (my $i = 0; $i < $max_length; $i++) {
        if ($i % 2 == 0 && $a <= @mas2) {
            push @mas3, $mas2[$a];
            $a++;
        } else {
            if($b <= @mas1){
                push @mas3, $mas1[$b];
                $b++;
            }          
        }
    }
    return @mas3;
}