#! /bin/usr/perl
print "Как Ваше имя?\n";
$name= <STDIN>;
print "Сколько Вам лет?\n";
$age = <STDIN>;
$~=SALUT_FORMAT;
write;
format SALUT_FORMAT=
Поздравляем Вас, ^>>>>>>>>>>>>>>>!
$name
Сегодня, в возpасте @###.## лет Вы написали
$age
свою пеpвую Perl-пpогpамму !
.
format SALUT_FORMAT_TOP=
*******Пеpвый сценарий на Perl*******
.

