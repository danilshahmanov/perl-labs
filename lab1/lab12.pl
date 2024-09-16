#!/usr/bin/perl
use strict;
use warnings;

sub main {
    my ($day, $month, $year) = get_current_date();
    my $name = "Свинарев, Шахманов";    # Задаём имя исполнителя
    my $num = 1;             # Номер лабораторной работы

    print_report($day, $month, $year, $name, $num);
}

sub get_current_date {
    print "Введите текущий день\n";
    my $day = <STDIN>;
    chomp $day;

    print "Введите текущий месяц\n";
    my $month = <STDIN>;
    chomp $month;

    print "Введите текущий год\n";
    my $year = <STDIN>;
    chomp $year;

    return ($day, $month, $year);
}

sub print_report {
    my ($day, $month, $year, $name, $num) = @_;

    # Используем local для того, чтобы временно сделать переменные доступными для формата
    local $^ = 'FORMAT_TOP'; # верхний колонтитул
    local $~ = 'FORMAT';     # основной формат

    # Локальные переменные для формата
    local $::day = $day;
    local $::month = $month;
    local $::year = $year;
    local $::name = $name;
    local $::num = $num;

    # Настройки длины страницы и вывод
    $= = 7;
    write;
}

# Формат верхнего колонтитула
format FORMAT_TOP =
@|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
"Общая структура программы. Ввод и вывод информации."
@>>>>>>>>>>>>>>>>>> 
"Форматы"
.

# Основной формат для вывода информации
format FORMAT =
Лабораторная работа №@##.##
$::num
Текущая дата:
@##.@##.@####
$::day, $::month, $::year
Работу выполнили:
@<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
$::name
.

main();