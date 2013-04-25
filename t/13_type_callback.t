use strict;
use warnings;
use lib 'lib' => 't/lib';

use Test::More;
use Test::Fatal;
use Test::Mock::Guard qw(mock_guard);

use ModelValidator::Types::Callback;

subtest is_valid => sub {
    ok( ModelValidator::Types::Callback->is_valid(
        { if => sub { uc($_) eq 'YUUKI'} }, 'yuuki')
    );
    ok(! ModelValidator::Types::Callback->is_valid(
        { if => sub { uc($_) ne 'YUUKI'} }, 'yuuki')
    );
};

done_testing;
