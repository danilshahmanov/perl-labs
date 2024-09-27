#!C:/Perl/perl/bin/perl.exe
use strict;
use warnings;
use CGI;
use CGI::Carp qw(fatalsToBrowser);

my $cgi = CGI->new;

# Открываем файл с бронированиями для чтения
my $file = "bookings.txt";
open(my $fh, '<', $file) or die "Could not open file '$file' $!";

print $cgi->header('text/html');
print $cgi->start_html('View Bookings');
print $cgi->h1('Current Bookings');

print "<ul>";
while (my $line = <$fh>) {
    chomp $line;
    print "<li>$line</li>";
}
print "</ul>";

close $fh;

print $cgi->a({-href => '/index.html'}, 'Return to Home');
print $cgi->end_html;