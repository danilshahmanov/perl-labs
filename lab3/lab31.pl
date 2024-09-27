while (true) {
    print "Меню:\n";
    print "1. Добавить строку в список\n";
    print "2. Удалить строку из списка\n";
    print "3. Просмотреть список\n";
    print "4. Выход\n";
    print "Введите номер команды: ";
    $menu = <>;
    
    if ($menu == 1) {
        print "Введите ФИО: ";
        $fio = <>;
        chomp($fio);
        
        print "Введите номер зачетной книжки: ";
        $book_number = <>;
        chomp($book_number);
        
        print "Введите номер группы: ";
        $group_number = <>;
        chomp($group_number);
        
        print "Введите специальность: ";
        $spec = <>;
        chomp($spec);
        
        print "Введите год рождения: ";
        $birth = <>;
        chomp($birth);
        
        $head = add($head, $fio, $book_number, $group_number, $spec, $birth);
    } elsif ($menu == 2) {
        print "\nВведите номер зачетной книжки: ";
        $change_book_number = <>;
        chomp($change_book_number);
        
        $head = remove($head, $change_book_number);
    } elsif ($menu == 3) {
        print "\nФИО Зачётка Группа Специальность Год рождения\n";
        output($head);
    } elsif ($menu == 4) {
        exit;
    } else {
        print "Нет такой команды\n";
        next;
    }
}

# функция добавления в упорядоченный список
sub add {
    my ($head, $fio, $book_number, $group_number, $spec, $birth) = @_;
    
    my $record = {
        fio         => $fio,
        book_number => $book_number,
        group_number => $group_number,
        spec        => $spec,
        birth       => $birth,
        NEXT        => undef
    };
    
    # Если список пуст или номер текущей записи больше, вставляем запись
    if (!$head || $head->{book_number} > $book_number) {
        $record->{NEXT} = $head;
        return $record;
    } 
    # Если дубликат по номеру зачетной книжки
    elsif ($head->{book_number} eq $book_number) {
        print "\nСтудент уже в списке\n\n";
        return $head;
    } 
    # Иначе продолжаем рекурсию по списку
    else {
        $head->{NEXT} = add($head->{NEXT}, $fio, $book_number, $group_number, $spec, $birth);
        return $head;
    }
}

# функция удаления записи
sub remove {
    my ($head, $book_number) = @_;
    
    # Если конец списка или запись не найдена
    unless ($head) {
        print "Студент не найден\n";
        return;
    }
    
    # Если номер зачетной книжки совпадает
    if ($head->{book_number} eq $book_number) {
        return $head->{NEXT}; # пропускаем текущий элемент
    } else {
        $head->{NEXT} = remove($head->{NEXT}, $book_number); # продолжаем рекурсию
        return $head;
    }
}

# функция вывода списка
sub output {
    my ($head) = @_;
    
    unless ($head) {
        return;
    }
    
    print "$head->{fio} -> $head->{book_number} -> $head->{group_number} -> $head->{spec} -> $head->{birth}\n";
    output($head->{NEXT}); # продолжаем рекурсию для следующего элемента
}