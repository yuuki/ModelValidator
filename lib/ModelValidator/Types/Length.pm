package ModelValidator::Types::Length;
use strict;
use warnings;

use Carp ();

# $cond  #= { is => 4, message => 'is not 4' }
# $value #= 4
sub is_valid {
    my $class = shift;
    my $cond  = shift or Carp::croak 'required cond';
    my $value = shift or Carp::croak 'requried value';
    ref($cond) eq 'HASH' or Carp::croak 'cond must be HASH';

    for my $option (keys %$cond) {
        my $exp = $cond->{$option};
        if ($option eq 'is') {
            return 0 if $value ne $exp;
        }
        elsif ($option eq 'minimum') {
            return 0 if $value < $exp;
        }
        elsif ($option eq 'maximum') {
            return 0 if $value > $exp;
        }
        else {
            Carp::croak "No such option for length: $option";
        }
    }

    return 1;
}

1;
