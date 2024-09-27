#!C:/Perl/perl/bin/perl.exe
use strict;
use warnings;
use CGI;
use CGI::Carp qw(fatalsToBrowser);

my $cgi = CGI->new;

print $cgi->header;
print $cgi->start_html('New Booking');
print $cgi->h1('Book a Room');
print $cgi->start_form(-method => 'POST', -action => '/cgi-bin/confirm_booking.pl');
print $cgi->label('Your Name: ');
print $cgi->textfield(-name => 'name');
print $cgi->br;

print $cgi->label('Room Type: ');
print $cgi->popup_menu(
    -name   => 'room_type',
    -values => ['Single', 'Double', 'Suite'],
);
print $cgi->br;

print $cgi->submit(-value => 'Submit Booking');
print $cgi->end_form;

print $cgi->end_html;