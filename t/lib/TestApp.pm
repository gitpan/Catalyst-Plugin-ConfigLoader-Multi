package TestApp;

use strict;
use warnings;

use Catalyst::Runtime '5.70';

use Catalyst qw/ConfigLoader::Multi/;

our $VERSION = '0.01';


__PACKAGE__->config( 
    name => 'TestApp',
    file => __PACKAGE__->path_to( './../conf' ) 
);

#__PACKAGE__->setup;

1;
