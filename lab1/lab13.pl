#!/usr/bin/perl
use strict;
use warnings;

sub main {
    my $filename = 'output.html';
    
    # Создание и запись HTML-файла
    create_or_overwrite_file($filename);
    print "HTML-страница успешно сгенерирована в файл $filename\n";
}

sub create_or_overwrite_file {
    my ($filename) = @_;

    my $ENDHTML = <<'ENDHTML';
<html>
    <head>
        <title>lab1</title>
    </head>
    <body>
        <p>Hello, World</p>
        <a href="http://lab1.com">Click here</a>
    </body>
</html>
ENDHTML

    open(my $fh, '>', $filename) or die "Не удалось открыть файл '$filename': $!";

    print $fh $ENDHTML;

    close($fh);
}

main();