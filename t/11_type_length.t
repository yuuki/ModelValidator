use strict;
use warnings;
use lib 'lib';

use Test::More;
use Test::Fatal;

use ModelValidator::Types::Length;

subtest is_valid => sub {
    subtest normal => sub {
        ok( ModelValidator::Types::Length->is_valid({ is => 5 }, 'yuuki')       );
        ok( ModelValidator::Types::Length->is_valid({ minimum => 4 }, 'yuuki')  );
        ok( ModelValidator::Types::Length->is_valid({ maximum => 20 }, 'yuuki') );
        ok( ModelValidator::Types::Length->is_valid(
            { minimum => 4, maximum => 20 }, 'yuuki'
        ) );
    };

    subtest invalid => sub {
        ok(! ModelValidator::Types::Length->is_valid({ is => 0 }, 'yuuki')       );
        ok(! ModelValidator::Types::Length->is_valid({ minimum => 10 }, 'yuuki') );
        ok(! ModelValidator::Types::Length->is_valid({ maximum => 1  }, 'yuuki') );
        ok(! ModelValidator::Types::Length->is_valid(
            { minimum => 10, maximum => 1 }, 'yuuki'
        ) );
    };

    subtest typo => sub {
        like exception {
            ModelValidator::Types::Length->is_valid({ mmmum => 10 }, 'yuuki');
        }, qr(^No such option for length: mmmum);
    };

    subtest 'cond is not HASH' => sub {
        like exception {
            ModelValidator::Types::Length->is_valid(mmmum => 10, 'yuuki');
        }, qr(^cond must be HASH);
    };

    subtest 'emoty args' => sub {
        like exception {
            ModelValidator::Types::Length->is_valid(undef, 'yuuki');
        }, qr(^required cond);
        like exception {
            ModelValidator::Types::Length->is_valid({}, undef);
        }, qr(^required value);
    };
};

done_testing;
