#!/usr/bin/perl -w

#Version 1 Proteomics

#my (%as,%protein,$id,$sequence,);

 %as = ("A" => 71.07884, 	"C" => 103.14484, 	"D" => 115.08864,	"E" => 129.11552,
 		"F" => 147.1766,	"G" => 57.05196,	"H" => 137.1412,	"I" => 113.15948,
       	"K" => 128.17416,	"L" => 113.15948,	"M" => 131.1986,	"N" => 114.10392,
        "P" => 97.11672,	"Q" => 128.1308,	"R" => 156.18764,	"S" => 87.07824,
       	"T" =>101.10512,	"V" => 99.1326,		"W" => 186.21328,	"Y" => 163.176,
       	"X" => 110,			"Z" => 110,			"B" => 110,);

open(HUMANS,"humans.fasta");

while(<HUMANS>)
{
  my $zeile = $_;
  if($zeile =~ /^\>/)
  {
    chomp($zeile);
    my @array = split(" ",$zeile);
    $array[0]=~ s/>//g;
    $id = $array[0];
    $sequence="";
  }
  else
  {
   chomp($zeile);
   $sequence= $sequence.$zeile;
  }

  
  #print $id."\n";
  #print $protein{$id}."\n";
}
close(HUMANS);



foreach my $key ( keys( %protein ) )
{
  open(_OUTFILE,">>protein.out");
  print _OUTFILE "$key:";
  #Trypsinverdau AS R und K
  $protein{$key}=~ s/K/K /g;
  $protein{$key}=~ s/R/R /g;
  my @verdau = split(" ",$protein{$key});
  
  foreach my $fragment (@verdau)
  {
    my($groesse,);
    $groesse=0;
    my @as = split("",$fragment);
    
    for(my $i=0;$i< scalar @as;$i++)
    {
      $groesse = $groesse+$as{$as[$i]};
    }
    
    	if($groesse >=800 && $groesse<=4000)
    	{
      		printf _OUTFILE ("%.2f",$groesse);
      		print _OUTFILE "|";
    	}
  }
  
  print _OUTFILE "\n";
  close(_OUTFILE);

}


