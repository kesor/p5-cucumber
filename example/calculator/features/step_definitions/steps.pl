#!/usr/bin/env perl
use diagnostics;
use warnings;
use strict;

use Test::More 'no_plan';
use Cucumber;

# require the actual working calculator code
# use lib "$steps_dir/../../lib";
use Calculator;

my %s; # state hash

Before(sub {
	$s{calculator} = Calculator->new();
});

After(sub {
});

Given(qr/I have entered (\d+) into the calculator/, sub {
	my($num) = shift;
	$s{calculator}->push($num);
});

When(qr/I press (\w+)/, sub {
	my $op = @_;
	$s{result} = $s{calculator}->send($op);
});

Then(qr/the result should be (.*) on the sceeen/, sub {
	my $result = @_;
	is($s{result}, $result);
});

Then(qr/the result should not be (.*) on the sceeen/, sub {
	my $result = @_;
	isnt($s{result}, $result);
});

1;