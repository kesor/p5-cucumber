package Calculator;

sub new {
	my $self = {
		STACK => []
	};
	bless $self;
	return $self;	
}

sub push {
	my $self = shift;
	push @{ $self->{STACK} }, shift;
}

sub send {
	my $self = shift;
	my $op = shift;

	my $first = CORE::pop @{ $self->{STACK} };
	my $second = CORE::pop @{ $self->{STACK} };
	my $result = eval("$first $op $second");
	CORE::push @{ $self->{STACK} }, $result;
	return $result;
}

1;