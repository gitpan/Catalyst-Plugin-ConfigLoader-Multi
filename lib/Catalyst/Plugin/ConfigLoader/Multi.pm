package Catalyst::Plugin::ConfigLoader::Multi;

use strict;
use warnings;
use base qw/Catalyst::Plugin::ConfigLoader/;
use Config::Any;
use Catalyst::Utils;
use DirHandle;
use NEXT;

our $VERSION = 0.04;

sub find_files {
    my $c = shift;
    
    my @files    = $c->SUPER::find_files();
    my @my_files = $c->_find_my_files();

    return (@files, @my_files);
}

sub _find_my_files {
    my $c = shift;
    my ( $path_prefix, $extension ) = $c->get_config_path();

    return [] if $extension;

    my $prefix = Catalyst::Utils::appprefix( ref $c || $c );
    my $path   = $path_prefix;
    $path      =~ s{\/$prefix$}{};

    my @extensions = @{ Config::Any->extensions };
    my $suffix     = $c->get_config_local_suffix;
    my @my_files   = ();
    my $dh = DirHandle->new( $path );

    while ( my $file = $dh->read() ) {
        next unless $file =~ /^$prefix\_(.+)\.\w+$/ && $suffix ne $1;
        push @my_files,
             ( map {
                    (
                        "${path_prefix}_${1}.$_",
                        "${path_prefix}_${1}_${suffix}.$_"
                    )
                   } @extensions
             ); 
    }

    return @my_files;
}

1;

=head1 NAME

Catalyst::Plugin::ConfigLoader::Multi - Catalyst Plugin for Multiple ConfigLoader

=head1 SYNOPSIS

    package MyApp;
    
    use strict;
    use warnings;
    
    use Catalyst::Runtime '5.70';
    
    
    use Catalyst qw/-Debug ConfigLoader::Multi/;
    
    our $VERSION = '0.01';
    
    __PACKAGE__->config( name => 'MyApp' );
    # Do not forget add this.
    __PACKAGE__->config( 'Plugin::ConfigLoader' => { file => __PACKAGE__->path_to('conf')  } );
    
    __PACKAGE__->setup;
    
    1;

Your directory

    %tree
    /Users/tomyhero/work/MyApp/
    |-- Changes
    |-- Makefile.PL
    |-- README
    |-- conf
    |   |-- my_app_local.yml
    |   |-- myapp.yml
    |   |-- myapp_bar.yml
    |   `-- myapp_foo.yml
    |-- lib
    |   |-- MyApp
    |   |   |-- Controller
    |   |   |   `-- Root.pm
    |   |   |-- Model
    |   |   `-- View
    |   `-- MyApp.pm
    |-- root
    |-- script
    `-- t

=head1 DESCRIPTION

When a project is getting bigger and biggger , it is hard to organaize a config
file. So we create this plugin which divide a config file to multiple. Config
files name must start your project prrefix. such as 'myapp_' .

 __PACKAGE__->config( 'Plugin::ConfigLoader' => { file => __PACKAGE__->path_to('conf')  } );

Do not forget add this code to your MyApp.pm

=head1 METHOD

=head2 find_files

override from ConfigLoader

=head1 SEE ALSO

L<Catalyst::Plugin::ConfigLoader>

=head1 AUTHOR

Masahiro Funakoshi <masap@cpan.org>

Yu-suke Amano 

Tomohiro Teranishi <tomohiro.teranishi@gmail.com>

=head1 COPYRIGHT

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut
