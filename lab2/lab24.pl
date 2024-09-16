#!/usr/bin/perl
use strict;
use warnings;

sub main {
    my %hash = ("вход" => "");
    my $head = "вход";
    
    while (1) {
        print_menu();
        my $command = <STDIN>;
        chomp $command;

        if ($command == 1) {
            add_string(\%hash, $head);
        } elsif ($command == 2) {
            remove_string(\%hash, $head);
        } elsif ($command == 3) {
            print_list(\%hash, $head);
        } elsif ($command == 4) {
            last;
        } else {
            print "ОШИБКА! Нет такой команды\n";
        }
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
    my ($hash_ref, $head) = @_;
    print "Введите строку: ";
    my $input = <STDIN>;
    chomp $input;

    if (keys %$hash_ref < 2) {
        $hash_ref->{$head} = $input;
        $hash_ref->{$input} = "";
    } elsif (exists $hash_ref->{$input}) {
        print "ОШИБКА! Такая строка уже есть в списке\n";
    } else {
        my $current = $hash_ref->{$head};
        my $prev = $head;

        while ($current ne "") {
            if ($current lt $input) {
                $prev = $current;
            }
            $current = $hash_ref->{$current};
        }

        $hash_ref->{$input} = $hash_ref->{$prev};
        $hash_ref->{$prev} = $input;
        print "Строка добавлена в список\n";
    }
}

sub remove_string {
    my ($hash_ref, $head) = @_;
    print "Введите строку для удаления: ";
    my $input = <STDIN>;
    chomp $input;

    if (exists $hash_ref->{$input}) {
        my $current = $head;
        my $prev;

        while ($current ne $input) {
            if ($hash_ref->{$current} eq $input) {
                $prev = $current;
            }
            $current = $hash_ref->{$current};
        }

        $hash_ref->{$prev} = $hash_ref->{$input};
        delete($hash_ref->{$input});
        print "Строка удалена из списка\n";
    } else {
        print "ОШИБКА! Такой строки нет в списке\n";
    }
}

sub print_list {
    my ($hash_ref, $head) = @_;
    my $current = $hash_ref->{$head};
    
    while ($current ne "") {
        print "$current\n";
        $current = $hash_ref->{$current};
    }
}

# Запуск основной функции
main();