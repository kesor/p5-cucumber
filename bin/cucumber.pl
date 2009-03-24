#!/usr/bin/env perl
use warnings;
use strict;
use FindBin qw($RealDir);
use lib "$RealDir/../lib";

use Cucumber::Engine;

Cucumber::Engine->run_features($ARGV[0]);
