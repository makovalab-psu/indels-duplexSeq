This directory contains the Jupyter notebooks required to identify indels from duplex sequencing data. To ensure proper execution, run the notebooks in the sequence listed below, as they may have dependencies on prior notebooks or generated datasets. The order is as follows:

- `A_dunovo.job`: Generates duplex consensus sequences (DCS) from sequencing reads using the `Du Novo pipeline` (https://github.com/galaxyproject/dunovo).

- `B_mapping.job`: Maps the DCS to the corresponding species' mtDNA reference genome using `BWA MEM` (https://github.com/lh3/bwa).

- `C_mapping_multipleSRRs.job`: Follows the same steps as `B_mapping.job` but for samples with multiple sequencing runs for the same sample.

- `D_variant_calling.job`: Performs variant calling on sequence alignment using `Naive Variant Caller` (https://github.com/blankenberg/nvc).

- `E_get_indels.job`: Filters VCF for indels by excluding nucleotide substitutions.

- `F_mean_mapped_read_depth.job`: Computes mean mapped read depth across mtDNA positions for each sample using `SAMTOOLS MPILEUP` (https://www.htslib.org/doc/samtools-mpileup.html) and BASH commands.

- `G_mergeVCFs.job`: Merges variant calls across samples into a single file per species.
