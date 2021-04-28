# Coverage_generator
CWL pipeline for basecalling, alignment and production of coverage.bigwig files from Oxford Nanopore Sequencing data


## Pipeline Overview
![Workflow Visualization](https://github.com/MayerMarvin/Coverage_generator/blob/main/coverage_generator_visualization.png)

### Used tools
The first rule consists of basecalling the fast5 files with the help of guppy. A local installation of guppy was used to parallelize basecalling using Graphics Processing Unit (GPU) for faster analysis. Subsequently, the alignment of the reads to the reference genome hg19 (https://www.ncbi.nlm.nih.gov/) was performed using minimap2 (Li 2018). The obtained sequence alignment map (SAM) file was converted to a compressed binary version of a SAM file using SAMtools, sorted, and then indexed. This BAM file is then converted to a coverage bigwig file by deepTools (Ramírez et al. 2016) using the command bamToCoverage. In addition, pycoQC was used to perform sequencing quality controls of the nanopore sequencing run and create a summary HTML document. All tools, except guppy, were used in a dockerized container version to simplify the transfer of the pipeline for another user on a different operating systems.
