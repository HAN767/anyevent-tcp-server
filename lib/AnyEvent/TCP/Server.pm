package AnyEvent::TCP::Server;

use strict;
use Carp;

use AnyEvent;
use AnyEvent::Socket;
use AnyEvent::Handle;
use IO::FDPass;

use AnyEvent::TCP::Master;
use AnyEvent::TCP::Worker;
use AnyEvent::TCP::Watcher;

our $VERSION = 0.01;

sub new {
	my ($class, %params) = @_;

	if (!$params{process_request}) {
		croak 'Missing process_request param';
	}

	if (ref $params{process_request} ne 'CODE') {
		croak 'process_request must be a code ref';
	}

	if (!$params{port}) {
		croak 'Missing port param';
	}

	if (!$params{sock}) {
		croak 'Missing sock param';
	}

	my $self = {};

	$self->{_init_params} = {
		process_request => 	$params{process_request},
		port 			=>	$params{port},
		sock 			=>	$params{sock},
		workers 		=>	$params{workers} // 1,
	};
	
	bless $self, $class;
	return $self;
}

sub run {
	my ($self) = @_;

	my $master = AnyEvent::TCP::Master->new($self->{_init_params});
	$master->run();
}

1;

__END__