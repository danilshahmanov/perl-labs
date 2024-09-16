#!/usr/bin/perl
use strict;
use warnings;

package CD;

sub new {
    my ($class, %args) = @_;
    my $self = {
        title  => $args{title}  // 'Неизвестное название',
        artist => $args{artist} // 'Неизвестный исполнитель',
        year   => $args{year}   // 'Неизвестный год',
        genre  => $args{genre}  // 'Неизвестный жанр',
    };
    bless $self, $class;
    return $self;
}

sub display_info {
    my $self = shift;
    print "Название:  ", $self->{title}, "\n";
    print "Исполнитель: ", $self->{artist}, "\n";
    print "Год:   ", $self->{year}, "\n";
    print "Жанр:  ", $self->{genre}, "\n";
}

sub update_info {
    my ($self, %info) = @_;
    $self->{title}  = $info{title}  if defined $info{title};
    $self->{artist} = $info{artist} if defined $info{artist};
    $self->{year}   = $info{year}   if defined $info{year};
    $self->{genre}  = $info{genre}  if defined $info{genre};
}

1;  