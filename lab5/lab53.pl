use strict;
use warnings;

# Получаем имя каталога от пользователя
my $dir = $ARGV[0];
die "Каталог не существует!\n" unless -e $dir;

# Получаем расширение для удаления
# do используется для исполнения кода и возвращает последнее выражение
my $ex = $ARGV[1] // do {
    print "Введите удаляемое расширение:\n";
    chomp(my $input = <STDIN>);
    $input;
};

del($dir, $ex);

sub del {
    my ($dir, $extension) = @_;

    # $! - переменная содержащая код ошибки
    opendir my $dh, $dir or die "Не удалось открыть каталог $dir: $!\n";
    my @files = readdir $dh;
    closedir $dh;

    # Переходим в каталог
    chdir $dir or die "Не удалось перейти в каталог $dir: $!\n";

    # Удаляем файлы с указанным расширением
	# glob возвращает список файлов текущей директории по шаблону
    foreach my $file (glob("*.$extension")) {
		# unlink - удаляет файл
        unlink $file or warn "Невозможно удалить $file: $!\n";
        print "Файл $file удалён\n";
    }

    # Рекурсивно обрабатываем подкаталоги
    foreach my $f (@files) {
        next if $f eq '.' or $f eq '..';  # Пропускаем текущий и родительский каталоги
		# Если это подкаталог
        if (-d $f) {  
            del($f, $extension);  
			# Возврат на уровень выше
            chdir '..' or die "Не удалось вернуться в предыдущий каталог: $!\n";
        }
    }
}