#!/usr/bin/perl
use strict;
use warnings;

# Основная функция
sub main {
    my $head = undef; # Начальный элемент списка (пустой)

    while (1) {
        print_menu();
        my $menu = <STDIN>;
        chomp($menu);

        if ($menu == 1) {
            add_student(\$head);
        } elsif ($menu == 2) {
            remove_student(\$head);
        } elsif ($menu == 3) {
            print_list($head);
        } elsif ($menu == 4) {
            last;
        } else {
            print "Нет такой команды\n";
        }
    }
}

# Печать меню команд
sub print_menu {
    print "Меню:\n";
    print "1. Добавить строку в список\n";
    print "2. Удалить строку из списка\n";
    print "3. Просмотреть список\n";
    print "4. Выход\n";
    print "Введите номер команды: ";
}

# Добавление студента в список
sub add_student {
    my ($head_ref) = @_;

    print "Введите ФИО: ";
    my $fio = <STDIN>;
    chomp($fio);

    print "Введите номер зачетной книжки: ";
    my $book_number = <STDIN>;
    chomp($book_number);

    print "Введите номер группы: ";
    my $group_number = <STDIN>;
    chomp($group_number);

    print "Введите специальность: ";
    my $spec = <STDIN>;
    chomp($spec);

    print "Введите год рождения: ";
    my $birth = <STDIN>;
    chomp($birth);

    add($head_ref, $fio, $book_number, $group_number, $spec, $birth);
}

# Удаление студента из списка
sub remove_student {
    my ($head_ref) = @_;

    print "Введите номер зачетной книжки: ";
    my $book_number = <STDIN>;
    chomp($book_number);

    remove($head_ref, $book_number);
}

# Печать списка студентов
sub print_list {
    my ($head) = @_;
    print "\nФИО Зачётка Группа Специальность Год рождения\n";
    output($head);
}

# Добавление записи в список
sub add {
    my ($head_ref, $fio, $book_number, $group_number, $spec, $birth) = @_;
    my $record = {
        fio => $fio,
        book_number => $book_number,
        group_number => $group_number,
        spec => $spec,
        birth => $birth,
        NEXT => undef
    };

    if (!$$head_ref) {
        $$head_ref = $record;
        return;
    }

    if ($$head_ref->{book_number} eq $book_number) {
        print "Студент уже в списке\n";
        return;
    } elsif ($$head_ref->{book_number} lt $book_number) {
        add(\$$head_ref->{NEXT}, $fio, $book_number, $group_number, $spec, $birth);
    } else {
        $record->{NEXT} = $$head_ref;
        $$head_ref = $record;
    }
}

# Удаление записи из списка
sub remove {
    my ($head_ref, $book_number) = @_;

    if (!$$head_ref) {
        print "Студент не найден\n";
        return;
    }

    if ($$head_ref->{book_number} eq $book_number) {
        $$head_ref = $$head_ref->{NEXT};
        return;
    }

    remove(\$$head_ref->{NEXT}, $book_number);
}

# Печать списка записей
sub output {
    my ($record) = @_;

    while ($record) {
        print "$record->{fio} -> $record->{book_number} -> $record->{group_number} -> $record->{spec} -> $record->{birth}\n";
        $record = $record->{NEXT};
    }
}

# Запуск основной функции
main();