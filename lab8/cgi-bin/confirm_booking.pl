#!C:/Perl/perl/bin/perl.exe
use strict;
use warnings;
use CGI;
use CGI::Carp qw(fatalsToBrowser);
use Fcntl qw(:flock);

my $cgi = CGI->new;
my $name = $cgi->param('name');
my $room_type = $cgi->param('room_type');

# Открываем файл для записи бронирований
my $file = "bookings.txt";
open(my $fh, '>>', $file) or die "Could not open file '$file' $!";
flock($fh, LOCK_EX);

print $fh "$name booked a $room_type room\n";

flock($fh, LOCK_UN);
close $fh;

# Вывод подтверждения на страницу
print $cgi->header;
print $cgi->start_html('Booking Confirmed');
print $cgi->h1('Thank you for your booking!');
print $cgi->p("Your booking for a $room_type room has been received.");
print $cgi->p("Your name: $name");
print $cgi->img({-src => 'success.png', -alt => 'Success Image'});

print $cgi->a({-href => '/cgi-bin/new_booking.pl'}, 'Make another booking');
print $cgi->end_html;