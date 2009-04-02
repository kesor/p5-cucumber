package Cucumber::Engine;
use diagnostics;
use warnings;
use strict;

use DirHandle;
use File::Slurp qw/slurp/;

use Cucumber::Parser;

sub run_features {
	my $self = shift;

	my $stories_dir = shift;
	$stories_dir =~ s!\\!/!g;
	
	my $features_dir = $stories_dir."/features";
	my $features_lib = $stories_dir."/lib";
	our $steps_dir    = $features_dir."/step_definitions";

	# hash to be preloaded with steps
	our %matchers;

	# load the matchers hash with steps that run features
	# hardcoded to be "steps.pl" as the initial loader file
	require "$steps_dir/steps.pl";
	
	# parse the text files with feature specs
	for my $feature_file (grep { /.feature$/i } DirHandle->new($features_dir)->read()) {
		my ($result,$tree) = Cucumber::Parser->new()->parse( scalar(slurp("$features_dir/$feature_file")) );
		# execute feature file
		$tree->execute(\%matchers);
	}
}

1;
