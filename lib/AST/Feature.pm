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
	my ($self,$header) = @_;
	if (@_) { $self->{HEADER} = shift; }
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

1;
