#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

use Converter;

my $converter = Symbology::Converter->new();
chomp($ARGV[0]);
chomp($ARGV[1]);
#print Dumper $converter->what($ARGV[0]);
print Dumper $converter->convert($ARGV[0],$ARGV[1]);
