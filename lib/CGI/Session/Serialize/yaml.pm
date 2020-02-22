package CGI::Session::Serialize::yaml;

use strict;
use CGI::Session::ErrorHandler;

$CGI::Session::Serialize::yaml::VERSION = '4.26_001';
@CGI::Session::Serialize::yaml::ISA     = ( "CGI::Session::ErrorHandler" );
our $Flavour;
my $LOAD;
my $DUMP;

unless($Flavour) {
    my $package = (grep { eval("use $_ (); 1;") } qw(YAML::Syck YAML))[0]
        or die "Either YAML::Syck or YAML are required to use ", __PACKAGE__;
    $Flavour = $package;
}
$DUMP = $Flavour->can('Dump');
$LOAD = sub {
    no strict 'refs';
    local ${ $Flavour . "::LoadBlessed" } = 1;
    $Flavour->can('Load')->(@_);
};

sub freeze {
    my ($self, $data) = @_;
    return $DUMP->($data);
}


sub thaw {
    my ($self, $string) = @_;
    return ($LOAD->($string))[0];
}

1;

__END__;

=pod

=head1 NAME

CGI::Session::Serialize::yaml - serializer for CGI::Session

=head1 DESCRIPTION

This library can be used by CGI::Session to serialize session data. It uses
C<YAML>, or the faster C implementation, C<YAML::Syck>
if it is available. YAML serializers exist not just for Perl but also other
dynamic languages, such as PHP, Python, and Ruby, so storing session data
in this format makes it easy to share session data across different languages.

YAML is made to be friendly for humans to parse as well as other computer
languages. It creates a format that is easier to read than the default
serializer.

=head1 METHODS

=over 4

=item freeze($class, \%hash)

Receives two arguments. First is the class name, the second is the data to be serialized. Should return serialized string on success, undef on failure. Error message should be set using C<set_error()|CGI::Session::ErrorHandler/"set_error()">

=item thaw($class, $string)

Received two arguments. First is the class name, second is the C<YAML> data string. Should return thawed data structure on success, undef on failure. Error message should be set using C<set_error()|CGI::Session::ErrorHandler/"set_error()">

=back

=head1 SEE ALSO

C<CGI::Session>, C<YAML>, C<YAML::Syck>.

=cut
