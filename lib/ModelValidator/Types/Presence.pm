package ModelValidator::Types::Presence;
use strict;
use warnings;

use Carp qw(croak);

sub is_valid {
    my $class = shift;
    my $cond  = shift;
    my $value = shift;

    defined $cond or croak 'required cond';

    if ($cond eq 1 && not $value) {
        return 0;
    }
    return 1;
}

1;
