package Symbology::Convention::NASDAQ::Integrated;

use strict;
use warnings;

sub check {
    my ($self, $symbol) = @_;

    return 'Preferred' 
        if $symbol =~ m/^[A-Z]+-$/;

    if ($symbol =~ m/^[A-Z]+-([A-Z])$/){
        return "Preferred Class $1";
    }

    if ($symbol =~ m/^[A-Z]+\.([A-Z])$/) {
        return "Class $1";
    }

    return 'Preferred when distributed'
        if $symbol =~ m/^[A-Z]+-\$$/;

    return 'When distributed'
        if $symbol =~ m/^[A-Z]+\$$/;

    return 'Warrants'
        if $symbol =~ m/^[A-Z]+\+$/;

    if ($symbol =~ m/^[A-Z]+\+([A-Z])$/){
        return "Warrants Class $1";
    }

    return 'Called'
        if $symbol =~ m/^[A-Z]+\*$/;
    
    if ($symbol =~ m/^[A-Z]+\.([A-Z])\*$/){
        return "Class $1 Called";
    }

    return 'Preferred Called'
        if $symbol =~ m/^[A-Z]+-\*$/;

    if ($symbol =~ m/^[A-Z]+-([A-Z])\*$/){
        return "Preferred $1 Called";
    }

    if ($symbol =~ m/^[A-Z]+-([A-Z])#$/){
        return "Preferred $1 When Issued";
    }

    return 'Emerging Company Marketplace'
        if $symbol =~ m/^[A-Z]+!$/;

    return 'Partial Paid' 
        if $symbol =~ m/^[A-Z]+\@$/;

    return 'Convertible' 
        if $symbol =~ m/^[A-Z]+\%$/;

    return 'Convertible Called' 
        if $symbol =~ m/^[A-Z]+\%\*$/;

    if ($symbol =~ m/^[A-Z]+\.([A-Z])\%$/){
        return "Class $1 Convertible";
    }

    if ($symbol =~ m/^[A-Z]+-([A-Z])\%$/){
        return "Preferred Class $1 Convertible";
    }

    if ($symbol =~ m/^[A-Z]+-([A-Z])\$$/){
        return "Preferred Class $1 When Distributed";
    }

    return 'Rights'
        if $symbol =~ m/^[A-Z]+\^$/;

    return 'Units'
        if $symbol =~ m/^[A-Z]+=$/;

    return 'When Issued'
        if $symbol =~ m/^[A-Z]+#$/;

    return 'Rights When Issued'
        if $symbol =~ m/^[A-Z]+\^#$/;

    return 'Preferred When Issued'
        if $symbol =~ m/^[A-Z]+-#$/;

    if ($symbol =~ m/^[A-Z]+\.([A-Z])#$/){
        return "Class $1 When Issued";
    }

    return 'Warrant When Issued'
        if $symbol =~ m/^[A-Z]+\+#$/;

    return 'TEST Symbol' 
        if $symbol =~ m/^[A-Z]+~$/;

    return undef;


}
1;
