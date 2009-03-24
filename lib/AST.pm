package AST;
use diagnostics;
use warnings;
use strict;

use AST::Feature;

sub new {
	my $self = {
		FEATURES => []
	};
	bless $self;
	return $self;
}

sub add_feature {
	my ($self,$feature) = @_;
	push @{ $self->{FEATURES} }, $feature;
}

sub features {
	my $self = shift;
	return @{ $self->{FEATURES} };
}

sub execute {
	my $self = shift;
	my $matchers = shift; # reference to a hash of matchers
	for my $feature ($self->features()) {
		$feature->execute($matchers);
	}
}

1;
