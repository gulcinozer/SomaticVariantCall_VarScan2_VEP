#./3_anno_to_table.sh 



module load bcftools

VCFFOLDER=../vep-anno

echo Reading vcf files from:
echo $VCFFOLDER

#read first file  (../vep-anno//113585_TM_vs_BL.indel.Germline.hc.vcf)
file1=$(ls $VCFFOLDER/*vcf |head -n1)
annoheader=$(grep "ID=CSQ" $file1 | sed -e 's/.*Format: \(.*\)\">/\1/')

OUTFILE=$VCFFOLDER/ALL_Variants.txt
printf "SAMPLE\tVARTYPE\tVARGROUP\tCHROM\tPOS\tREF\tALT\tFILTER\tDP.N\tFREQ.N\tDP.T\tFREQ.T\t$annoheader\n" > $OUTFILE-tmp

for file in $VCFFOLDER/*.vcf
do
  NAME=$(basename $file)
  echo $NAME
  sample=$(cut -d'.' -f1 <<<$NAME)
  vartype=$(cut -d'.' -f2 <<<$NAME)
  vargroup=$(cut -d'.' -f3 <<<$NAME)


  bcftools query -f  '%CHROM\t%POS\t%REF\t%ALT\t%FILTER[\t%DP\t%FREQ]\t%CSQ\n' $file > $OUTFILE-tmp2
  awk -v sample="$sample" -v vartype="$vartype" -v vargroup="$vargroup" '{print sample"\t"vartype"\t"vargroup"\t"$1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6"\t"substr($7, 1, length($7)-1)/100"\t"$8"\t"substr($9, 1, length($9)-1)/100"\t"$10}' $OUTFILE-tmp2 >> $OUTFILE-tmp

done


sed -e 's/|/\t/g' $OUTFILE-tmp > $OUTFILE

rm $OUTFILE-tmp
rm $OUTFILE-tmp2
