use strict;
use warnings;

use Test::More;
my $token = $ENV{TOKEN};
plan skip_all => 'Works only if API token provided in he TOKEN environment variable'
	if not $token;

plan tests => 1;

use WWW::SmartSheet;
my $w = WWW::SmartSheet->new( token => $token );
isa_ok($w, 'WWW::SmartSheet');

my $sheet_name = 'test_' . int(rand(10000)) . '_' . time;
my $s = $w->create_sheet(
    name    => $sheet_name,
	columns =>  [
        { title => "First Col",  type => 'TEXT_NUMBER', primary => JSON::true },
    	{ title => "Second Col", type => 'CONTACT_LIST' },
        { title => 'Third Col',  type => 'TEXT_NUMBER' },
        { title => "Fourth Col", type => 'CHECKBOX', symbol => 'FLAG' },
        { title => 'Status',     type => 'PICKLIST', options => ['Started', 'Finished' , 'Delivered'] }
	],
);
#isa_ok($s, 'WWW::SmartSheet::Sheet';
#diag explain $s;

my $c = $w->add_column($s->{result}{id}, { title => 'Delivered', type => 'DATE', index => 5 });

#diag explain $c;

#$w->insert_rows($s->{result}{id}, 
