#!/usr/bin/env perl
=head1 Example of Perl Cucumber
=cut
use warnings;
use strict;
use Test::More 'no_plan';

# utility func to trim whitespace from beginning/end of strings
sub trim {
  my($str) = shift =~ m/^\s*(.+?)\s*$/i;
  defined $str ? return $str : return '';
}

my $story = <<EOF
Feature: Dealing with mushrooms
  In order to know the effect of evil poisonous mushrooms
  We will test the effects of eating mushrooms on little children

  Scenario: Mushrooms are bad for you, they kill boys
    Given a live boy
    And a live girl
    When he ate a mushroom
    Then he was a dead boy

  Scenario: Mushrooms are bad for girls too
    Given a live girl
    When she ate a mushroom
    Then she was a dead girl

EOF
;

# empty hash to hold match strings/regexp and
# anonymous functions created by Given/When/Then
my %matchers;

# creator of matchers, commonly known as StoreMatcher
# but abbreviated into just 'sm'
sub sm {
  my $match_string = shift;
  my $anony_func = shift;
  $matchers{$match_string} = $anony_func;
}

#
# hash to store variables that need to remember
# their state across the Given/When/Then scenarios
#
my %state;
#
# the code behind the story
#
sm(qr/Given a (.*)/,sub {
  my @params = shift;
  $state{human} = $params[0];
});
sm(qr/When s?he ate a mushroom/,sub {
  $state{human} =~ s/live/dead/;
});
sm(qr/Then s?he was a (.*)/,sub {
  my @params = shift;
  print '- ';
  is($state{human},$params[0],$params[0]);
});

#
# THE engine!
#
my $last_first_word;
foreach my $line (split("\n",$story)) {
  print $line, " ";
  $line = trim($line);

  # Handle the case for "And":
  # first, remember 'Given' or 'When' or 'Then'
  # then later, replace 'And' when it shows up
  if ($line =~ /^(Given|When|Then)\W+/) {
    $last_first_word = $1;
  }
  if ($line =~ /^And/) {
    $line =~ s/^And(\W+)/$last_first_word$1/;
  }

  # tries to match current line with any of the previously stored matchers
  foreach my $key (keys %matchers) {
    if ($line =~ $key) {
      # create an array that includes all matches of /$key/ against $line
      # $#+ is the number of matches in the last regexp
      # @- is an array containing subgroup beginnings (used as $-[$m])
      # @+ is an array containing subgroup ending (used as $+[$m])
      # substr gets $line, offset and length (calculated by end minus beginning)
      my @subgroups;
      foreach my $m ( 1 .. $#+ ) {
        push @subgroups, substr($line,$-[$m],$+[$m]-$-[$m])
      }
      $matchers{$key}->(@subgroups);
    }
  }
  print "\n";
}
