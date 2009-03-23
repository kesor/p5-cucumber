package Cucumber::Engine;

use warnings;
use strict;

use DirHandle;
use File::Slurp qw/slurp/;

use Parser;

sub new {
	my $self = {};
	bless $self;
	return $self;
}

sub run_features {
	my $self = shift;

	my $stories_dir = shift;
	$stories_dir =~ s!\\!/!g;
	
	my $features_dir = $stories_dir."/features";
	my $features_lib = $stories_dir."/lib";
	my $steps_dir    = $features_dir."/step_definitions";

	my $steps_dh = DirHandle->new($steps_dir);
	my @step_files = grep { /_steps.pl$/i } $steps_dh->read();
	for my $steps_file (@step_files) {
		do $steps_file;
	}
	
	my ($result,$tree);
	my $dh = DirHandle->new($features_dir);
	my @files = grep { /.feature$/i } $dh->read();
	for my $feature_file (@files) {
		my $parser = new Parser();
		($result,$tree) = $parser->parse( scalar(slurp("$features_dir/$feature_file")) );
	}

	for my $feature ($tree->features) {
		print "\nFeature: ",$feature->name,"\n";
		print $feature->header;
		for my $scenario ($feature->scenarios) {
			print "\n";
			print "  Scenario: ",$scenario->name,"\n";
			for my $step ($scenario->steps) {
				print "    $step\n";
				# execute_match($step);
			}
		}
	}

}

1;