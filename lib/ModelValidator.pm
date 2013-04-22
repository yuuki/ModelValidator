package ModelValidator;
use strict;
use warnings;
use 5.008005;
our $VERSION = "0.01";



1;
__END__

=encoding utf-8

=head1 NAME

ModelValidator - Model Validation utility like ActiveModel validator and Data::Validator

=head1 SYNOPSIS

    use ModelValidator;

    my $params = [qw(passwd description uri)];
    my $rule = {
        passwd => {
            presence => 1,
            length => { minimum => 6, maximum => 20 },
            format => { with => /^[0-9A-Za-z_@%]{4,}$/ },
            confirmation => true,
        },
        description => {
            presence => { message => 'need to be input' },
            length => { in => 5..100, :allow_blank => true },
        },
        uri => {
            callback => sub {
                my $self = shift;
                $self->{message} = "uniqueness";
                return not YourModel::User->find_by_uri($_);
            },
            default => "",
        },
    };

    my $v = ModelValidator->new($rule);
    unless ($v->validate($params)) {
        my $errors = $v->errors;
    }

=head1 DESCRIPTION

ModelValidator is ...

=head1 LICENSE

Copyright (C) Yuuki Tsubouchi

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Yuuki Tsubouchi E<lt>yuuki@cpan.orgE<gt>

