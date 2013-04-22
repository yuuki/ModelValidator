package ModelValidator::Types::Callback;
use utf8;
use strict;
use warnings;

use Carp qw(croak);

sub is_valid {
    my $class = shift;
    my $cond  = shift or croak 'requried cond';
    my $value = shift;
    ref($cond) eq 'HASH' or croak 'cond must be HASH';

    for my $option (keys %$cond) {
        if ($option eq 'if') {
            my $coderef = $cond->{$option};
            local $_ = $value;
            return $coderef->();
        }
        else {
            croak "No such option for callback: $option";
        }
    }
    return 0;
}

1;
