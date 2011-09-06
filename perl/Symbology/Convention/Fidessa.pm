package Symbology::Convention::Fidessa;

use strict;
use warnings;

# Enjoying Mastering regular expressions, why not use an example from it?
my $template = {
    'Preferred' => '-',
    'Preferred Class' => '-=CLASS=',
    'Class' => '.=CLASS=',
    'Preferred when distributed' => '-WD',
    'When distributed' => '!W',
    'Warrants' => '+',
    'Warrants Class' => '+=CLASS=',
    'Called' => '!',
    'Class Called' => '.=CLASS=L',
    'Preferred Called' => '-CL',
    'Preferred Class Called' => '-=CLASS=L',
    'Preferred Class When Issued' => '-=CLASS=*',
    'Emerging Company Marketplace' => '!EC',
    'Partial Paid' => '!PP',
    'Convertible' => '!V',
    'Convertible Called' => '!VL',
    'Class Convertible' => '.=CLASS=V',
    'Preferred Class Convertible' => '-=CLASS=V',
    'Preferred Class When Distributed' => '-=CLASS=WD',
    'Rights' => '!R',
    'Units' => '.U',
    'When Issued' => '*',
    'Rights When Issued' => '!R*',
    'Preferred When Issued' => '-*',
    'Class When Issued' => '.=CLASS=*',
    'Warrant When Issued' => '+*',
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

    if ($symbol =~ m/^([A-Z]+)(-)$/){
        return {
            Type => 'Preferred',
            Prefix => $1,
            Suffix => $2
        }
    }

    if ($symbol =~ m/^([A-Z]+)(-([A-Z]))$/){
        return { 
            Type => "Preferred Class",
            Prefix => $1,
            Suffix => $2,
            Class => $3
        }
    }

    if ($symbol =~ m/^([A-Z]+)(\.([A-Z]))$/) {
        return { 
            Type => "Class",
            Prefix => $1,
            Suffix => $2,
            Class => $3
        }
    }

    if ($symbol =~ m/^([A-Z]+)(-WD)$/){
    return {
            Type => 'Preferred when distributed',
            Prefix => $1,
            Suffix => $2
        }
    }

    if ($symbol =~ m/^([A-Z]+)(!W$)/){
        return {
            Type => 'When distributed',
            Prefix => $1,
            Suffix => $2
        }
    }

    if ($symbol =~ m/^([A-Z]+)(\+)$/){
        return {
            Type => 'Warrants',
            Prefix => $1,
            Suffix => $2
        }
    }

    if ($symbol =~ m/^([A-Z]+)(\+([A-Z]))$/){
        return { 
            Type => "Warrants Class",
            Prefix => $1,
            Suffix => $2,
            Class => $3
        }
    }

    if ($symbol =~ m/^([A-Z]+)(!L)$/){
        return {
            Type => 'Called',
            Prefix => $1,
            Suffix => $2
        }
    }
    
    if ($symbol =~ m/^([A-Z]+)(\.([A-Z])L)$/){
        return {
            Type => "Class Called",
            Prefix => $1,
            Suffix => $2,
            Class => $3
        }
    }

    if ($symbol =~ m/^([A-Z]+)(-CL)$/){
        return {
            Type => 'Preferred Called',
            Prefix => $1,
            Suffix => $2,
        }
    }

    if ($symbol =~ m/^([A-Z]+)(-([A-Z])L)$/){
        return { 
            Type => "Preferred Class Called",
            Prefix => $1,
            Suffix => $2,
            Class => $3
        }
    }

    if ($symbol =~ m/^([A-Z]+)(-([A-Z])\*)$/){
        return { 
            Type => "Preferred When Issued",
            Prefix => $1,
            Suffix => $2,
            Class => $3
        }
    }

    if ($symbol =~ m/^([A-Z]+)(!EC)$/){
        return {
            Type => 'Emerging Company Marketplace',
            Prefix => $1,
            Suffix => $2,
        }
    }

    if ($symbol =~ m/^([A-Z]+)(!PP)$/){
        return {
            Type => 'Partial Paid',
            Prefix => $1,
            Suffix => $2,
        }
    }

    if ($symbol =~ m/^([A-Z]+)(!V)$/){
        return {
            Type => 'Convertible',
            Prefix => $1,
            Suffix => $2,
        }
    }

    if ($symbol =~ m/^([A-Z]+)(!VL)$/){
        return {
            Type => 'Convertible Called',
            Prefix => $1,
            Suffix => $2,
        }
    }

    if ($symbol =~ m/^([A-Z]+)(\.([A-Z])V)$/){
        return { 
            Type => "Class Convertible",
            Prefix => $1,
            Suffix => $2,
            Class => $3
        }
    }

    if ($symbol =~ m/^([A-Z]+)(-([A-Z])V)$/){
        return { 
            Type => "Preferred Class Convertible",
            Prefix => $1,
            Suffix => $2,
            Class => $3
        }
    }

    if ($symbol =~ m/^([A-Z]+)(-([A-Z])WD)$/){
        return { 
            Type => "Preferred Class When Distributed",
            Prefix => $1,
            Suffix => $2,
            Class => $3
        }
    }

    if ($symbol =~ m/^([A-Z]+)(!R)$/){
        return {
            Type => 'Rights',
            Prefix => $1,
            Suffix => $2,
        }
    }

    if ($symbol =~ m/^([A-Z]+)(\.U)$/){
        return {
            Type => 'Units',
            Prefix => $1,
            Suffix => $2
        }
    }

    if ($symbol =~ m/^([A-Z]+)(\*)$/){
        return {
            Type => 'When Issued',
            Prefix => $1,
            Suffix => $2,
        }
    }

    if ($symbol =~ m/^([A-Z]+)(!R\*)$/){
        return {
            Type => 'Rights When Issued',
            Prefix => $1,
            Suffix => $2,
        }
    }

    if ($symbol =~ m/^([A-Z]+)(-\*)$/){
        return {
            Type => 'Preferred When Issued',
            Prefix => $1,
            Suffix => $2,
        }
    }

    if ($symbol =~ m/^([A-Z]+)(\.([A-Z])\*)$/){
        return { 
            Type => "Class When Issued",
            Prefix => $1,
            Suffix => $2,
            Class => $3
        }
    }

    if ($symbol =~ m/^([A-Z]+)(\+\*)$/){
        return {
            Type => 'Warrant When Issued',
            Prefix => $1,
            Suffix => $2,
        }
    }

    if ($symbol =~ m/^([A-Z]+)(\.CT)$/){
        return {
            Type => 'Certificates',
            Prefix => $1,
            Suffix => $2
        }
    }

    if ($symbol =~ m/^([A-Z]+)(\.SP)$/){
        return {
            Type => 'Special',
            Prefix => $1,
            Suffix => $2
        }
    }

    if ($symbol =~ m/^([A-Z]+)(\.SD)$/){
        return {
            Type => 'Stamped',
            Prefix => $1,
            Suffix => $2,
        }
    }

    if ($symbol =~ m/^([A-Z]+)(:W)$/){
    return {
            Type => 'With Warrants',
            Prefix => $1,
            Suffix => $2,
        }
    }

    if ($symbol =~ m/^([A-Z]+)(:XW)$/){
        return {
            Type => 'Without Warrants',
            Prefix => $1,
            Suffix => $2,
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
