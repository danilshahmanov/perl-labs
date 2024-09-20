use strict;
use warnings;

my %hash;   
my $head = "";   

while (1) { 
    print_menu(); 
    my $command = <STDIN>; 
    chomp $command; 

    if ($command == 1) { 
        add_string(\%hash); 
    } elsif ($command == 2) { 
        remove_string(\%hash); 
    } elsif ($command == 3) { 
        print_list(\%hash); 
    } elsif ($command == 4) { 
        last; 
    } else { 
        print "ОШИБКА! Нет такой команды\n"; 
    } 
} 

sub print_menu { 
    print "\nВведите номер команды: \n"; 
    print "1. Добавить строку в список \n"; 
    print "2. Удалить строку из списка \n"; 
    print "3. Просмотр списка \n"; 
    print "4. Выход из программы\n"; 
} 

sub add_string { 
    my ($hash_ref) = @_; 
    print "Введите строку: "; 
    my $input = <STDIN>; 
    chomp $input; 

    if (!exists $hash_ref->{$input}) { 
        if ($head eq "") { 
            $head = $input;   
        } else { 
            my $current = $head; 
            my $prev = ""; 
            # less than
            while ($current ne "" && $current lt $input) { 
                $prev = $current; 
                $current = $hash_ref->{$current}; 
            } 

            $hash_ref->{$input} = $current;   
            if ($prev eq "") { 
                $head = $input;   
            } else { 
                $hash_ref->{$prev} = $input;   
            } 
        } 
        print "Строка добавлена в список\n"; 
    } else { 
        print "ОШИБКА! Такая строка уже есть в списке\n"; 
    } 
} 

sub remove_string { 
    my ($hash_ref) = @_; 
    print "Введите строку для удаления: "; 
    my $input = <STDIN>; 
    chomp $input; 

    if (exists $hash_ref->{$input}) { 
        my $current = $head; 
        my $prev = ""; 

        while ($current ne "" && $current ne $input) { 
            $prev = $current; 
            $current = $hash_ref->{$current};
        } 

        if ($current eq $input) {
            if ($prev eq "") { 
                $head = $hash_ref->{$input};   
            } else { 
                $hash_ref->{$prev} = $hash_ref->{$input};  
            } 
            delete($hash_ref->{$input}); 
            print "Строка удалена из списка\n"; 
        } else {
            print "ОШИБКА! Такой строки нет в списке\n"; 
        }
    } else { 
        print "ОШИБКА! Такой строки нет в списке\n"; 
    } 
} 

sub print_list { 
    my ($hash_ref) = @_; 
    my $current = $head; 

    if ($current eq "") { 
        print "Список пуст.\n"; 
        return; 
    } 

    print "Список:\n"; 
    while ($current ne "") { 
        print "$current\n"; 
        $current = $hash_ref->{$current} // "";  
    } 
}