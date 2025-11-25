This directory contains the Jupyter notebooks used to filter indels for _de novo_ events, including based on variant hotspots. To ensure proper execution, run the notebooks in the sequence listed below, as they may have dependencies on prior notebooks or generated datasets. The order is as follows:

- **`A_process_and_filter_indels.ipynb`**: Filters for _de novo_ indels based on mean mapped DCS depth, minor allele frequency, missing nucleotide calls, ambiguous timing of occurrence (includes inheritable heteroplasmies, somatic mutations, and potential early germline mutations), and potential artifacts.

- **`B1_variant_hotspots_macaque.ipynb`**: Models the expected number of indels in samples to evaluate the effect of potential hotspots per tissue. This script consider macaque samples.

- **`B2_variant_hotspots_human.ipynb`**: Similar to the previous script but considers human samples.

- **`C_filter_indels_by_hotspots.ipynb`**: Subsets _de novo_ indels by whether samples were likely affected by variant hotspots.
