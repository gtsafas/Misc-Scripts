package Symbology::Converter;

use strict;
use warnings;

use Convention::CQS;
use Convention::CMS;
use Convention::Fidessa;
use Convention::NASDAQ::Integrated;


sub new {
    my ($class, $info) = @_;
   
    my $self = {};

    bless ($self, $class);
    return $self;
}

sub what {
    my ($self, $symbol) = @_;
    
    my $returnObj;
    
    $returnObj->{CQS} = Symbology::Convention::CQS->check($symbol);
    delete $returnObj->{CQS} unless defined $returnObj->{CQS};

    $returnObj->{CMS} = Symbology::Convention::CMS->check($symbol);
    delete $returnObj->{CMS} unless defined $returnObj->{CMS};

    $returnObj->{Fidessa} = Symbology::Convention::Fidessa->check($symbol);
    delete $returnObj->{Fidessa} unless defined $returnObj->{Fidessa};

    $returnObj->{Integrated} = Symbology::Convention::NASDAQ::Integrated->check($symbol);
    delete $returnObj->{Integrated} unless defined $returnObj->{Integrated};

    return $returnObj;
}

sub try_convert {
    my ($self, $symbol, $target) = @_;

    my $data = what($self,$symbol);
    
    for (keys %{$data}){
        next unless defined $data->{$_};

        if ($target eq 'CMS'){
            my $conversion = Symbology::Convention::CMS->giveme($data->{$_});
        }

        if ($target eq 'CQS'){
            my $conversion = Symbology::Convention::CQS->giveme($data->{$_});
        }

        if ($target eq 'Fidessa'){
            my $conversion = Symbology::Convention::Fidessa->giveme($data->{$_});
        }

        if ($target eq 'Integrated'){
            my $conversion = Symbology::Convention::NASDAQ::Integrated->giveme($data->{$_});
        }
    }

    return 'No conversion found';

}

1;
