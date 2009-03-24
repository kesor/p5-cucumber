package AST::Scenario;
use diagnostics;
use warnings;
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

sub execute {
	my $self = shift;
	my $matchers = shift; # reference to a hash of matchers
	for my $step ($self->steps()) {
		for my $regexp (keys %$matchers) {
			if (my @subgroups = ($step =~ $regexp)) {
				$matchers->{$regexp}->(@subgroups);
			}
		}
	}
}
1;
