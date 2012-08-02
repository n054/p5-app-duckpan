package App::DuckPAN::Fathead;

use Moo;
use IO::All;
use DDG::ZeroClickInfo::Fathead;

=method request_fathead_output

Takes a file name and DDG::Request object and returns a
DDG::ZeroClickInfo::Fathead object if there is a match.

=cut

sub request_fathead_output {
    my ( $request, $file_name ) = @_;

    my $file = io $file_name; 

    $file->chomp;
    
    while ( my $line = $file->getline ) {
        my $title = ${split( /\t/, $line )}[0];
        
        # If the query matches the title, return the DDG::ZeroClickInfo::Fathead
        # object that represents the matching result.
        if ( $title eq $request->query_clean ) {
            return DDG::ZeroClickInfo::Fathead->new_via_output($line);
        }
    }

    return;
}

1;
