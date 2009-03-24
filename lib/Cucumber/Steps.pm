package Steps;
use diagnostics;
use warnings;
use strict;

sub Before(&) {
	my $callback = shift;
	$callback->();
}

sub After(&) {
	my $callback = shift;
	$callback->();
}

# creator of matchers, commonly known as StoreMatcher
# but abbreviated into just 'sm'
sub sm($&) {
  my ($regexp, $callback) = @_;
  $matchers{$regexp} = $callback;
}

sub Given($;&) {
  if (ref($_[0]) eq "Regexp") {
    my ($regexp, $callback) = @_;
    $regexp = qr{Given $regexp};
    sm($regexp,\&$callback);
  } else {
    execute_match("Given ".$_[0]);
  }
}

sub When($;&) {
  if (ref($_[0]) eq "Regexp") {
    my ($regexp, $callback) = @_;
    $regexp = qr{When $regexp};
    sm($regexp,\&$callback);
  } else {
    execute_match("When ".$_[0]);
  }
}

sub Then($;&) {
  if (ref($_[0]) eq "Regexp") {
    my ($regexp, $callback) = @_;
    $regexp = qr{Then $regexp};
    sm($regexp,\&$callback);
  } else {
    execute_match("Then ".$_[0]);
  }
}

1;