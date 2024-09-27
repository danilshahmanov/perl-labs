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

    # дерево пустое или достигнут конец
    if (!$node) {
        return (undef, 0);  # Возвращаем undef для нового дерева и 0 (ничего не удалено)
    }

    # Если значение меньше текущего узла, ищем его в левом поддереве
    if ($value < $node->{value}) {
        my ($new_left, $deleted) = delete_node($node->{left}, $value);

        #обновляем ссылку на левый дочерний элемент
        $node->{left} = $new_left;

        return ($node, $deleted);
    }
    # Если значение больше текущего узла, ищем его в правом поддереве
    elsif ($value > $node->{value}) {
        my ($new_right, $deleted) = delete_node($node->{right}, $value);

        #обновляем ссылку на правый дочерний элемент
        $node->{right} = $new_right;

        return ($node, $deleted);
    }
    # Если нашли узел, который нужно удалить 
    else {
        # Узел без детей (листовой узел)
        if (!$node->{left} && !$node->{right}) {
            return (undef, 1);  # Удаляем узел (возвращаем undef вместо узла)
        }
        # Узел только с правым поддеревом
        elsif (!$node->{left}) {
            return ($node->{right}, 1);  
        }
        # Узел только с левым поддеревом
        elsif (!$node->{right}) {
            return ($node->{left}, 1); 
        }
        # Узел с двумя поддеревьями
        else {
            #минимальный узел в правом поддереве
            my $min_node = find_min($node->{right});

            # Заменяем значение текущего узла на значение наследника
            $node->{value} = $min_node->{value};

            # Удаляем наследника из правого поддерева 
            my ($new_right, $deleted) = delete_node($node->{right}, $min_node->{value});

            # Обновляем правое поддерево после удаления наследника
            $node->{right} = $new_right;

            # Возвращаем обновлённое дерево и результат удаления
            return ($node, 1);
        }
    }
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

    # Индекс последнего элемента 
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
        print "Добавлен элемент $values[$i].\n";
        $root = add($root, $values[$i]);
    }

    return $root;
}

my $tree;

while (1) {
    print "\n1. Добавить элемент\n2. Удалить элемент\n3. Показать дерево по уровням\n4. Сгенерировать дерево\n5. Выйти\n";
    print "Выберите опцию: ";
    my $choice = <STDIN>;
    chomp $choice;

    if ($choice eq '1') {
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
    } elsif ($choice eq '2') {
        print "Введите значение для удаления: ";
        my $value = <STDIN>;
        chomp $value;
        if ($value =~ /^\d+$/) {  # Проверка на целое число
            my ($new_tree, $has_deleted) = delete_node($tree, $value);
            if ($has_deleted) {
                $tree = $new_tree;
                print "Элемент удален.\n";
            } else {
                print "Ошибка: элемент не найден.\n";
            }
        } else {
            print "Ошибка: введите целое число.\n";
        }
    } elsif ($choice eq '3') {
        print "Текущее дерево:\n";
        print_tree($tree);
    } elsif ($choice eq '4') {
        print "Введите количество элементов для генерации: ";
        my $size = <STDIN>;
        chomp $size;
        if ($size =~ /^\d+$/ && $size > 0) {  # Проверка на положительное целое число
            $tree = generate_tree($size);
            print "Дерево сгенерировано.\n";
        } else {
            print "Ошибка: введите положительное целое число.\n";
        }
    } elsif ($choice eq '5') {
        last;
    } else {
        print "Неправильный выбор, попробуйте снова.\n";
    }
}
