package Symbology::Converter;

use strict;
use warnings;

use Convention::CQS;
use Convention::CMS;
#use Convention::Fidessa; Need confirmation on convention
use Convention::NASDAQ::Integrated;

BEGIN {

    our $VERSION = 0.1;

}


sub new {
    my ($class, $info) = @_;
   
    my $self = {
        Check => {
            CQS     => sub { my $x = shift; return Symbology::Convention::CQS->check($x); },
            CMS     => sub { my $x = shift; return Symbology::Convention::CMS->check($x); },
            #FIDESSA => sub { my $x = shift; return Symbology::Convention::Fidessa->check($x); },
            NASINTEGRATED => sub { my $x = shift; return Symbology::Convention::NASDAQ::Integrated->check($x); }
        }, 
        Convert => {
            CQS => sub { my $x = shift; return Symbology::Convention::CQS->convert($x); },
            CMS => sub { my $x = shift; return Symbology::Convention::CMS->convert($x); },
            #FIDESSA => sub { my $x = shift; return Symbology::Convention::Fidessa->convert($x); },
            NASINTEGRATED => sub { my $x = shift; return Symbology::Convention::NASDAQ::Integrated->convert($x); }
        }
    };

    bless ($self, $class);
    return $self;
}

sub what {
    my ($self, $symbol) = @_;
    
    my $returnObj;

    $returnObj->{CQS} = $self->{Check}{CQS}->($symbol);
    delete $returnObj->{CQS} unless defined $returnObj->{CQS};

    $returnObj->{CMS} = $self->{Check}{CMS}->($symbol);
    delete $returnObj->{CMS} unless defined $returnObj->{CMS};

    #$returnObj->{FIDESSA} = $self->{Check}{FIDESSA}->($symbol);
    #delete $returnObj->{FIDESSA} unless defined $returnObj->{FIDESSA};
    
    $returnObj->{NASINTEGRATED} = $self->{Check}{NASINTEGRATED}->($symbol);
    delete $returnObj->{NASINTEGRATED} unless defined $returnObj->{NASINTEGRATED};

    return $returnObj;
}

sub convert {
    my ($self, $symbols, $from, $to) = @_;


    if (ref $symbols eq 'ARRAY') {
        my @convertedsymbols; 
        for my $symbol (@{$symbols}){
            my $fromobj = $self->{Check}{uc($from)}->($symbol);
            return "Invalid format for $from \($symbol\)" unless defined $fromobj;
            my $toobj = $self->{Convert}{uc($to)}->($fromobj);
            push @convertedsymbols, $toobj;
        }
        return @convertedsymbols;
    } else {
        my $fromobj = $self->{Check}{uc($from)}->($symbols);
        return "Invalid format for $from \($symbols\)" unless defined $fromobj;
        my $toobj = $self->{Convert}{uc($to)}->($fromobj);
        return $toobj;
    }
}



1;



=pod

=head1 NAME

Symbology::Converter - Common US Stock market syntax swapper / tester

=head1 SYNOPSIS

    use Symbology::Converter;

    my $converter = Symbology::Converter->new();

    my $symbols = [ 'AAPL WI', 'C PR', 'TEST A' ];
    my $symbol = 'TEST A';

    # Valid convention options CMS, CQS, NASIntegrated

    # Fidessa convention sheet is included but not implemented as the spec given had a bug

    my $converted_symbols =  $converter->convert($symbols, 'CMS', 'CQS' );
    my $converted_symbol  = $converter->convert($symbol, 'CMS', 'CQS' );


    my $what_is = $converter->what($symbol);

=head1 DESCRIPTION

Symbology::Converter is a module that can convert valid symbol syntaxes across 
popular formats from the US Domestic markets. Converter can also test symbols
to provide information about it, such as type, class, and underyling symbol

=head1 USAGE

=head2 convert(symbol(s), FROM, TO)

Converts a symbol from a convetion to another convention

Example:

    $converter->convert('AAPL PR', 'CMS', 'CQS');

    output: AAPLp


=head2 what(symbol)

Tests a symbol of any convention and breaks down its convention if valid


Example:

    $converter->what('AAPLp');

    output:

    'CQS' => {
        'symbol' => 'AAPL',
        'suffix' => 'p',
        'type' => 'Preferred'
    }

=head1 Author

George Tsafas <elb0w@elbowrage.com>

=head1 Support

elb0w on irc.freenode.net #perl


=cut

__END__

