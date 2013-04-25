use strict;
use warnings;
use lib 'lib' => 't/lib';

use Test::More;
use Test::Fatal;

use ModelValidator::Types::Format;

subtest is_valid => sub {

    subtest with => sub {
        ok( ModelValidator::Types::Format->is_valid(
            { with => qr/\d+/ }, '12345'
        ));
        ok(! ModelValidator::Types::Format->is_valid(
            { with => qr/\d+/ }, 'yuuki'
        ));
        like exception {
            ModelValidator::Types::Format->is_valid(
                { with => q/\d+/ }, '-23'
            );
        }, qr(^exp is not Regexp)
    };

};

done_testing;
