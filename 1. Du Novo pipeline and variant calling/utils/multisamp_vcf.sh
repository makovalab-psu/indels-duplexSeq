#!/bin/bash
## Merge VCFs into one multisample VCF: De novo indels

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
#PREFIX=$( echo ${WORK_DIR} | rev | cut -d'/' -f1 | rev | sed 's/mmr_//g' | sed 's/_/./g' | sed 's/\///g' )
#PREFIX=indels
#PREFIX=relin.indels

PREFIX_OUT=$( echo ${PREFIX} | sed 's/_/./g' | sed 's/\///g' )

# Test if the required files are present.
if [ $(ls ${WORK_DIR}/${PREFIX}.[GRSh][hRs0-9][R0-9]*.vcf* | wc -l) == 0  ] ;  then
        echo "# There are no relevant VCFs in these directories."
fi

cd ${WORK_DIR}

# Bgzip all VCFs.
for FILE in $(ls *vcf | grep -v 'ALL'); do bgzip -f $FILE ; done

# Create index file.
for FILE in $(ls *vcf.gz | grep -v 'ALL'); do tabix -f -p vcf $FILE ; done


### Merge VCFs into a single multisample VCF.
### Must include 'SRR', 'G', 'Rh', 'hs' IDs for VCFs.
###bcftools merge *[ShGR][Rs0-9h][R0-9]*.vcf.gz > ${PREFIX}.ALL.vcf

## Alternative merge: Do not create new multiallelic records (--merge none).
# Must include 'SRR', 'G', 'Rh', 'hs' IDs for VCFs.
# Tests if the total == 0 before outputting.

# Create a temporary file to store non-empty VCF file paths
VCF_LIST=$(mktemp)

# Collect non-empty VCF files and write their paths to the temporary list file
for FILE in ${PREFIX}*[GRSh][hRs0-9][R0-9]*.vcf.gz; do
    if [[ $(zcat "$FILE" | wc -l) -gt 0 ]]; then
        echo "$FILE" >> "$VCF_LIST"
    else
        echo "Skipping empty file: $FILE"
    fi
done

# Check if the list file contains any valid files
if [[ -s $VCF_LIST ]]; then
    # Pass valid files directly to bcftools merge
    bcftools merge --merge none $(cat "$VCF_LIST") | tee >(wc -l | awk '{if ($1 > 0) exit 0; else exit 1}') > ${PREFIX_OUT}.ALL.${SPECIES}.vcf
else
    cat $VCF_LIST
    echo "No valid VCF files found. Exiting."
    exit 1
fi

# Remove the temporary file
rm "$VCF_LIST"
