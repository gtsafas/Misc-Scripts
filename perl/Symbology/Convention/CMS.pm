package Symbology::Convention::CMS;

use strict;
use warnings;

# Enjoying Mastering regular expressions, why not use an example from it?
my $template = {
    'Preferred' => ' PR',
    'Preferred Class' => ' PR=CLASS=',
    'Class' => ' =CLASS=',
    'Preferred when distributed' => ' PRWD',
    'When distributed' => ' WD',
    'Warrants' => ' WS',
    'Warrants Class' => ' WS=CLASS=',
    'Called' => ' CL',
    'Class Called' => ' =CLASSCL',
    'Preferred Called' => ' PRCL',
    'Preferred Class Called' => ' PR=CLASS=CL',
    'Preferred Class When Issued' => ' PR=CLASS=WI',
    'Emerging Company Marketplace' => ' EC',
    'Partial Paid' => ' PP',
    'Convertible' => ' CV',
    'Convertible Called' => ' CVCL',
    'Class Convertible' => ' =CLASS=CV',
    'Preferred Class Convertible' => ' PR=CLASS=CV',
    'Preferred Class When Distributed' => ' PR=CLASS=WD',
    'Rights' => ' RT',
    'Units' => ' U',
    'When Issued' => ' WI',
    'Rights When Issued' => ' RTWI',
    'Preferred When Issued' => ' PRWI',
    'Class When Issued' => ' =CLASS=WI',
    'Warrant When Issued' => ' WSWI',
    'TEST Symbol' => ' TEST'
};

sub conversion {
    my ($symbol,$type,$class) = @_;

    $class = $class // '';
    
    my $suffix = $template->{$type};
    die 'Unknown type: ' . $type unless defined $suffix;

    $suffix =~ s/=CLASS=/$class/;

    return $symbol . $suffix;

}

sub check {
    my ($self, $symbol) = @_;

    #Nothing to be done
    return undef if $symbol =~ m/^[A-Z]+$/;

    if ($symbol =~ m/^([A-Z]+)\s(PR)$/){
        return { 
            Type => 'Preferred',
            Prefix => $1,
            Suffix => $2
        }
    }

    if ($symbol =~ m/^([A-Z]+)\s(PR)([A-Z])$/){
        return {
            Type => "Preferred Class",
            Prefix => $1,
            Suffix => $2,
            Class => $3
        }
    }

    if ($symbol =~ m/^([A-Z]+)\s([A-Z])$/) {
        return {
            Type => "Class",
            Prefix => $1,
            Class => $2
        }
    }

    if ($symbol =~ m/^([A-Z]+)\s(PRWD)$/){
        return {
            Type => 'Preferred when distributed',
            Prefix => $1,
            Suffix => $2
        }
    }

    if ($symbol =~ m/^([A-Z]+)\s(WD)$/){
        return {
            Type => 'When distributed',
            Prefix => $1,
            Suffix => $2
        }
    }

    if ($symbol =~ m/^([A-Z]+)\s(WS)$/){
        return {
            Type => 'Warrants',
            Prefix => $1,
            Suffix => $2
        }
    }

    if ($symbol =~ m/^([A-Z]+)\s(WS)([A-Z])$/){
        return {
            Type => "Warrants Class",
            Prefix => $1,
            Suffix => $2,
            Class => $3
        }
    }

    if ($symbol =~ m/^([A-Z]+)\s(CL)$/){
        return {
            Type => 'Called',
            Prefix => $1,
            Suffix => $2
        }
    }
    
    if ($symbol =~ m/^([A-Z]+)\s([A-Z])(CL)$/){
        return {
            Type => "Class Called",
            Prefix => $1,
            Suffix => $3,
            Class => $2
        }
    }

    if ($symbol =~ m/^([A-Z]+)\s(PRCL)$/){
        return {
            Type => 'Preferred Called',
            Prefix => $1,
            Suffix => $2
        }
    }

    if ($symbol =~ m/^([A-Z]+)\s(PR([A-Z])CL)$/){
        return {
            Type => "Preferred Class Called",
            Prefix => $1,
            Suffix => $2,
            Class => $3
        }

    }

    if ($symbol =~ m/^([A-Z]+)\s(PR([A-Z])WI)$/){
        return {
            Type => "Preferred Class When Issued",
            Prefix => $1,
            Suffix => $2,
            Class => $3
        }
    }

    if ($symbol =~ m/^([A-Z]+)\s(EC)$/){
        return {
            Type => 'Emerging Company Marketplace',
            Prefix => $1,
            Suffix => $2
        }
    }

    if ($symbol =~ m/^([A-Z]+)\s(PP)$/){
        return {
            Type => 'Partial Paid',
            Prefix => $1,
            Suffix => $2
        }
    }

    if ($symbol =~ m/^([A-Z]+)\s(CV)$/){
        return {
            Type => 'Convertible',
            Prefix => $1,
            Suffix => $2
        }
    }

    if ($symbol =~ m/^([A-Z]+)\s(CVCL)$/){
        return {
            Type => 'Convertible Called',
            Prefix => $1,
            Suffix => $2
        }
    }

    if ($symbol =~ m/^([A-Z]+)\s([A-Z])(CV)$/){
        return {
            Type => "Class Convertible",
            Prefix => $1,
            Suffix => $3,
            Class => $2
        }
    }

    if ($symbol =~ m/^([A-Z]+)\s(PR([A-Z])CV)$/){
        return {
            Type => "Preferred Class Convertible",
            Prefix => $1,
            Suffix => $2,
            Class => $3
        }
    }

    if ($symbol =~ m/^([A-Z]+)\s(PR([A-Z])WD)$/){
        return {
            Type => "Preferred Class When Distributed",
            Prefix => $1,
            Suffix => $2,
            Class => $3
        }
    }

    if ($symbol =~ m/^([A-Z]+)\s(RT)$/){
        return {
            Type => 'Rights',
            Prefix => $1,
            Suffix => $2
        }
    }


    if ($symbol =~ m/^([A-Z]+)\s(U)$/){
        return {
            Type => 'Units',
            Prefix => $1,
            Suffix => $2
        }
    }

    if ($symbol =~ m/^([A-Z]+)\s(WI)$/){
        return {
            Type => 'When Issued',
            Prefix => $1,
            Suffix => $2
        }
    }

    if ($symbol =~ m/^([A-Z]+)\s(RTWI)$/){
        return {
            Type => 'Rights When Issued',
            Prefix => $1,
            Suffix => $2
        }
    }

    if ($symbol =~ m/^([A-Z]+)\s(PRWI)$/){
        return {
            Type => 'Preferred When Issued',
            Prefix => $1,
            Suffix => $2
        }
    }

    if ($symbol =~ m/^([A-Z]+)\s([A-Z])(WI)$/){
        return {
            Type => "Class When Issued",
            Prefix => $1,
            Suffix => $3,
            Class => $2
        }
    }

    if ($symbol =~ m/^([A-Z]+)\s(WSWI)$/){
        return {
            Type => 'Warrant When Issued',
            Prefix => $1,
            Suffix => $2
        }
    }

    if ($symbol =~ m/^([A-Z]+)\s(TEST)$/){
        return {
            Type => 'TEST Symbol',
            Prefix => $1,
            Suffix => $2
        }
    }

    return undef;
}

sub giveme {
    my ($self, $data) = @_;
    use Data::Dumper;

    if (exists $data->{Class}){
        return conversion($data->{Prefix},$data->{Type},$data->{Class});
    } else {
        return conversion($data->{Prefix},$data->{Type});
    }
}

1;
