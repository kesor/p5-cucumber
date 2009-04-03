package Cucumber;
use diagnostics;
use warnings;
use strict;

use Cucumber::Steps;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw(Before After Given When Then);

sub new {
      my $self = bless {};
}

1;
