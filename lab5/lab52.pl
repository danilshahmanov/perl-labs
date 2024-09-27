use strict;
use warnings;

# Получаем аргументы из командной строки
my ($dir, $output_file) = @ARGV;

# Проверяем, существует ли каталог
if (!(-e $dir)) {
    die "Каталог не существует!\n";
}

# Если указан файл для записи, открываем его
if (defined $output_file) {
    open(FILE, '>', $output_file) or die "Не удалось открыть файл: $!";
}

# Запуск функции для вывода содержимого каталога
show_dir($dir, $output_file);

# Закрытие файла, если он был открыт
if (defined $output_file) {
    close FILE;
    print "Результат записан в файл $output_file\n";
}

# Функция вывода содержимого директории
sub show_dir {
    my ($current_dir, $output_file) = @_;  # Используем локальную переменную для текущего каталога
    opendir(DIR, $current_dir) or die "Не удалось открыть каталог: $current_dir";

    # DIR - введёная директория, files - массив содержимого, file - элемент содержимого
    my @files = readdir DIR;
    closedir(DIR);  # Закрываем каталог, чтобы не допустить утечек ресурсов
    
    # Вывод параметров содержимого
    show_pr($current_dir, $output_file);

    foreach my $file (@files) {
        next if $file eq "." or $file eq "..";

        my $full_path = "$current_dir/$file";  # Локальная переменная для полного пути

        if (-d $full_path) {
            # Передаём в эту же функцию имя каталога
            show_dir($full_path, $output_file);
        }
    }
}

# Функция вывода параметров содержимого директории
sub show_pr {
    my ($current_dir, $output_file) = @_;  # Используем локальную переменную для текущего каталога
    opendir(DIR, $current_dir) or die "Не удалось открыть каталог: $current_dir";
    
    my @files = readdir(DIR);
    closedir(DIR);  # Закрываем каталог

    if (defined $output_file) {
        print FILE "\nКаталог $current_dir:\n";
    }
    else{
        print "\nКаталог $current_dir:\n";
    }

    foreach my $file (@files) {
        # Если файл не каталог
        if ($file ne ".." && $file ne "." && (-f "$current_dir/$file")) {
            my $size = -s "$current_dir/$file";
            my $time = (stat "$current_dir/$file")[9];
            my ($sec, $min, $hour, $day, $month, $year) = localtime($time);
            $month++;
            $year += 1900;
            
            my $R = -r "$current_dir/$file" ? "read = true" : "read = false";
            my $W = -w "$current_dir/$file" ? "write = true" : "write = false";

            if (defined $output_file) {
                print FILE "$file $size byte $day.$month.$year $hour:$min $R $W\n";
            } else {
                print "$file $size byte $day.$month.$year $hour:$min $R $W\n";
            }
        }
    }
}
