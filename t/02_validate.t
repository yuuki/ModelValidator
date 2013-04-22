use strict;
use warnings;
use lib 'lib';

use Test::More;
use Test::Fatal;
use Test::Mock::Guard qw(mock_guard);

use ModelValidator;

subtest validate => sub {

    subtest normal => sub {
        my $guard_l = mock_guard('ModelValidator::Types::Length', {
            is_valid => 1
        });
        my $guard_p = mock_guard('ModelValidator::Types::Presence', {
            is_valid => 1
        });

        my $params = {
            name => {
                presence => 1,
                length => { maximum => 20, minimum => 4 },
            },
            description => {
                presence => { message => 'need to be input' },
            },
        };
        my $v = ModelValidator->new($params);
        my $attrs = $v->validate($params);
        is_deeply $attrs, $params;
    };

    subtest 'error message' => sub {
        my $guard_l = mock_guard('ModelValidator::Types::Length', {
            is_valid => 0
        });
        my $v = ModelValidator->new({
            name => {
                length => { is => '20', message => 'is not 20' }
            },
        });
        $v->validate({ name => 'yuuki' });
        is_deeply $v->errors, ['is not 20'];
    };
};


done_testing;
