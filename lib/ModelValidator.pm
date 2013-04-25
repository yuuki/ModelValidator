package ModelValidator;
use strict;
use warnings;
use 5.008005;
our $VERSION = "0.01";

use Carp ();

use ModelValidator::Types::Length;
use ModelValidator::Types::Presence;
use ModelValidator::Types::Callback;

my $BULTINS = [qw(
    presence
    length
    format
    numericality
    callback
)];

my $IS_BULTINS_RE = qr(@{[join '|', @$BULTINS]});

sub new {
    my $class = shift;
    my $rule  = shift or Carp::croak 'required rule';

    if (ref($rule) ne 'HASH') {
        Carp::croak "rule must be HASH";
    }

    return bless {
        rule => $rule, errors => {},
    }, $class;
}

sub validate {
    my ($self, $attrs) = @_;

    if (!defined $attrs || ref($attrs) ne 'HASH') {
        Carp::croak "attrs must be HASH";
    }

    my $rule = $self->{rule};
    for my $attr (keys %$attrs) {
        next if not exists $rule->{$attr};

        my $validation = $rule->{$attr};
        for my $type (keys %$validation) {
            my $cond  = $validation->{$type};
            my $value = $attrs->{$attr};

            if ($type =~ $IS_BULTINS_RE) {
                my $class = 'ModelValidator::Types::' . ucfirst($type);
                my $msg = delete $cond->{message} if ref($cond) eq 'HASH';
                unless ($class->is_valid($cond, $value)) {
                    $self->set_error($attr, $value, $msg) if defined $msg;
                }
            }
            else { #TODO custom type
            }
        }
    }

    return $attrs;
}

sub errors {
    $_[0]->{errors};
}

sub set_error {
    my $self  = shift;
    my $attr  = shift or Carp::croak 'required attr';
    my $value = shift or Carp::croak 'required value';
    my $msg   = shift or Carp::croak 'required msg';

    if (ref($msg) eq 'CODE') {
        local $_ = $value;
        $msg = $msg->();
    }
    $self->{errors}->{$attr} = $msg;
}

1;
__END__

=encoding utf-8

=head1 NAME

ModelValidator - Model Validation utility like ActiveModel validator and Data::Validator

=head1 SYNOPSIS

    use ModelValidator;

    my $params = {
        passwd => 'abcdef',
        description => 'Internet Watcher',
        uri => 'https://metacpan.org/author/yuuki',
    }];
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
    unless ($v->validate($params)) {
        my $errors = $v->errors;
        $errors->{callback}; #= 'https://metacpan.org/author/yuuki is not unique'
    }

=head1 DESCRIPTION

ModelValidator is Model Validation utility like ActiveModel validator and Data::Validator

=head1 LICENSE

Copyright (C) Yuuki Tsubouchi

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Yuuki Tsubouchi E<lt>yuuki@cpan.orgE<gt>

