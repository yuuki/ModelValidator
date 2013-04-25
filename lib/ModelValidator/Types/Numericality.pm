package ModelValidator::Types::Numericality;
use strict;
use warnings;

use Carp qw(croak);

sub is_valid {
    my $class = shift;
    my $cond  = shift or croak 'required cond';
    my $value = shift or croak 'required value';

    for my $option (keys %$cond) {
        my $exp = $cond->{$option};
        $exp =~ /[+-]?[\d\.]+/ or croak 'exp must be numeric value';

        if ($option eq 'only_integer') {
            return 1 if $exp == 0;
            return 0 unless $value =~ /^[+-]?\d+$/;
        }
        elsif ($option eq 'gt') {
            return 0 unless $value > $exp;
        }
        elsif ($option eq 'gt_or_eq') {
            return 0 unless $value >= $exp;
        }
        elsif ($option eq 'lt') {
            return 0 unless $value < $exp;
        }
        elsif ($option eq 'lt_or_eq') {
            return 0 unless $value <= $exp;
        }
        elsif ($option eq 'odd') {
            return 1 if $exp == 0;
            return 0 unless $value % 2 != 0;
        }
        elsif ($option eq 'even') {
            return 1 if $exp == 0;
            return 0 unless $value % 2 == 0;
        }
        else {
            Carp::croak "No such option for numericality: $option";
        }
    }

    return 1;
}

1;
