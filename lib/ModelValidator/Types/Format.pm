package ModelValidator::Types::Format;
use strict;
use warnings;

use Carp qw(croak);

sub is_valid {
    my $class = shift;
    my $cond  = shift or croak 'required cond';
    my $value = shift or croak 'required value';

    for my $option (keys %$cond) {
        my $exp = $cond->{$option};

        if ($option eq 'with') {
            if (ref($exp) ne 'Regexp') {
                croak "exp is not Regexp: $exp";
            }
            return 0 unless $value =~ $exp;
        }
        else {
            Carp::croak "No such option for format: $option";
        }
    }

    return 1;
}

1;
