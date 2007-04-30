use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Catalyst::Plugin::ConfigLoader::Multi',
    AUTHOR              => 'Mashiro Funakoshi <masap@cpan.org>',
    VERSION_FROM        => 'lib/Catalyst/Plugin/ConfigLoader/Multi.pm',
    ABSTRACT_FROM       => 'lib/Catalyst/Plugin/ConfigLoader/Multi.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More'                     => 0,
        'Catalyst'                       => 0,
        'Catalyst::Plugin::ConfigLoader' => 0.12,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Catalyst-Plugin-ConfigLoader-Multi-*' },
);
