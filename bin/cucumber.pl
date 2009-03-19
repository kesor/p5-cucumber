#!/usr/bin/env perl
use warnings;
use strict;
use FindBin qw($RealDir);
use lib '$RealDir/../lib';

use Cucumber;

use Getopt::Std;
$Getopt::Std::STANDARD_HELP_VERSION = 1;

# hash for command line options
my %opts;

getopt('', \%opts);

run_features($ARGV[0]);
