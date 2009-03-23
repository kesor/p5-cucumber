#!/usr/bin/env perl
use warnings;
use strict;
use FindBin qw($RealDir);
use lib "$RealDir/../lib";

use Cucumber::Engine;

my $engine = Cucumber::Engine->new();
$engine->run_features($ARGV[0]);
