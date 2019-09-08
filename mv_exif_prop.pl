#!/usr/bin/perl -w

use strict;
use Image::MetaData::JPEG;
use File::Basename;
#use Getopt::Std;

#my %opt;
#getopts('i:' => \%opt);

#my $type=defined($opt{i})? $opt{i}:'comment';

for my $file (@ARGV){
  get_properties($file);
}


sub get_properties{
  my ($file)=@_;

  my $image = Image::MetaData::JPEG->new($file);
  unless ($image) {
    print "$file: Cannot open file\n";
    return 1;
  }
#  print $image->get_description();
  my $segment = $image->retrieve_app1_Exif_segment(0);
  unless(defined($segment)){
    print "$file: Cannot get Exif Meta data\n";
    return 1;
  }
  my $data = $segment->get_Exif_data('SUBIFD_DATA', 'TEXTUAL');

  my $date = defined($data->{DateTimeOriginal}->[0])?
      $data->{DateTimeOriginal}->[0]:'';
  
  $date =~ s/\x00//g;

#  print "$file: $date\n";
  if($date=~/([0-9]+):([0-9]+):([0-9]+) /){
    my ($year, $month, $date) = ($1, $2, $3);
    mkdir("$year$month$date", 0755);
    print "$file: $year$month$date/".basename($file)."\n";
    rename($file, "$year$month$date/".basename($file));
  }
}

