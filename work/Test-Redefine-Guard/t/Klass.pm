package Klass;

use strict;
use warnings;

sub new {
    my $class = shift;
    return bless +{ boin => "boinboin" }, $class;
}

sub get_boin {
    my $self = shift;
    return $self->{boin};
}

1;
