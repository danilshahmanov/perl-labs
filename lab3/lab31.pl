use strict;
use warnings;

my $head = undef;  # Начальный элемент списка (пустой)

while (1) {
    print_menu();
    my $menu = <STDIN>;
    chomp($menu);

    if ($menu == 1) {
        add_student(\$head);
    } elsif ($menu == 2) {
        remove_student(\$head);
    } elsif ($menu == 3) {
        print_list(\$head);
    } elsif ($menu == 4) {
        last;
    } else {
        print "Нет такой команды\n";
    }
}

# Печать меню команд
sub print_menu {
    print "Меню:\n";
    print "1. Добавить студента в список\n";
    print "2. Удалить студента из списка\n";
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

    # Если список пуст
    if (!$$head_ref) {
        $$head_ref = $record;
        return;
    }

    # Если новый элемент должен быть в начале
    if ($$head_ref->{book_number} gt $book_number) {
        $record->{NEXT} = $$head_ref;
        $$head_ref = $record;
        return;
    }

    # Найти место для вставки элемента
    my $current = $$head_ref;
    while ($current->{NEXT} && $current->{NEXT}->{book_number} lt $book_number) {
        $current = $current->{NEXT};
    }

    if ($current->{book_number} eq $book_number) {
        print "Студент с таким номером зачетной книжки уже есть в списке\n";
        return;
    }

    $record->{NEXT} = $current->{NEXT};
    $current->{NEXT} = $record;
}

# Удаление записи из списка
sub remove_student {
    my ($head_ref) = @_;

    print "Введите номер зачетной книжки: ";
    my $book_number = <STDIN>;
    chomp($book_number);

    remove($head_ref, $book_number);
}

sub remove {
    my ($head_ref, $book_number) = @_;

    if (!$$head_ref) {
        print "Список пуст\n";
        return;
    }

    # Удаление из начала списка
    if ($$head_ref->{book_number} eq $book_number) {
        $$head_ref = $$head_ref->{NEXT};
        print "Студент удалён\n";
        return;
    }

    # Поиск записи для удаления
    my $current = $$head_ref;
    while ($current->{NEXT} && $current->{NEXT}->{book_number} ne $book_number) {
        $current = $current->{NEXT};
    }

    if ($current->{NEXT}) {
        $current->{NEXT} = $current->{NEXT}->{NEXT};
        print "Студент удалён\n";
    } else {
        print "Студент не найден\n";
    }
}

# Печать списка студентов
sub print_list {
    my ($head_ref) = @_;

    if (!$$head_ref) {
        print "Список пуст.\n";
        return;
    }

    print "\nФИО -> Зачётка -> Группа -> Специальность -> Год рождения\n";
    my $current = $$head_ref;
    while ($current) {
        print "$current->{fio} -> $current->{book_number} -> $current->{group_number} -> $current->{spec} -> $current->{birth}\n";
        $current = $current->{NEXT};
    }
}