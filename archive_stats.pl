# script: archive_stats.pl
# Tasks: Archiving stats for the databases located in HoustonHBI-PDS1.
#
#------------------- Revision History -------------------------------------
# Date by Changes
# 06-25-2008 nlharrington Initial Release - 
#


use strict;
use warnings;


open(FILEIN, "E:\\orascrpt\\_Backup\\DATABASE.txt") || die "Can't find file: $!\n";
while (<FILEIN>)
{
	my($database) = $_; 
	chomp($database);
	
	open FILEOUT, ">archivestat.cmd";
	#archive any existing stat files
	print FILEOUT "MOVE E:\\ORADATA\\$database\\STATS\\*.* E:\\ORABKUP\\STATS\\$database\\TODAY";
	print FILEOUT "\n";
	print FILEOUT "DEL E:\\ORASCRPT\\_Backup\\TEMP.BAT";
	print FILEOUT "\n";
	print FILEOUT "E:\\ORASCRPT\\UTILITIES\\FDATE\\FDATE /FSuB /N180 /ATODAY /O" . chr(39) ."CCYYMMDD". chr(39) ." /P".chr(34).chr(64)."SET DLTDT=".chr(34)." > E:\\ORASCRPT\\_Backup\\TEMP.BAT";
	print FILEOUT "\n";
	print FILEOUT "CALL E:\\ORASCRPT\\_Backup\\TEMP.BAT";
	print FILEOUT "\n";
	print FILEOUT "DEL E:\\ORASCRPT\\_Backup\\TEMP.BAT";
	print FILEOUT "\n";
	print FILEOUT "RMDIR E:\\ORADBKUP\\STATS\\$database\\".chr(37)."DLTDT".chr(37)."/S /Q";
	print FILEOUT "\n";
	print FILEOUT "DEL E:\\ORASCRPT\\_Backup\\TEMP.BAT";
	print FILEOUT "\n";
	print FILEOUT "E:\\ORASCRPT\\UTILITIES\\FDATE\\FDATE /Ff /O" . chr(39) ."CCYYMMDD". chr(39) ." /P".chr(34).chr(64)."SET CRRNTDT=".chr(34)." > E:\\ORASCRPT\\_Backup\\TEMP.BAT";
	print FILEOUT "\n";
	print FILEOUT "CALL E:\\ORASCRPT\\_Backup\\TEMP.BAT";
	print FILEOUT "\n";
	print FILEOUT "DEL E:\\ORASCRPT\\_Backup\\TEMP.BAT";
	print FILEOUT "\n";
	print FILEOUT "MKDIR E:\\ORABKUP\\STATS\\$database\\".chr(37)."CRRNTDT".chr(37);
	print FILEOUT "\n";
	print FILEOUT "MOVE E:\\ORABKUP\\STATS\\$database\\TODAY\\*.* E:\\ORABKUP\\STATS\\$database\\".chr(37)."CRRNTDT".chr(37);
	print FILEOUT "\n";
	print FILEOUT "exit";

	print $database;

 	`cmd /c archivestat.cmd >> E:\\ORABKUP\\STATS\\_stat_logs\\_stat_logs.log`;

	print "finished";
}
	


close FILEIN;