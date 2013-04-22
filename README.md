# NAME

ModelValidator - Model Validation utility like ActiveModel validator and Data::Validator

# SYNOPSIS

```perl
use ModelValidator;

my $attrs = [qw(passwd description uri)];
my $rule = {
    passwd => {
        presence => 1,
        length => { minimum => 6, maximum => 20 },
        format => { with => /^[0-9A-Za-z_@%]{4,}$/ },
    },
    description => {
        presence => { message => 'need to be input' },
        length => { minimum => 1, maximum => 200 },
    },
    uri => {
        callback => {
            if => sub {
                my $self = shift;
                return not YourModel::User->find_by_uri($_);
            },
            message => sub { $_ is not unique },
        },
    },
};

my $v = ModelValidator->new($rule);
unless ($v->validate($attrs)) {
    my $errors = $v->errors;
}
```

# DESCRIPTION

ModelValidator is Model Validator with mixed interface of both ActiveModel validator and Data::Validator.

# LICENSE

Copyright (C) Yuuki Tsubouchi

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

Yuuki Tsubouchi <yuuki@cpan.org>
