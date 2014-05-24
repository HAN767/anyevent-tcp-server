#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;
use AnyEvent::Handle;
use AnyEvent;

use AnyEvent::TCP::Server;

my $ae = AnyEvent::TCP::Server->new(
    port                =>  44444,
    process_request     =>  sub {
        my ($worker_object, $fh, $ae_h) = @_;

        print "PRMS:", Dumper \@_;
        my $h = AnyEvent::Handle->new(fh=>$fh);
        $h->push_write("Hello!\n");
        $h->destroy();
        $fh->close();
        
    },
    # sock_path             =>  '/Users/noxx/git/anyevent-tcp-server/eg',
    workers             =>  5,
);

$ae->run();