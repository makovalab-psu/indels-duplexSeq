# Mammalian mitochondrial DNA accumulates insertions and deletions with age in energetically demanding tissues
#### This repository contains all the code generated for the manuscript.

Edmundo Torres-González, Barbara Arbeithuber, Nick Stoler, Marzia A. Cremona, Omar Shebl, Thomas Ebner, Irene Tiemann-Boege, Francisco Diaz, Francesca Chiaromonte, and Kateryna D. Makova*

*Correspondence to Kateryna D. Makova ([kdm16@psu.edu](mailto:kdm16@psu.edu))

doi: [10.1093/molbev/msag035](https://doi.org/10.1093/molbev/msag035)

## Directory Structure

This repository contains the following directories:

1. **`Du Novo pipeline and variant calling`**: Includes all Python and Bash scripts necessary for analyzing the short-read Duplex sequencing data, generating duplex consensus reads, map these to a reference genome, and perform variant calling.

2. **`Variant filtering, frequencies, and hotspots`**: Contains Jupyter notebooks for filtering indels, computing indel frequencies, and estimating the effect of variant hotspots.

3. **`Plots`**: Contains Jupyter notebooks that generated all the plots include in the manuscript.


**Some key dependencies required for the analyses in this manuscript are:**

- **`Du Novo`**: A pipeline for processing duplex sequencing data without the use of a reference.

- **`Naive Variant Caller`**: processes BAM alignments and produces a VCF containing per position variant calls.
