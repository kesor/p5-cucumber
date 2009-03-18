package AST::Feature;

use AST::Scenario;

sub new {
	my $class = shift;
	my $self = {
		HEADER    => undef,
		SCENARIOS => []
	};
	bless ($self,$class);
	return $self;
}

sub set_header {
	my ($self,$header) = @_;
	$self->{HEADER} = $header;
}

sub add_scenario {
	my ($self,$scenario) = @_;
	my @scenarios = $self->{SCENARIOS};
	push @scenarios, $scenario;
}

1;