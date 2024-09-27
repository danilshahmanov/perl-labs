use strict;
use warnings;
use File::Copy;

# Получаем путь к перемещаемому каталогу
print "Введите путь к перемещаемому каталогу: "; 
my $source_dir = <STDIN>; 
chomp($source_dir);

# Проверяем, существует ли исходный каталог
die "Каталог не существует!\n" unless -e $source_dir;

# Получаем путь к каталогу назначения
print "Введите путь к каталогу назначения: "; 
my $dest_dir = <STDIN>; 
chomp($dest_dir);

# Если каталог назначения не существует, создаем его
mkdir $dest_dir unless -e $dest_dir;

# Перемещаем каталог
my $dir_name = (split(/[\/\\]/, $source_dir))[-1];  # Получаем имя каталога
move_directory($source_dir, "$dest_dir/$dir_name");  # Вызываем функцию с полным путем

# Функция для перемещения каталога
sub move_directory { 
    my ($src, $dest) = @_;

    # Открываем исходный каталог
    opendir my $dh, $src or die "Не удалось открыть $src: $!\n";
    my @files = readdir $dh;
    closedir $dh;

    # Создаем целевой каталог
    mkdir $dest or die "Не удалось создать $dest: $!\n";

    # Перемещаем файлы и подкаталоги
    foreach my $file (@files) { 
        next if $file eq '.' or $file eq '..';  # Пропускаем служебные каталоги
        my $source_path = "$src/$file";
        my $dest_path = "$dest/$file";

        if (-d $source_path) {
            move_directory($source_path, $dest_path);  # Рекурсивный вызов для подкаталога
        } else {
            move($source_path, $dest_path) or die "Не удалось переместить $source_path: $!";
        }

        print "$source_path -> $dest_path\n"; 
    }

    rmdir $src or warn "Не удалось удалить $src: $!\n";  # Удаляем исходный каталог
}