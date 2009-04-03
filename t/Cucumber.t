package Cucumber::Test;
use strict;
use warnings;

use base 'Test::Class';
use Test::More;

Test::Class->runtests() unless caller;

sub startup : Test(startup => 2) {
      use_ok('Cucumber');
      can_ok('Cucumber','new');
}


