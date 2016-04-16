#!/usr/bin/perl

use Image::Magick;


my $dimension="200";

opendir(DIR,".");
@files = grep {/^[^\.]/ && /jpg/ && -e $dir.$_ } readdir(DIR);
@files = sort @files;
closedir(DIR);


foreach (@files) { print $_."\n";
	&thumbnail($_);
 }

sub thumbnail() {
	$imagename = shift;
	$image = new Image::Magick;
	$image->Read("$imagename");
	$width = $image->Get('width');
	$height = $image->Get('height');
	if ($width > 0 && $height > 0) {
		$percentw = $dimension / $width;
		$percenth = $dimension / $height;
		if ($percenth < $percentw) {
		$desty = (($height * $percentw)-$dimension) / 2;
			$destx = 0;
				$image->Resize(width=>$width*$percentw,height=>$height*$percentw,filter=>'Lanczos');
		} else {
			$destx = (($width * $percenth)-$dimension) / 2;
			$desty = 0;
			$image->Resize(width=>$width*$percenth,height=>$height*$percenth,filter=>'Lanczos');
		}
		$image->Crop($dimension.'x'.$dimension.'+'.$destx.'+'.$desty);
		$image->Set(quality=>65);
		$image->Strip();
		$image->Write(filename=>"thumbnails/$imagename");
		
	}
}
