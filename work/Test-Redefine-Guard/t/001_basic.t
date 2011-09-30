#!perl -w
use strict;
use Test::More;

use Test::Redefine::Guard qw/redefine_guard/;

use lib "t";
use Klass;

subtest("normal boin", sub {
    my $instance = Klass->new;
    is( $instance->get_boin, "boinboin", "we are boin." );
});

subtest("replaced boin", sub {
    my $instance = Klass->new;

    do {
        my $guard = redefine_guard("Klass", "get_boin", sub {
            my $original = shift;
            is ( $instance->$original, "boinboin", "original boin! hoo hoo!" );
            return "not boin";
        });

        is( $instance->get_boin, "not boin", "boin replaced. not boin now." );
    };

    is( $instance->get_boin, "boinboin", "we are boin because out of scope." );
});

done_testing;
