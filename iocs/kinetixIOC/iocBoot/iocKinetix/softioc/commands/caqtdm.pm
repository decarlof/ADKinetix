package commands::caqtdm;

use Env;
use File::Basename;

sub _local
{
	#system("$TOP/start_caQtDM_$IOC_NAME", @_);
	my $HERE = dirname(__FILE__);
	system("$HERE/../../start_caqtdm");

}

sub _usage
{
	print("caqtdm [ui_file ui_macros]\n");
}

1;
