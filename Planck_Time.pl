#!/usr/bin/perl -w
#
# Writen by: Mike Cagle Jr.
# Date: 12/3/2012
# Version: 2.0
#
{
use strict;
use Encode;
my @Dictionary_Numbers = ("Thousand",
			"Million",
			"Billion",
			"Trillion", 
			"Quadrillion",
			"Quintillion",
			"Sextillion",
			"Septillion",
			"Octillion",
			"Nonillion",
			"Decillion",
			"Undecillion",
			"Duodecillion",
			"Tredecillion",
			"Quattuordecillion",
			"Quindecillion",
			"Sexdecillion",
			"Septendecillion",
			"Octodecillion",
			"Novemdecillion",
			"Vigintillion",
			"Centillion");
$Dictionary_Numbers[32] = "Googol";
my $one_sec_PlanckTime = (1.855 * 10**43);
my $one_millisec_PlanckTime = (1.855 * 10**40);
my $one_sec_PlanckTime_sci = 1.855e+43;
my $one_millisec_PlanckTime_sci = 1.855e+40;
my $one_sec_PlanckTime_decimal = &Scientific2Decimal($one_sec_PlanckTime_sci);
my $one_millisec_PlanckTime_decimal = &Scientific2Decimal($one_millisec_PlanckTime_sci);
my $one_sec_PlanckTime_bytes = length(Encode::encode_utf8(&no_decimal($one_sec_PlanckTime_decimal)));
my $one_millisec_PlanckTime_bytes = length(Encode::encode_utf8(&no_decimal($one_millisec_PlanckTime_decimal)));
my $byte_of_pebibyte = 8.8818e-16;
my $gigabyte_of_a_pebibyte = 8.8818e-7;
my $eight_GB_of_pebibyte = 7.1054e-6;
my $twenty_four_GB_of_pebibyte = 2.1316e-5;
# Memory for one second of nomal time in Plancks
my $sec_memory_sci_pebibyte = ($one_sec_PlanckTime_sci * $byte_of_pebibyte);
my $sec_memory_dec_pebibyte = (&Scientific2Decimal($sec_memory_sci_pebibyte));
# Memory for one Millisecond of normal time in Plancks
my $millisec_memory_sci_pebibyte = ($one_millisec_PlanckTime_sci * $byte_of_pebibyte);
my $millisec_memory_dec_pebibyte = (&Scientific2Decimal($millisec_memory_sci_pebibyte));
# Memory needed to compute Milliseconds of normal time in Plancks
my $memory_sci_pebibyte = "$millisec_memory_sci_pebibyte^$millisec_memory_sci_pebibyte";
my $memory_dec_pebibyte = &no_decimal(&Scientific2Decimal($millisec_memory_sci_pebibyte)) . "^" . &no_decimal(&Scientific2Decimal($millisec_memory_sci_pebibyte));
my $computer_8GB_sci = "($memory_sci_pebibyte) / $eight_GB_of_pebibyte";
my $computer_24GB_sci = "($memory_sci_pebibyte) / $twenty_four_GB_of_pebibyte";
my $eight_GB_of_pebibyte_dec = &Scientific2Decimal($eight_GB_of_pebibyte);
my $twenty_four_GB_of_pebibyte_dec = &Scientific2Decimal($twenty_four_GB_of_pebibyte);
my $computer_8GB_dec = "(" . &no_decimal(&Scientific2Decimal($millisec_memory_sci_pebibyte)) . "^" . &no_decimal(&Scientific2Decimal($millisec_memory_sci_pebibyte)) . ") / $eight_GB_of_pebibyte_dec";
my $computer_24GB_dec = "(" . &no_decimal(&Scientific2Decimal($millisec_memory_sci_pebibyte)) . "^" . &no_decimal(&Scientific2Decimal($millisec_memory_sci_pebibyte)) . ") / $twenty_four_GB_of_pebibyte_dec";
print "\n";
&bar();
print "Number of Planck time units in 1 second of normal time:\n\n";
print "\t(bytes): $one_sec_PlanckTime_bytes\n";
print "\t(scientific): $one_sec_PlanckTime\n";
print "\t(decimal): " . &no_decimal(&commas($one_sec_PlanckTime_decimal)) . "\n\n";
&print_number_name($one_sec_PlanckTime_decimal);
&bar();
print "Number of Planck time units in 1 Millisecond (1 ms) of normal time:\n\n";
print "\t(bytes): $one_millisec_PlanckTime_bytes\n";
print "\t(scientific): $one_millisec_PlanckTime\n";
print "\t(decimal): " . &no_decimal(&commas($one_millisec_PlanckTime_decimal)) . "\n\n";
&print_number_name($one_millisec_PlanckTime_decimal);
&bar();
print "Pebibytes of memory required to analyze all Planck time units (1 x Second):\n\n";
print "Pebibytes Scientific: " . $sec_memory_sci_pebibyte . "\n";
print "Pebibytes Decimal: " . &no_decimal(&commas($sec_memory_dec_pebibyte)) . "\n\n";
&print_number_name($sec_memory_dec_pebibyte);
&bar();
print "Pebibytes of memory required to analyze all Planck time units (1 x ms):\n\n";
print "Pebibytes Scientific: " . $millisec_memory_sci_pebibyte . "\n";
print "Pebibytes Decimal: " . &no_decimal(&commas($millisec_memory_dec_pebibyte)) . "\n\n";
&print_number_name($millisec_memory_dec_pebibyte);
&bar();
print "Pebibytes of memory to compare 2 ms in Planck time units (1 x ms)^(1 x ms):\n\n";
print "Pebibytes Scientific: " . $memory_sci_pebibyte . "\n";
print "Pebibytes Decimal: " . &no_decimal($memory_dec_pebibyte) . "\n\n";
&bar();
print "Cluster of 8GB RAM laptops required to compare (1 x ms)^(1 x ms):\n\n";
print "Scientific: $computer_8GB_sci\n";
print "Decimal: $computer_8GB_dec\n\n";
&bar();
print "Cluster of 24GB RAM servers required to compare (1 x ms)^(1 x ms):\n\n";
print "Scientific: $computer_24GB_sci\n";
print "Decimal: $computer_24GB_dec\n\n";
&bar();
exit 0;
####
sub commas { my $num = reverse $_[0]; $num =~ s/(\d\d\d)(?=\d)(?!\d*\.)/$1,/g; return scalar reverse $num; }
sub no_decimal { my $num = shift; $num =~ s/\.\d*$//; return $num; }
sub Scientific2Decimal { my $num = shift; my $result = sprintf("%.10f", $num); return $result; }
sub number_commas { my $num = shift; my $digits = length &no_decimal($num); my $commas = ($digits / 3); return &no_decimal($commas); }
sub Dictionary_Numbers { my $num = shift; $num = (&number_commas(&no_decimal($num))); my $Dictionary_Number = ($num - 1); return $Dictionary_Number; }
sub print_number_name {
	my $num = shift;
	if ($Dictionary_Numbers[&Dictionary_Numbers($num)]) {
		print "Dictionary Number Name for decimal value: " . $Dictionary_Numbers[&Dictionary_Numbers($num)] . "\n\n";
	}
}
sub bar { print "#################################################################################\n\n"; }
}
