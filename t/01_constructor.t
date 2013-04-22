use strict;
use warnings;
use lib 'lib';

use Test::More;
use Test::Fatal;

use ModelValidator;

subtest constructor => sub {

    subtest nornal => sub {
        my $params = {
            name => {
                presence => 1,
                maximum => 20,
                minimum => 4,
            },
            description => {
                presence => { message => 'need to be input' },
            },
        };
        my $v = ModelValidator->new($params);
        if (ok $v) {
            isa_ok $v, 'ModelValidator';
            isa_ok $v->{rule}, 'HASH';
            is_deeply $v->{rule}, $params;
        }
    };

    subtest 'rule is not HASH' => sub {
        like exception {
            ModelValidator->new('hoge');
        }, qr(^rule must be HASH);
    };

    subtest 'empty rule' => sub {
        like exception {
            ModelValidator->new(undef);
        }, qr(^required rule);
    };
};

done_testing;
