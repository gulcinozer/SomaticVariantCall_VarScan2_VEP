
#### run vep annotation on vcf files from a given input folder

INPUTFOLDER=../Varscan

mkdir ../logfiles
mkdir ../vep-anno


for file in $INPUTFOLDER/*hc.vcf
do
 NAME=$(basename $file)

 qsub -v "INPUT=$file,OUTPUT=../vep-anno/$NAME" -N "$NAME" -o "../logfiles/vep-anno-log-$NAME"  vep_grch37.pbs 

done
