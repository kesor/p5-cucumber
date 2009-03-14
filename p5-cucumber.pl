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
    Given a live boy in a forest
    When he ate a mushroom
    Then he was a dead boy in a forest

  Scenario: Mushrooms are bad for girls too
    Given a live girl in a forest
    When she ate a mushroom
    Then she was a dead girl in a forest

EOF
;

# empty hash to hold match strings/regexp and
# anonymous functions created by Given/When/Then
my %matchers;

# creator of matchers, commonly known as StoreMatcher
# but abbreviated into just 'sm'
sub sm($&) {
  my ($regexp, $callback) = @_;
  $matchers{$regexp} = $callback;
}
sub Given($&) {
  my ($regexp, $callback) = @_;
  $regexp = qr{Given $regexp};
  sm($regexp,\&$callback);
}
sub When($&) {
  my ($regexp, $callback) = @_;
  $regexp = qr{When $regexp};
  sm($regexp,\&$callback);
}
sub Then($&) {
  my ($regexp, $callback) = @_;
  $regexp = qr{Then $regexp};
  sm($regexp,\&$callback);
}

#
# hash to store variables that need to remember
# their state across the Given/When/Then scenarios
#
my %state;
#
# the code behind the story
#
Given qr/(.*) in (.*)/, sub {
  my ($description,$location) = @_;
  $state{human} = $description;
  $state{location} = $location;
};

When qr/s?he ate (.*)/, sub {
  my $item = shift;
  if ($item eq 'a mushroom') {
    $state{human} =~ s/live/dead/;
  }
};

Then qr/s?he was (.*) in (.*)/, sub {
  my ($description,$location) = @_;
  is($state{human},$description,$description);
  is($state{location},$location,$location);
};

#
# THE engine!
#
my $last_first_word;
foreach my $line (split("\n",$story)) {
  print $line, "\n";
  $line = trim($line);

  # Handle the case for "And":
  # first, remember 'Given' or 'When' or 'Then'
  if ($line =~ /^(Given|When|Then)\W+/) {
    $last_first_word = $1;
  }
  # then later, replace 'And' when it shows up
  if ($line =~ /^And/) {
    $line =~ s/^And(\W+)/$last_first_word$1/;
  }

  # match regexps in %matchers against subgroups
  # and call the callback function
  foreach my $regexp (keys %matchers) {
    if (my @subgroups = ($line =~ $regexp)) {
      $matchers{$regexp}->(@subgroups);
      last;
    }
  }
}
