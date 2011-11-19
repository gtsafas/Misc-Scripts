#!/usr/bin/perl

use strict;
use warnings;

use lib '.', 'Symbology';
use Symbology::Converter;
use Data::Dumper;


my $x = Symbology::Converter->new();

print Dumper $x->what('AAPL-CL');

my $what = $x->convert('AAPL-CL', 'Fidessa', 'NASIntegrated');

print Dumper $what;

