package AST;
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
	return $self->{FEATURES};
}

1;