#!/usr/bin/env perl

use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  NAME         => 'Symbology::Converter',
  VERSION_FROM => 'lib/Symbology/Converter.pm',
  PREREQ_PM    => {},
  AUTHOR       => 'George Tsafas <elb0w@elbowrage.com>'
);
