package Symbology::Convention::CQS;

use strict;
use warnings;

# Enjoying Mastering regular expressions, why not use an example from it?
my $template = {
    'Preferred' => 'p',
    'Preferred Class' => 'p=CLASS=',
    'Class' => '/=CLASS=',
    'Preferred when distributed' => 'p/WD',
    'When distributed' => '/WD',
    'Warrants' => '/WS',
    'Warrants Class' => '/WS/=CLASS=',
    'Called' => '/CL',
    'Class Called' => '/=CLASS/CL',
    'Preferred Called' => 'p/CL',
    'Preferred Class Called' => 'p=CLASS=/CL',
    'Preferred Class When Issued' => 'p=CLASS=w',
    'Emerging Company Marketplace' => '/EC',
    'Partial Paid' => '/PP',
    'Convertible' => '/CV',
    'Convertible Called' => '/CV/CL',
    'Class Convertible' => '/=CLASS=/CV',
    'Preferred Class Convertible' => 'p=CLASS=/CV',
    'Preferred Class When Distributed' => 'p=CLASS=/WD',
    'Rights' => 'r',
    'Units' => '/U',
    'When Issued' => 'w',
    'Rights When Issued' => 'rw',
    'Preferred When Issued' => 'pw',
    'Class When Issued' => '/=CLASS=w',
    'Warrant When Issued' => '/WSw',
    'TEST Symbol' => '/TEST'
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

    return unless defined $symbol;

    if ($symbol =~ m/(^[A-Z]+)(p)$/){
        return {
            Type => 'Preferred',
            Prefix => $1,
            Suffix => $2
        }
    }

    if ($symbol =~ m/^([A-Z]+)(p)([A-Z])$/){
        return {
            Type => "Preferred Class",
            Prefix => $1,
            Suffix => $2,
            Class => $3
        }
    }

    if ($symbol =~ m/^([A-Z]+)\/([A-Z])$/) {
        return {
            Type => "Class",
            Prefix => $1,
            Class => $2
        }
    }

    if ($symbol =~ m/^[A-Z]+(p\/WD)$/){
        return {
            Type => 'Preferred when distributed',
            Prefix => $1,
            Suffix => $2
        }

    }

    if ($symbol =~ m/(^[A-Z]+)\/(WD)$/){
        return {
            Type => 'When distributed',
            Prefix => $1,
            Suffix => $2
        }
    }

    if ($symbol =~ m/(^[A-Z]+)\/(WS)$/){
        return {
            Type => 'Warrants',
            Prefix => $1,
            Suffix => $2
        }
    }

    if ($symbol =~ m/(^[A-Z]+)\/(WS\/([A-Z]))$/){
        return {
            Type => "Warrants Class",
            Prefix => $1,
            Suffix => $2,
            Class => $3
        }
    }

    if ($symbol =~ m/(^[A-Z]+)\/(CL)$/){
        return {
            Type => 'Called',
            Prefix => $1,
            Suffix => $2
        }
    }
    
    if ($symbol =~ m/(^[A-Z]+)\/([A-Z])\/(CL)$/){
        return {
            Type => "Class Called",
            Prefix => $1,
            Suffix => $3,
            Class => $2
        }
    }

    if ($symbol =~ m/(^[A-Z]+)(p\/CL)$/){
        return {
            Type => 'Preferred Called',
            Prefix => $1,
            Suffix => $2
        }
    }

    if ($symbol =~ m/(^[A-Z]+)(p([A-Z])\/CL)$/){
        return {
            Type => "Preferred Class Called",
            Prefix => $1,
            Suffix => $2,
            Class => $3
        }
    }

    if ($symbol =~ m/(^[A-Z]+)(p([A-Z])w)$/){
        return {
            Type => "Preferred Class When Issued",
            Prefix => $1,
            Suffix => $2,
            Class => $3
        }
    }

    if ($symbol =~ m/(^[A-Z]+)\/(EC)$/){
        return {
            Type => 'Emerging Company Marketplace',
            Prefix => $1,
            Suffix => $2
        }
    }

    if ($symbol =~ m/(^[A-Z]+)\/(PP)$/){
        return {
            Type => 'Partial Paid' ,
            Prefix => $1,
            Suffix => $2
        }
    }

    if ($symbol =~ m/(^[A-Z]+)\/(CV)$/){
        return {
            Type => 'Convertible',
            Prefix => $1,
            Suffix => $2
        }
    }

    if ($symbol =~ m/(^[A-Z]+)\/(CV\/CL)$/){
        return {
            Type => 'Convertible Called' ,
            Prefix => $1,
            Suffix => $2
        }
    }

    if ($symbol =~ m/(^[A-Z]+)\/([A-Z])\/(CV)$/){
        return {
            Type => "Class Convertible",
            Prefix => $1,
            Suffix => $3,
            Class => $2
        }
    }

    if ($symbol =~ m/(^[A-Z]+)(p([A-Z])\/CV)$/){
        return {
            Type => "Preferred Class Convertible",
            Prefix => $1,
            Suffix => $2,
            Class => $3
        }
    }

    if ($symbol =~ m/(^[A-Z]+)(p([A-Z])\/WD)$/){
        return {
            Type => "Preferred Class When Distributed",
            Prefix => $1,
            Suffix => $2,
            Class => $3
        }
    }

    if ($symbol =~ m/^([A-Z]+)(r)$/){
        return {
            Type => 'Rights',
            Prefix => $1,
            Suffix => $2
        }
    }

    if ($symbol =~ m/^([A-Z]+)\/(U)$/){
        return {
            Type => 'Units',
            Prefix => $1,
            Suffix => $2
        }
    }

    if ($symbol =~ m/^([A-Z]+)(w)$/){
        return {
            Type => 'When Issued',
            Prefix => $1,
            Suffix => $2
        }
    }

    if ($symbol =~ m/(^[A-Z]+)(rw)$/){
        return {
            Type => 'Rights When Issued',
            Prefix => $1,
            Suffix => $2
        }
    }

    if ($symbol =~ m/(^[A-Z]+)(pw)$/){
        return {
            Type => 'Preferred When Issued',
            Prefix => $1,
            Suffix => $2
        }
    }

    if ($symbol =~ m/(^[A-Z]+)\/([A-Z])(w)$/){
        return {
            Type => "Class When Issued",
            Prefix => $1,
            Suffix => $3,
            Class => $2
        }
    }

    if ($symbol =~ m/(^[A-Z]+)\/(WSw)$/){
        return {
            Type => 'Warrant When Issued',
            Prefix => $1,
            Suffix => $2
        }
    }

    if ($symbol =~ m/(^[A-Z]+)\/(TEST)$/){
        return {
            Type => 'TEST Symbol' ,
            Prefix => $1,
            Suffix => $2
        }
    }

    return undef;
}

sub giveme {
    my ($self, $data) = @_;

    if (exists $data->{Class}){
        return conversion($data->{Prefix},$data->{Type},$data->{Class});
    } else {
        return conversion($data->{Prefix},$data->{Type});
    }
}

1;
