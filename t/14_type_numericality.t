use strict;
use warnings;
use lib 'lib';

use Test::More;
use Test::Fatal;

use ModelValidator::Types::Numericality;

subtest is_valid => sub {

    subtest only_integer => sub {
        ok( ModelValidator::Types::Numericality->is_valid(
            { only_integer => 1 }, '12345',
        ));
        ok( ModelValidator::Types::Numericality->is_valid(
            { only_integer => 1 }, '-23'
        ));
        ok(! ModelValidator::Types::Numericality->is_valid(
            { only_integer => 1 }, '10.5'
        ));
    };

    subtest gt => sub {
        ok( ModelValidator::Types::Numericality->is_valid(
            { gt => 10 }, '12'
        ));
        ok(! ModelValidator::Types::Numericality->is_valid(
            { gt => 10 }, '8'
        ));
    };

    subtest gt_or_eq => sub {
        ok( ModelValidator::Types::Numericality->is_valid(
            { gt_or_eq => 10 }, '12'
        ));
        ok( ModelValidator::Types::Numericality->is_valid(
            { gt_or_eq => 10 }, '10'
        ));
        ok(! ModelValidator::Types::Numericality->is_valid(
            { gt_or_eq => 10 }, '8'
        ));
    };

    subtest lt => sub {
        ok( ModelValidator::Types::Numericality->is_valid(
            { lt => 10 }, '8'
        ));
        ok(! ModelValidator::Types::Numericality->is_valid(
            { lt => 10 }, '10'
        ));
        ok(! ModelValidator::Types::Numericality->is_valid(
            { lt => 10 }, '12'
        ));
    };

    subtest lt_or_eq => sub {
        ok( ModelValidator::Types::Numericality->is_valid(
            { lt_or_eq => 10 }, '8'
        ));
        ok( ModelValidator::Types::Numericality->is_valid(
            { lt_or_eq => 10 }, '10'
        ));
        ok(! ModelValidator::Types::Numericality->is_valid(
            { lt_or_eq => 10 }, '12'
        ));
    };

    subtest odd => sub {
        ok( ModelValidator::Types::Numericality->is_valid(
            { odd => 1 }, '11'
        ));
        ok(! ModelValidator::Types::Numericality->is_valid(
            { odd => 1 }, '10'
        ));
        ok( ModelValidator::Types::Numericality->is_valid(
            { odd => 0 }, '11'
        ));
    };

    subtest even => sub {
        ok( ModelValidator::Types::Numericality->is_valid(
            { even => 1 }, '10'
        ));
        ok(! ModelValidator::Types::Numericality->is_valid(
            { even => 1 }, '11'
        ));
        ok( ModelValidator::Types::Numericality->is_valid(
            { even => 0 }, '10'
        ));
    };

    subtest 'invalid exp' => sub {
        like exception {
            ModelValidator::Types::Numericality->is_valid(
                { gt => 'yuuki' }, '8'
            )
        }, qr(^exp must be numeric value);
    };
};

done_testing;
