package commands::medm;

use Env;
use File::Basename;

sub _local
{
	#system("$TOP/start_MEDM_$IOC_NAME", @_);
	my $HERE = dirname(__FILE__);
	system("$HERE/../../start_medm");

}

sub _usage
{
	print("medm [adl_file adl_macros]\n");
}


1;
