package Cucumber;
#use diagnostics;
#use warnings;
#use strict;

use Cucumber::Steps;

require Exporter;
@ISA = qw(Exporter);
@EXPORT = qw(Before After Given When Then);

1;