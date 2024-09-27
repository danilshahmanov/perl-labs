#!/usr/bin/perl
use strict;
use warnings;
use CGI;
use CGI::Carp qw(fatalsToBrowser);

my $cgi = CGI->new;

# Файлы
my $bookings_file = "/workspaces/perl-labs/lab8/data/bookings.txt";
my $rooms_file = "/workspaces/perl-labs/lab8/data/rooms.txt";
my $rooms_constants_file = "/workspaces/perl-labs/lab8/data/rooms_constants.txt";

# Очистка файла с бронями
open(my $fh, '>', $bookings_file) or die "Could not open file '$bookings_file' $!";
close $fh;

# Чтение всех номеров из rooms_constants и запись в rooms
open(my $crfh, '<', $rooms_constants_file) or die "Could not open file '$rooms_constants_file' $!";
my @rooms_data;

while (my $line = <$crfh>) {
    chomp $line;
    push @rooms_data, $line;  # Сохраняем все номера из rooms_constants
}

close $crfh;

# Запись номеров в rooms
open(my $rfh, '>', $rooms_file) or die "Could not open file '$rooms_file' $!";
print $rfh join("\n", @rooms_data);  # Записываем все номера
close $rfh;

# Перенаправление на главную страницу
print $cgi->header(-status => '302 Found', -Location => '/index.html');