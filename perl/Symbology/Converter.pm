package Symbology::Converter;

use strict;
use warnings;

use Convention::CQS;
use Convention::CMS;
use Convention::Fidessa;

# use Convention::NASDAQ::Integrated;


sub new {
    my ($class, $info) = @_;
   
    my $self = {
        Check => {
            CQS     => sub { my $x = shift; return Symbology::Convention::CQS->check($x); },
            CMS     => sub { my $x = shift; return Symbology::Convention::CMS->check($x); },
            FIDESSA => sub { my $x = shift; return Symbology::Convention::Fidessa->check($x); }
        }, 
        Convert => {
            CQS => sub { my $x = shift; return Symbology::Convention::CQS->convert($x); },
            CMS => sub { my $x = shift; return Symbology::Convention::CMS->convert($x); },
            FIDESSA => sub { my $x = shift; return Symbology::Convention::Fidessa->convert($x); }
        }
    };

    bless ($self, $class);
    return $self;
}

sub what {
    my ($self, $symbol) = @_;
    
    my $returnObj;

    $returnObj->{CQS} = $self->{Check}{CQS}->($symbol);
    $returnObj->{CMS} = $self->{Check}{CMS}->($symbol);
    $returnObj->{FIDESSA} = $self->{Check}{FIDESSA}->($symbol);
    

    return $returnObj;
}

sub convert {
    my ($self, $symbol, $from, $to) = @_;

    my $fromobj = $self->{Check}{uc($from)}->($symbol);
    my $toobj = $self->{Convert}{uc($to)}->($fromobj);

    return $toobj;
}



1;
