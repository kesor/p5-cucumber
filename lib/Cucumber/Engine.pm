package Cucumber::Engine;

use warnings;
use strict;

use DirHandle;
use File::Slurp qw/slurp/;

use Parser;

sub run_features {
	my $self = shift;

	my $stories_dir = shift;
	$stories_dir =~ s!\\!/!g;
	
	my $features_dir = $stories_dir."/features";
	my $features_lib = $stories_dir."/lib";
	my $steps_dir    = $features_dir."/step_definitions";

	# hash to be preloaded with steps
	my %matchers;

	# load the matchers hash with steps that run features
	for my $steps_file (grep { /_steps.pl$/i } DirHandle->new($steps_dir)->read()) {
		do $steps_file;
	}

	# parse the text files with feature specs
	for my $feature_file (grep { /.feature$/i } DirHandle->new($features_dir)->read()) {
		my ($result,$tree) = Parser()->new()->parse( scalar(slurp("$features_dir/$feature_file")) );
		# execute feature file
		$tree->execute(\%matchers);
	}

}

1;