package AST;

use AST::Feature;

sub new {
	my $class = shift;
	my $self = {
		FEATURES => []
	};
	bless ($self,$class);
	return $self;
}

sub add_feature {
	my ($self,$feature) = @_;
	my @features = $self->{FEATURES};
	push @features, $feature;
}

1;