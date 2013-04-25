package ModelValidator::Types::Length;
use strict;
use warnings;

use Carp qw(croak);

# $cond  #= { is => 4, message => 'is not 4' }
# $value #= 4
sub is_valid {
    my $class = shift;
    my $cond  = shift or croak 'required cond';
    my $value = shift or croak 'required value';
    ref($cond) eq 'HASH' or croak 'cond must be HASH';

    for my $option (keys %$cond) {
        my $exp = $cond->{$option};
        if ($option eq 'is') {
            return 0 unless length($value) eq $exp;
        }
        elsif ($option eq 'minimum') {
            return 0 unless length($value) >= $exp;
        }
        elsif ($option eq 'maximum') {
            return 0 unless length($value) <= $exp;
        }
        else {
            Carp::croak "No such option for length: $option";
        }
    }

    return 1;
}

1;
