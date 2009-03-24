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
	my $steps_dh = DirHandle->new($steps_dir);
	my @step_files = grep { /_steps.pl$/i } $steps_dh->read();
	for my $steps_file (@step_files) {
		do $steps_file;
	}

	# parse the text files with feature specs
	my ($result,$tree);
	my $dh = DirHandle->new($features_dir);
	my @files = grep { /.feature$/i } $dh->read();
	for my $feature_file (@files) {
		my $parser = new Parser();
		($result,$tree) = $parser->parse( scalar(slurp("$features_dir/$feature_file")) );
	}

	# execute the features
	$tree->execute(\%matchers);
}

1;