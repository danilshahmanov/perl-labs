#!/usr/bin/perl
use strict;
use warnings;

sub main {
    my @masA = get_array('A');
    my @masB = get_array('B');

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
}

sub get_array {
    my ($name) = @_;
    my @array;
    print "Введите массив $name (пустая строка для завершения):\n";
    while (1) {
        chomp(my $input = <STDIN>);
        last if $input eq '';
        push @array, int($input);
    }
    return @array;
}

sub print_arrays {
    my ($masA_ref, $masB_ref) = @_;
    print "\nМассив A: @$masA_ref\n";
    print "\nМассив B: @$masB_ref\n";
}

# Функция для объединения массивов
sub merge_arrays {
    my ($masA_ref, $masB_ref) = @_;
    my %seen;
    my @merged = (@$masA_ref, @$masB_ref);
    return grep { !$seen{$_}++ } @merged;
}

# Функция для пересечения двух массивов
sub intersect_arrays {
    my ($masA_ref, $masB_ref) = @_;
    my %seen = map { $_ => 1 } @$masB_ref;
    return grep { $seen{$_} } @$masA_ref;
}

# Функция для симметричной разности
sub symmetric_difference {
    my ($masA_ref, $masB_ref) = @_;
    my %seenA = map { $_ => 1 } @$masA_ref;
    my %seenB = map { $_ => 1 } @$masB_ref;

    my @sym_diff;
    foreach my $item (@$masA_ref) {
        push @sym_diff, $item unless $seenB{$item};
    }
    foreach my $item (@$masB_ref) {
        push @sym_diff, $item unless $seenA{$item};
    }
    return @sym_diff;
}

# Функция для разности двух массивов
sub difference {
    my ($masA_ref, $masB_ref) = @_;
    my %seenB = map { $_ => 1 } @$masB_ref;
    return grep { !$seenB{$_} } @$masA_ref;
}

# Перестановка элементов массива A
sub rearrange_array {
    my ($mas_ref) = @_;
    my @mas = @$mas_ref;
    my $maxA = $#mas;
    my $i = 1;
    while ($i <= $maxA) {
        @mas[$i, $i - 1] = @mas[$i - 1, $i];
        $i += 2;
    }
    return @mas;
}

# Объединение массивов C
sub merge_arrays_and_print {
    my ($mas1_ref, $mas2_ref) = @_;
    my @mas1 = @$mas1_ref;
    my @mas2 = @$mas2_ref;
    my @mas3;

    my $maxA = scalar @mas1;
    my $maxB = scalar @mas2;
    my $max_length = $maxA > $maxB ? 2 * $maxA : 2 * $maxB;

    my ($a, $b) = (0, 0);

    for (my $i = 0; $i < $max_length; $i++) {
        if ($i % 2 == 0) {
            push @mas3, $mas2[$a] // ".";
            $a++;
        } else {
            push @mas3, $mas1[$b] // ".";
            $b++;
        }
    }
    return @mas3;
}

# Запуск основной функции
main();