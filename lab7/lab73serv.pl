use IO::Socket;
use strict;
use warnings;

my $server_port = 8080;

my $server;
my $client;
my $message;

print "Сервер TCP домена INTERNET\n";
$server = IO::Socket::INET->new(  #используем подкласс INET
	PeerAddr => 'localhost', #Адрес клиентского хоста
	LocalPort => $server_port, #Адрес порта клиента
	Type => SOCK_STREAM, #тип сокета сокет-поток
	Reuse => 1, #Устанавливаем свойство SO_REUSEADDR (разрешение повтороного использования адресов)
	Listen => 10) or die "Не получается создать сокет $!"; #очередь сообщений - 10

while (1) { 
	if ($client = $server->accept()) {
		 while (1) {
			 $message = <$client>;
			 print "Входящее сообщение: $message"; #получаем сообщение от клиента
			 print "Исходящее сообщение: "; #отправляем сообщение клиенту
			 $message = <>;
			 print $client $message;
		 }
		 close( $client );
	}
}
close( $server );

