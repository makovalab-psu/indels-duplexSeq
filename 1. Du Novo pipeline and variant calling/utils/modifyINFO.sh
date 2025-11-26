#!/bin/bash

set -ue

# Code testing.
if [[ $# -ne 4 ]] ; then
    echo '### You need to provide one argument: [ DIR_with_VCFs ] [ Species ] [ Genome ] [ VCF_PREFIX ] ###'
    echo '### e.g. indels_denovo mouse nuDNA indels.chrM ###'
    echo '### You provided '$#' argument(s). ###'
    exit 1
fi

# Arguments.
WORK_DIR=$1
SPECIES=$2
GENOME=$3
PREFIX=$4
# PREFIX=$( echo ${WORK_DIR} | rev | cut -d'/' -f1 | rev | sed 's/mmr_//g' | sed 's/_/./g' | sed 's/\///g' )
#PREFIX=indels
#PREFIX=relin.indels
OUT_DIR="../mod.${PREFIX}"

# Test if the required files are there and not bgzipped.
if [ $(ls ${WORK_DIR}/${PREFIX}*.[RShG][hRs0-9][R0-9]*.vcf | wc -l) == 0  ] ;  then
	echo "# There are no relevant VCFs in the directory."
	echo "# They might be bgzipped (need to not be)."
fi

cd $WORK_DIR

######################################################################################################
# Replaces the last column with the INFO column (which should have the AC,AF,SB for each separate ALT).
## Has to make other changes (to FORMAT column).
### Also loses the consensus supporting reads.

for FILE in $(ls ${PREFIX}*.[RShG][hRs0-9][R0-9]*vcf); do \
	vawk --header \
	'{ $10=$8 ; gsub(/;/,":",$10) ; gsub(/AC=/,".:",$10); gsub(/AF=/,"",$10); gsub(/SB=/,"",$10); gsub(/GT:AC:AF:SB:NC/,"GT:AC:AF:SB",$9) ; print}' \
	${FILE} > ${OUT_DIR}/mod.${FILE} ; done

