#!/usr/bin/perl
use strict;
use warnings;
use List::Util 'shuffle';  # Для случайной генерации чисел

# Структура узла дерева
sub new_node {
    my ($value) = @_;
    return {
        value => $value,
        left  => undef,
        right => undef
    };
}

# Добавление элемента в дерево
sub add {
    my ($node, $value) = @_;

    if (!defined $node) {
        return new_node($value);
    }

    if ($value < $node->{value}) {
        $node->{left} = add($node->{left}, $value);
    } elsif ($value > $node->{value}) {
        $node->{right} = add($node->{right}, $value);
    }
    return $node;
}

# Поиск минимального значения в дереве
sub find_min {
    my ($node) = @_;
    while (defined $node->{left}) {
        $node = $node->{left};
    }
    return $node;
}

# Удаление элемента из дерева
sub delete_node {
    my ($node, $value) = @_;
    my $deleted;

    return (undef, 0) unless defined $node;

    if ($value < $node->{value}) {
        ($node->{left}, $deleted) = delete_node($node->{left}, $value);
    } elsif ($value > $node->{value}) {
        ($node->{right}, $deleted) = delete_node($node->{right}, $value);
    } else {
        $deleted = 1;
        if (!defined $node->{left}) {
            return ($node->{right}, $deleted);
        } elsif (!defined $node->{right}) {
            return ($node->{left}, $deleted);
        }

        # Найдем минимальное значение в правом поддереве
        my $min_right = find_min($node->{right});
        $node->{value} = $min_right->{value};
        ($node->{right}, $deleted) = delete_node($node->{right}, $min_right->{value});
    }
    return ($node, $deleted);
}

# Рекурсивный сбор значений по уровням
sub collect_levels {
    my ($node, $level, $levels) = @_;
    return unless defined $node;

    $levels->[$level] ||= [];
    push @{ $levels->[$level] }, $node->{value};

    collect_levels($node->{left}, $level + 1, $levels);
    collect_levels($node->{right}, $level + 1, $levels);
}

# Печать дерева по уровням
sub print_tree {
    my ($root) = @_;
    my @levels;
    collect_levels($root, 0, \@levels);

    my $max_level = $#levels;
    for my $i (0 .. $max_level) {
        my $level_str = join(" ", @{ $levels[$i] });
        print "уровень $i: $level_str\n";
    }
}

# Генерация дерева
sub generate_tree {
    my ($size) = @_;
    if ($size <= 0) {
        warn "Размер дерева должен быть положительным числом.\n";
        return;
    }

    my @values = shuffle(1..100);  # Генерируем случайные числа от 1 до 100
    my $root;

    for my $i (0..$size-1) {
        $root = add($root, $values[$i]);
    }

    return $root;
}

# Основная программа
sub main {
    my $tree;

    while (1) {
        print "\n1. Добавить элемент\n2. Удалить элемент\n3. Показать дерево по уровням\n4. Сгенерировать дерево\n5. Выйти\n";
        print "Выберите опцию: ";
        my $choice = <STDIN>;
        chomp $choice;

        if ($choice == 1) {
            print "Введите значение для добавления: ";
            my $value = <STDIN>;
            chomp $value;
            if ($value =~ /^\d+$/) {  # Проверка на целое число
                my $exists = 0;
                my $node = $tree;
                while (defined $node) {
                    if ($value == $node->{value}) {
                        $exists = 1;
                        last;
                    }
                    $node = $value < $node->{value} ? $node->{left} : $node->{right};
                }
                if ($exists) {
                    print "Ошибка: элемент уже существует.\n";
                } else {
                    $tree = add($tree, $value);
                    print "Элемент добавлен.\n";
                }
            } else {
                print "Ошибка: введите целое число.\n";
            }
        } elsif ($choice == 2) {
			print "Введите значение для удаления: ";
            my $value = <STDIN>;
            chomp $value;
            if ($value =~ /^\d+$/) {  # Проверка на целое число
                my ($new_tree, $deleted) = delete_node($tree, $value);
                if ($deleted) {
                    $tree = $new_tree;
                    print "Элемент удален.\n";
                } else {
                    print "Ошибка: элемент не найден.\n";
                }
            } else {
                print "Ошибка: введите целое число.\n";
            }
        } elsif ($choice == 3) {
            print "Текущее дерево:\n";
            print_tree($tree);
        } elsif ($choice == 4) {
            print "Введите количество элементов для генерации: ";
            my $size = <STDIN>;
            chomp $size;
            if ($size =~ /^\d+$/ && $size > 0) {  # Проверка на положительное целое число
                $tree = generate_tree($size);
                print "Дерево сгенерировано.\n";
            } else {
                print "Ошибка: введите положительное целое число.\n";
            }
        } elsif ($choice == 5) {
            last;
        } else {
            print "Неправильный выбор, попробуйте снова.\n";
        }
    }
}

# Запуск основной программы
main();