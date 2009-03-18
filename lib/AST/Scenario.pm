package AST::Scenario;
use strict;

sub new {
	my $self = {
		NAME  => undef,
		STEPS => []
	};
	bless $self;
	return $self;
}

sub name {
	my $self = shift;
	if (@_) { $self->{NAME} = shift; }
	return $self->{NAME};
}

sub add_step {
	my ($self,$step) = @_;
	push @{ $self->{STEPS} }, $step;
}

sub steps {
	my $self = shift;
	return @{ $self->{STEPS} };
}

1;
