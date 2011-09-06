package Symbology::Convention::NASDAQ::Integrated;

use strict;
use warnings;

# Enjoying Mastering regular expressions, why not use an example from it?
my $template = {
    'Preferred' => '-',
    'Preferred Class' => '-=CLASS=',
    'Class' => '.=CLASS=',
    'Preferred when distributed' => '-$',
    'When distributed' => '$',
    'Warrants' => '+',
    'Warrants Class' => '+=CLASS=',
    'Called' => '*',
    'Class Called' => '.=CLASS=*',
    'Preferred Called' => '-*',
    'Preferred Class Called' => '-=CLASS=*',
    'Preferred Class When Issued' => '-=CLASS=#',
    'Emerging Company Marketplace' => '!',
    'Partial Paid' => '@',
    'Convertible' => '%',
    'Convertible Called' => '%*',
    'Class Convertible' => '.=CLASS=%',
    'Preferred Class Convertible' => '-=CLASS=%',
    'Preferred Class When Distributed' => '-=CLASS=$',
    'Rights' => '^',
    'Units' => '=',
    'When Issued' => '#',
    'Rights When Issued' => '^#',
    'Preferred When Issued' => '-#',
    'Class When Issued' => '.=CLASS=#',
    'Warrant When Issued' => '+#',
    'TEST Symbol' => '~'
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
            Suffix => $2,
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

    if ($symbol =~ m/^([A-Z]+)(-\$)$/){
        return {
            Type => 'Preferred when distributed',
            Prefix => $1,
            Suffix => $2,
        }
    }

    if ($symbol =~ m/^([A-Z]+)(\$)$/){
        return {
            Type => 'When distributed',
            Prefix => $1,
            Suffix => $2,
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

    if ($symbol =~ m/^([A-Z]+)(\*)$/){
        return {
            Type => 'Called',
            Prefix => $1,
            Suffix => $2
        }
    }
    
    if ($symbol =~ m/^([A-Z]+)(\.([A-Z])\*)$/){
        return { 
            Type => "Class Called",
            Prefix => $1,
            Suffix => $2,
            Class => $3
        }
    }

    if ($symbol =~ m/^([A-Z]+)(-\*)$/){
        return {
            Type => 'Preferred Called',
            Prefix => $1,
            Suffix => $2,
        }
    }

    if ($symbol =~ m/^([A-Z]+)(-([A-Z])\*)$/){
        return { 
            Type => "Preferred Class Called",
            Prefix => $1,
            Suffix => $2,
            Class => $3
        }
    }

    if ($symbol =~ m/^([A-Z]+)(-([A-Z])#)$/){
        return { 
            Type => "Preferred When Issued",
            Prefix => $1,
            Suffix => $2,
            Class => $3
        }
    }

    if ($symbol =~ m/^([A-Z]+)(!)$/){
        return {
            Type => 'Emerging Company Marketplace',
            Prefix => $1,
            Suffix => $2,
        }
    }

    if ($symbol =~ m/^([A-Z]+)(\@)$/){
        return {
            Type => 'Partial Paid',
            Prefix => $1,
            Suffix => $2,
        }
    }

    if ($symbol =~ m/^([A-Z]+)(\%)$/){
        return {
            Type => 'Convertible',
            Prefix => $1,
            Suffix => $2,
        }
    }

    if ($symbol =~ m/^([A-Z]+)(\%\*)$/){
        return {
            Type => 'Convertible Called',
            Prefix => $1,
            Suffix => $2,
        }
    }

    if ($symbol =~ m/^([A-Z]+)(\.([A-Z])\%)$/){
        return { 
            Type => "Class Convertible",
            Prefix => $1,
            Suffix => $2,
            Class => $3
        }
    }

    if ($symbol =~ m/^([A-Z]+)(-([A-Z])\%)$/){
        return { 
            Type => "Preferred Class Convertible",
            Prefix => $1,
            Suffix => $2,
            Class => $3
        }
    }

    if ($symbol =~ m/^([A-Z]+)(-([A-Z])\$)$/){
        return { 
            Type => "Preferred Class When Distributed",
            Prefix => $1,
            Suffix => $2,
            Class => $3
        }
    }

    if ($symbol =~ m/^([A-Z]+)(\^)$/){
        return {
            Type => 'Rights',
            Prefix => $1,
            Suffix => $2
        }
    }

    if ($symbol =~ m/^([A-Z]+)(=)$/){
        return {
            Type => 'Units',
            Prefix => $1,
            Suffix => $2,
        }
    }

    if ($symbol =~ m/^([A-Z]+)(#)$/){
        return {
            Type => 'When Issued',
            Prefix => $1,
            Suffix => $2
        }
    }

    if ($symbol =~ m/^[A-Z]+\^#$/){
        return {
            Type => 'Rights When Issued',
            Prefix => $1,
            Suffix => $2,
        }
    }

    if ($symbol =~ m/^([A-Z]+)(-#)$/){
        return {
            Type => 'Preferred When Issued',
            Prefix => $1,
            Suffix => $2,
        }
    }

    if ($symbol =~ m/^([A-Z]+)(\.([A-Z])#)$/){
        return { 
            Type => "Class When Issued",
            Prefix => $1,
            Suffix => $2,
            Class => $3
        }
    }

    if ($symbol =~ m/^[A-Z]+\+#$/){
        return {
            Type => 'Warrant When Issued',
            Prefix => $1,
            Suffix => $2,
        }
    }

    if ($symbol =~ m/^([A-Z]+)(~)$/){
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

    if (exists $data->{Class}){
        return conversion($data->{Prefix},$data->{Type},$data->{Class});
    } else {
        return conversion($data->{Prefix},$data->{Type});
    }
}

1;
