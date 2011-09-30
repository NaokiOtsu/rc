#!perl -w
use strict;
use Test::More tests => 1;

BEGIN {
    use_ok 'Test::Redefine::Guard';
}

diag "Testing Test::Redefine::Guard/$Test::Redefine::Guard::VERSION";
