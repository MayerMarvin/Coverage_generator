cwlVersion: v1.0
class: Workflow
requirements:
  StepInputExpressionRequirement: {}
  InlineJavascriptRequirement: {}
inputs:
  - id: sample_ID
    type: string
  - id: in_fast5_dir
    type: Directory
  - id: reference
    type: File
  - id: threads
    type: int
  - id: basecalled_output_dir
    type: Directory
  - id: output_dir
    type: Directory
  - id: guppy_config
    type: string


steps:
    - id: guppy_basecall
      run: "../tools/guppy_basecall.cwl"
      in:
        - id: in_fast5_dir
          source: in_fast5_dir
        - id: basecalled_output_dir
          source: basecalled_output_dir
        - id: guppy_config
          source: guppy_config
      out:
        - id: basecalled_dir
        - id: sequencing_summary

#    - id: pycoqc
#      run: "../tools/pycoQC.cwl"
#      in:
#        - id: sequencing_summary
#          source: guppy_basecall/sequencing_summary
#        - id: output_dir
#          source: output_dir
#      out:
#        - id: pycoqc_output_html

    - id: minimap2_alignment
      run: "../tools/minimap2_alignment.cwl"
      in:
        - id: reference
          source: reference
        - id: basecalled_dir
          source: guppy_basecall/basecalled_dir
        - id: output_dir
          source: output_dir
      out:
        - id: alignment_sam

    - id: samtools_bam
      run: "../tools/samtools_bam.cwl"
      in:
        - id: alignment_sam
          source: minimap2_alignment/alignment_sam
        - id: sample_ID
          source: sample_ID
        - id: output_dir
          source: output_dir
      out:
        - id: alignment_bam

    - id: samtools_sort
      run: "../tools/samtools_sort.cwl"
      in:
        - id: alignment_bam
          source: samtools_bam/alignment_bam
        - id: sample_ID
          source: sample_ID
        - id: output_dir
          source: output_dir
      out:
        - id: alignment_sorted_bam

    - id: samtools_index
      run: "../tools/samtools_index.cwl"
      in:
        - id: alignment_sorted_bam
          source: samtools_sort/alignment_sorted_bam
        - id: sample_ID
          source: sample_ID
        - id: output_dir
          source: output_dir
      out:
        - id: alignment_bam_bai

    - id: bamCoverage
      run: "../tools/bamCoverage.cwl"
      in:
        - id: alignment_sorted_bam
          source: samtools_sort/alignment_sorted_bam
        - id: alignment_bam_bai
          source: samtools_index/alignment_bam_bai
        - id: sample_ID
          source: sample_ID
        - id: output_dir
          source: output_dir
      out:
        - id: coverage_bigwig


outputs:
#  - id: pycoqc_output
#    type: File
#    outputSource: pycoqc/pycoqc_output_html
  - id: coverage_bigwig
    type: File
    outputSource: bamCoverage/coverage_bigwig
  - id: alignment_sam
    type: File
    outputSource: minimap2_alignment/alignment_sam
