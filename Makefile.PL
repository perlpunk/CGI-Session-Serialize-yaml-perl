# $Id: Makefile.PL 336 2006-10-26 02:17:31Z markstos $

use strict;
use File::Spec;
use lib './t/lib';
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME => 'CGI::Session::Serialize::yaml',
    VERSION_FROM => 'lib/CGI/Session/Serialize/yaml.pm',
    PREREQ_PM => {
        'CGI::Session'               => 4.30,
		'CGI::Session::ErrorHandler' => 4.30,
        'File::Spec'                 => 0,
        'Test::More'                 => 0,
		'Test::Pod'                  => 0,
    },
    LICENSE => 'perl',
    ABSTRACT => 'Persistent session data in CGI applications',
    AUTHOR => 'Sherzod Ruzmetov <sherzodr@cpan.org>',
    clean => { FILES => [ 't/cgisess.*', 't/sessiondata' ] },
    META_MERGE => {
        "meta-spec" => { version => 2 },
        resources => {
            repository => {
                type => 'git',
                url => 'https://github.com/perlpunk/CGI-Session-Serialize-yaml-perl.git',
                web => 'https://github.com/perlpunk/CGI-Session-Serialize-yaml-perl',
            },
        },
    },
);

package MY;
use strict;

sub postamble {
    return <<'MAKE_TEXT';
prepare_dist ::	metafile manifest dist
	$(NOECHO) $(NOOP)
MAKE_TEXT
}

sub libscan {
    my ($self, $path) = @_;
    return '' if $path =~ m/\.svn/;
    return $path;
}
