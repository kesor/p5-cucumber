package AST::Scenario;

sub new {
	my $class = shift;
	my $self = {
		NAME  => undef,
		STEPS => []
	};
	bless ($self,$class);
	return $self;
}

sub set_name {
  my ($self,$name) = @_;
  $self->{NAME} = $name;
}

sub add_step {
	my ($self,$step) = @_;
	my @steps = $self->{STEPS};
	push @steps, $step;
}

sub self {
	my $self = shift;
	return \@scenario;
}

1;