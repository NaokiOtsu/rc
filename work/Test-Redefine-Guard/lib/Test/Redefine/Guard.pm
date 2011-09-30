package Test::Redefine::Guard;
use 5.008_001;
use strict;
use warnings;

use parent qw/Exporter/;

our $VERSION = '0.01';
our @EXPORT_OK = qw/redefine_guard/;

use Data::Util qw/get_code_ref install_subroutine/;
use Scope::Guard qw/scope_guard/;


sub redefine_guard {
    my ($package, $subname, $subref) = @_;

    my $original = get_code_ref($package, $subname);

    no warnings 'redefine';
    install_subroutine($package, +{
        $subname => sub {
            $subref->($original, @_);
        }
    });

    return scope_guard(sub {
        install_subroutine($package, +{
            $subname => $original
        });
    });
}


1;
__END__

=head1 NAME

Test::Redefine::Guard - Perl extention to do something

=head1 VERSION

This document describes Test::Redefine::Guard version 0.01.

=head1 SYNOPSIS

    use Test::Redefine::Guard;

=head1 DESCRIPTION

# TODO

=head1 INTERFACE

=head2 Functions

=head3 C<< hello() >>

# TODO

=head1 DEPENDENCIES

Perl 5.8.1 or later.

=head1 BUGS

All complex software has bugs lurking in it, and this module is no
exception. If you find a bug please either email me, or add the bug
to cpan-RT.

=head1 SEE ALSO

L<perl>

=head1 AUTHOR

Naosuke Yokoe E<lt>yokoe.naosuke@dena.jpE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright (c) 2011, Naosuke Yokoe. All rights reserved.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
