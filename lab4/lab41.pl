use strict;
use warnings;
use lib '.';
use CD;

my @collection;

sub create_cd {
    print "Введите название CD: ";
    my $title = <STDIN>;
    chomp($title);

    print "Введите имя исполнителя: ";
    my $artist = <STDIN>;
    chomp($artist);

    print "Введите год выпуска: ";
    my $year = <STDIN>;
    chomp($year);

    print "Введите жанр: ";
    my $genre = <STDIN>;
    chomp($genre);

    my $cd = CD->new(
        title  => $title,
        artist => $artist,
        year   => $year,
        genre  => $genre
    );

    push @collection, $cd;
    print "CD добавлен в коллекцию.\n";
}

sub update_cd {
    print "Введите индекс CD для обновления (начиная с 0): ";
    my $index = <STDIN>;
    chomp($index);

    if ($index >= 0 && $index < @collection) {
        my $cd = $collection[$index];

        print "Введите новое название (или нажмите Enter для пропуска): ";
        my $title = <STDIN>;
        chomp($title);

        print "Введите нового исполнителя (или нажмите Enter для пропуска): ";
        my $artist = <STDIN>;
        chomp($artist);

        print "Введите новый год выпуска (или нажмите Enter для пропуска): ";
        my $year = <STDIN>;
        chomp($year);

        print "Введите новый жанр (или нажмите Enter для пропуска): ";
        my $genre = <STDIN>;
        chomp($genre);

        $cd->update_info(
            title  => $title  ? $title  : undef,
            artist => $artist ? $artist : undef,
            year   => $year   ? $year   : undef,
            genre  => $genre  ? $genre  : undef
        );

        print "CD обновлен.\n";
    } else {
        print "Неверный индекс.\n";
    }
}

sub display_collection {
    if (@collection) {
        for my $index (0 .. $#collection) {
            print "\nCD $index:\n";
            $collection[$index]->display_info();
        }
    } else {
        print "Коллекция пуста.\n";
    }
}


while (1) {
    print "\nМеню:\n";
    print "1. Создать новый CD\n";
    print "2. Обновить информацию о CD\n";
    print "3. Показать коллекцию\n";
    print "4. Выйти\n";
    print "Выберите действие: ";
    my $choice = <STDIN>;
    chomp($choice);

    if ($choice == 1) {
        create_cd();
    } elsif ($choice == 2) {
        update_cd();
    } elsif ($choice == 3) {
        display_collection();
    } elsif ($choice == 4) {
        last;
    } else {
        print "Неверный выбор. Пожалуйста, выберите снова.\n";
    }
}
