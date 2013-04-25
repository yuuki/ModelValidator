use strict;
use warnings;
use lib 'lib' => 't/lib';

use Test::More;
use Test::Fatal;

use ModelValidator::Types::Presence;

subtest is_valid => sub {
    ok( ModelValidator::Types::Presence->is_valid(1, 'yuuki') );
    ok( ModelValidator::Types::Presence->is_valid(0, 'yuuki') );
    ok( !ModelValidator::Types::Presence->is_valid(1, '') );
    ok( !ModelValidator::Types::Presence->is_valid(1, undef) );
};

done_testing;
