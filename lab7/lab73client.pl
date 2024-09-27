use IO::Socket;
use strict;
use warnings;

my $server_port = 8080;

my $client;
my $message;

print "Клиент TCP домена INTERNET\n";
$client = IO::Socket::INET->new( #используем подкласс INET
	PeerAddr => 'localhost', #Адрес серверного хоста
	PeerPort => $server_port, #Порт серверного хоста
	Proto => "tcp", #Протокол tcp
	Type => SOCK_STREAM) or die "Не получается создать сокет $!"; #Тип сокета сокет-поток

print "Исходящее сообщение: "; #отправляем сообщение
while ($message = <>) {
	print $client $message;
	$message = <$client>;
	print "Входящее сообщение: $message"; #получаем сообщение
	print "Исходящее сообщение: ";
}
close( $client );

