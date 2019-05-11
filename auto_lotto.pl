#!/usr/bin/perl -w
#
# Name: auto_lotto.pl                                                                                                                                                                                   
# Writen by: Mike Cagle Jr.                                                                                                                                                                             
# Created: 2018/10/23                                                                                                                                                                                   
# Updated:                                                                                                                                                                                              
# Version: 2.0                                                                                                                                                                                          
{                                                                                                                                                                                                       
use strict;                                                                                                                                                                                             
my %lotto_num_wins = (                                                                                                                                                                                  
        '01' => '19',                                                                                                                                                                                   
        '02' => '12',                                                                                                                                                                                   
        '03' => '10',                                                                                                                                                                                   
        '04' => '09',                                                                                                                                                                                   
        '05' => '06',                                                                                                                                                                                   
        '06' => '07',
        '07' => '07',
        '08' => '08',
        '09' => '03',
        '10' => '09',
        '11' => '10',
        '12' => '07',
        '13' => '07',
        '14' => '12',
        '15' => '08',
        '16' => '08',
        '17' => '11',
        '18' => '07',
        '19' => '05',
        '20' => '06',
        '21' => '06',
        '22' => '09',
        '23' => '09',
        '24' => '05',
        '25' => '05',
        '26' => '05',
        '27' => '06',
        '28' => '16',
        '29' => '09',
        '30' => '09',
        '31' => '10',
        '32' => '10',
        '33' => '08',
        '34' => '07',
        '35' => '04',
        '36' => '04',
        '37' => '05',
        '38' => '09',
        '39' => '10',
        '40' => '06',
        '41' => '09',
        '42' => '11',
        '43' => '07',
        '44' => '08',
        '45' => '06',
        '46' => '12',
        '47' => '07',
        '48' => '06',
        '49' => '10',
        '50' => '02',
        '51' => '06',
        '52' => '06',
        '53' => '07',
        '54' => '06',
        '55' => '04',
        '56' => '07',
        '57' => '05',
        '58' => '08',
        '59' => '09',
        '60' => '08',
        '61' => '10',
        '62' => '09',
        '63' => '05',
        '64' => '09',
        '65' => '06',
        '66' => '07',
        '67' => '08',
        '68' => '08',
        '69' => '08',
        '70' => '13',
);

my %megaball_num_wins = (
        '01' => '06',
        '02' => '05',
        '03' => '05',
        '04' => '03',
        '05' => '04',
        '06' => '02',
        '07' => '04',
        '08' => '03',
        '09' => '07',
        '10' => '05',
        '11' => '07',
        '12' => '05',
        '13' => '04',
        '14' => '05',
        '15' => '02',
        '16' => '05',
        '17' => '05',
        '18' => '03',
        '19' => '05',
        '20' => '06',
        '21' => '02',
        '22' => '07',
        '23' => '07',
        '24' => '04',
        '25' => '03',
);

my %letters = ( 1 => 'A', 2 => 'B', 3 => 'C', 4 => 'D', 5 => 'E', );

&main();

sub main {
        print "\t\e[1;33m_____________________________________________\e[0m\n";
        print "\n\t\e[1;33m" . &return_date() . "\e[0m\n\n";
        foreach(0 .. 4) {
                my $num = $_ + 1;
                &lotto_numbers($num);
        }
        exit 0;
}

###########################################
sub lotto_numbers {
        my $num = shift;
        print "\t\e[1;33m" . $letters{$num} . ": \e[0m";
        my @lucky_lotto_nums = ();
        my $times = 0;
        my $count = 1;
        LOTTO_NUM: foreach(0 .. 4) {
                my @seven_lucky_nums = ();
                my $lucky_lotto_num = undef;
        foreach(0 .. $times) {
                my $ball_digit_1 = undef;
                my $ball_digit_0 = (generate_data('01234567'));
                if($ball_digit_0 == 0) {
                        $ball_digit_1 = (generate_data('123456789'));
                }
                elsif($ball_digit_0 >= 1 && $ball_digit_0 < 7) {
                        $ball_digit_1 = (generate_data('0123456789'));
                }
                elsif($ball_digit_0 == 7 && (generate_data('0123456789') > 7)) {
                        $ball_digit_1 = 0;
                }
                else { redo; }
                my $lotto_num = $ball_digit_0 . $ball_digit_1;
                foreach(@lucky_lotto_nums) {
                        if($lotto_num eq $_) { redo LOTTO_NUM; }
                }
                push(@seven_lucky_nums, $lotto_num);
                foreach(@seven_lucky_nums) {
                        my $lotto_num_one = $_;
                foreach(@seven_lucky_nums) {
                        my $lotto_num_two = $_;
                        if($lotto_num_wins{$lotto_num_one} > $lotto_num_wins{$lotto_num_two}) {
                                $lucky_lotto_num = $lotto_num_one;
                        }
                        elsif($lotto_num_wins{$lotto_num_two} > $lotto_num_wins{$lotto_num_one}) {
                                $lucky_lotto_num = $lotto_num_two;
                        }
                        elsif($lotto_num_wins{$lotto_num_one} == $lotto_num_wins{$lotto_num_two}) {
                                $lucky_lotto_num = $lotto_num_one;
                        }
                }
                }
        }
        push(@lucky_lotto_nums, $lucky_lotto_num);
        if($count >= 3) { $times = 1; }
        $count += 1;
}
        foreach(sort @lucky_lotto_nums) { print "\e[1;32m" . $_ . "   "; }
        print &megaball_number($times) . "\n\e[0m";
}

sub megaball_number {
        my $times = shift;
        print "\e[1;33mMega Ball: \e[1;32m";
        my $megaball_num = undef;
        my $lucky_megaball_num = undef;
        my @seven_megaball_nums = ();
        foreach(0 .. $times) {
        my $megaball_digit_0 = undef;
        my $megaball_digit_1 = undef;
        $megaball_digit_0 = (generate_data('012'));
        if($megaball_digit_0 < 2) {
                $megaball_digit_1 = (generate_data('0123456789'));
                $megaball_num = ($megaball_digit_0 . $megaball_digit_1);
        }
        elsif($megaball_digit_0 == 2) {
                $megaball_digit_1 = (generate_data('012345'));
                $megaball_num = ($megaball_digit_0 . $megaball_digit_1);
        }
        else { redo; }
        if($megaball_num == '00') { redo; }
        push(@seven_megaball_nums, $megaball_num);
        }
        foreach(@seven_megaball_nums) {
                my $megaball_num_one = $_;
        foreach(@seven_megaball_nums) {
                my $megaball_num_two = $_;
                if($megaball_num_wins{$megaball_num_one} > $megaball_num_wins{$megaball_num_two}) {
                        $lucky_megaball_num = $megaball_num_one;
                }
                elsif($megaball_num_wins{$megaball_num_two} > $megaball_num_wins{$megaball_num_one}) {
                        $lucky_megaball_num = $megaball_num_two;
                }
                elsif($megaball_num_wins{$megaball_num_one} == $megaball_num_wins{$megaball_num_two}) {
                        $lucky_megaball_num = $megaball_num_one;
                }
        }
        }
        return $lucky_megaball_num;
}

sub generate_data {
        my $possible = shift;
        my $random_data = "";
        while (length($random_data) < 1) {
                $random_data .= substr($possible, (int(rand(length($possible)))), 1);
                }
        return $random_data;
}

sub return_date {
        my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
        $year += 1900; $mon += 1;
        if ($mon == 13) { $mon = 1; }
        $mon = sprintf("%02d", $mon);
        $mday = sprintf("%02d", $mday);
        $hour = sprintf("%02d", $hour);
        $min = sprintf("%02d", $min);
        return "$year-$mon-$mday $hour:$min";
}

}
