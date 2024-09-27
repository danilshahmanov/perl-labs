use Socket;
use strict;
use warnings;

#создаём tcp сервер
sub tcp_server_create 
{
	my($socket_type, $socket_address) = @_;  

	# Создаём сокет (дескрипотр SERVER, заданный домен, сокет потока (без передачи границ сообщ.), 0 - устанавливаем стандартный протокол)
	socket(SERVER, $socket_type, SOCK_STREAM, 0); 

	# Устанавливаем определённый параметры сокета (дискрипотр SERVER, уровень библиотеки сокетов, разрешение повторного использования локальных адресов, 1 - включаем эти параметры)
	setsockopt(SERVER, SOL_SOCKET, SO_REUSEADDR, 1); 

	# Осуществляем регистрацию сокета в ядре операционной системы и производим связывание сокета с указанным адресом
	bind(SERVER, $socket_address) or die "Не удалось создать сервер. Ошибка: $!"; 

	# Включаем режим приема для сокета, регистрируя его как сервер, максимальное число символов для сообщения 1024
	listen(SERVER, SOMAXCONN) or die "Не удалось включить режим приема сокета: $!"; 

	for (;accept(CLIENT, SERVER); close (CLIENT))#принятие сообщения, пока работает сервер и клиент
	{
		 my $message;
		 print "Клиент подключен.\n";
		 while (defined($message = <CLIENT>))
		 {
			 print "Сообщение: ".$message;
		 }
		 print "Клиент отключен.\n";
	}
	close (SERVER);
}

#создаём upd сервер
sub udp_server_create 
{
	my($socket_type, $socket_address) = @_; 

	# Создаём сокет (дискрипотр SERVER, заданный домен, сокет дейтаграмм, 0 - устанавливаем стандартный протокол)
	socket(SERVER, $socket_type, SOCK_DGRAM, 0) or die $!; 

	# Устанавливаем определённый параметры сокета (дескрипотр SERVER, уровень библиотеки сокетов, разрешение повторного использования локальных адресов, 1 - включаем эти параметры)
	setsockopt(SERVER, SOL_SOCKET, SO_REUSEADDR, 1); 

	# Осуществляем регистрацию сокета в ядре операционной системы и производим связывание сокета с указанным адресом
	bind(SERVER, $socket_address) or die "Не удалось зарегистрировать сокет: $!"; 
	while (1)
	{
		# Прием заданного количества байт из сокета с сохранением в message (0 - считанные данные удаляются из сокета)
		recv(SERVER, my $message, 1024, 0); 
		print "Сообщение: ".$message; 
	}
	close (SERVER);
}

print "Выберите
1 - создать TCP сервер
2 - создать UDP сервер\n";

chomp(my $menu_item = <>);

my $server_port = 8080;

print "Выберите домен
1 - unix
2 - internet\n";
chomp(my $domain = <>);

my $socket_type = ($domain == 1)? PF_UNIX : PF_INET; 

# Если мы выбрали Юникс, то связь через файл
# Если был выбран internet, процесс занимает указанный порт и устанавливается локальный адрес хоста (0.0.0.0)
my $socket_address = ($domain == 1)? sockaddr_un('server.tmp') : 
	sockaddr_in($server_port, INADDR_ANY); 

if ($menu_item == 1) {
	print "TCP сервер. Порт: $server_port.\n";
	tcp_server_create($socket_type, $socket_address); 
} else {
	print "UDP сервер. Порт: $server_port.\n";
	udp_server_create($socket_type, $socket_address); 
}


