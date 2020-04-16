#./1_run_varscan-2.3.9_somatic_variantCaller.sh   sample_pairs.txt

#113585  113585_TM_vs_BL BL_113585       TM_113585       BL_113585.final.bam     TM_113585.final.bam

BAM_DIR=/fs/scratch/PAS0264/Sissy.WES/
TMP_DIR=/fs/scratch/PCON0005/osu1039/Sissy.WES
PROJECT_DIR=/fs/project/PCON0005/BISR/projects/Sissy.Jhiang.WES

echo $PROJECT_DIR

mkdir $TMP_DIR
mkdir $PROJECT_DIR/logfiles
mkdir $PROJECT_DIR/Varscan


while read N OUTNAME NORMAL TUMOR NORMALBAM TUMORBAM
do

   echo $N
   echo $OUTNAME
   echo -----------------
   qsub -v "NORMALBAM=$BAM_DIR/$NORMALBAM,NORMALNAME=$TMP_DIR/$NORMAL,TUMORBAM=$BAM_DIR/$TUMORBAM,TUMORNAME=$TMP_DIR/$TUMOR,OUTPUT=$PROJECT_DIR/Varscan/$OUTNAME" \
        -N "$N" -o "$PROJECT_DIR/logfiles/varscan-log-$OUTNAME" varscan_pairs.pbs


done < $1


