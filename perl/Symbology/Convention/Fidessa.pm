package Symbology::Convention::Fidessa;

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
        if $symbol =~ m/^[A-Z]+-WD$/;

    return 'When distributed'
        if $symbol =~ m/^[A-Z]+!W$/;

    return 'Warrants'
        if $symbol =~ m/^[A-Z]+\+$/;

    if ($symbol =~ m/^[A-Z]+\+([A-Z])$/){
        return "Warrants Class $1";
    }

    return 'Called'
        if $symbol =~ m/^[A-Z]+!L$/;
    
    if ($symbol =~ m/^[A-Z]+\.([A-Z])L$/){
        return "Class $1 Called";
    }

    return 'Preferred Called'
        if $symbol =~ m/^[A-Z]+-CL$/;

    if ($symbol =~ m/^[A-Z]+-([A-Z])L$/){
        return "Preferred $1 Called";
    }

    if ($symbol =~ m/^[A-Z]+-([A-Z])\*$/){
        return "Preferred $1 When Issued";
    }

    return 'Emerging Company Marketplace'
        if $symbol =~ m/^[A-Z]+!EC$/;

    return 'Partial Paid' 
        if $symbol =~ m/^[A-Z]+!PP$/;

    return 'Convertible' 
        if $symbol =~ m/^[A-Z]+!V$/;

    return 'Convertible Called' 
        if $symbol =~ m/^[A-Z]+!VL$/;

    if ($symbol =~ m/^[A-Z]+\.([A-Z])V$/){
        return "Class $1 Convertible";
    }

    if ($symbol =~ m/^[A-Z]+-([A-Z])V$/){
        return "Preferred Class $1 Convertible";
    }

    if ($symbol =~ m/^[A-Z]+-([A-Z])WD$/){
        return "Preferred Class $1 When Distributed";
    }

    return 'Rights'
        if $symbol =~ m/^[A-Z]+!R$/;

    return 'Units'
        if $symbol =~ m/^[A-Z]+\.U$/;

    return 'When Issued'
        if $symbol =~ m/^[A-Z]+\*$/;

    return 'Rights When Issued'
        if $symbol =~ m/^[A-Z]+!R\*$/;

    return 'Preferred When Issued'
        if $symbol =~ m/^[A-Z]+-\*$/;

    if ($symbol =~ m/^[A-Z]+\.([A-Z])\*$/){
        return "Class $1 When Issued";
    }

    return 'Warrant When Issued'
        if $symbol =~ m/^[A-Z]+\+\*$/;

    return 'Certificates'
        if $symbol =~ m/^[A-Z]+\.CT$/;

    return 'Special'
        if $symbol =~ m/^[A-Z]+\.SP$/;

    return 'Stamped'
        if $symbol =~ m/^[A-Z]+\.SD$/;

    return 'With Warrants'
        if $symbol =~ m/^[A-Z]+:W$/;

    return 'Without Warrants'
        if $symbol =~ m/^[A-Z]+:XW$/;
    return undef;


}
1;
