package AST::Feature;
use strict;

use AST::Scenario;

sub new {
	my $self = {
		NAME      => undef,
		HEADER    => undef,
		SCENARIOS => []
	};
	bless $self;
	return $self;
}

sub name {
	my $self = shift;
	if (@_) { $self->{NAME} = shift; }
	return $self->{NAME};
}

sub header {
	my $self = shift;
	if (@_) {
		$self->{HEADER} = shift;
		$self->{HEADER} =~ s/^[\s\t]*/  /gsm;
	}
	return $self->{HEADER};
}

sub add_scenario {
	my ($self,$scenario) = @_;
	push @{ $self->{SCENARIOS} }, $scenario;
}

sub scenarios {
	my $self = shift;
	return @{ $self->{SCENARIOS} };
}

sub execute {
	my $self = shift;
	my $matchers = shift; # reference to a hash of matchers
	for my $scenario ($self->scenarios()) {
		$scenario->execute($matchers);
	}
}

1;
