package AST::Scenario;
use strict;

sub new {
	my $self = {
		NAME  => undef,
		STEPS => [],
		TAGS => []
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

sub add_tag {
	my ($self,$tag) = @_;
	push @{ $self->{TAGS} }, $tag;
}

sub steps {
	my $self = shift;
	return @{ $self->{STEPS} };
}

sub tags {
	my $self = shift;
	return @{ $self->{TAGS} };
}

1;
