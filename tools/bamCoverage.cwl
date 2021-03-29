doc: Sort a bam file by read names.
cwlVersion: v1.0
class: CommandLineTool
requirements:
  DockerRequirement:
    dockerPull: biowardrobe2/deeptools
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - $(inputs.alignment_sorted_bam)
      - $(inputs.alignment_bam_bai)

baseCommand: ["bamCoverage"]
arguments:
  - valueFrom: $(inputs.output_dir)/(inputs.sample_ID)/coverage.bw
    position: 2
    prefix: "-o"

inputs:
  - id: sample_ID
    type: string
  - id: output_dir
    type: Directory
  - id: alignment_bam_bai
    type: File
  - id: alignment_sorted_bam
    type: File
    inputBinding:
      position: 1
      prefix: "-b"

outputs:
  coverage_bigwig:
    type: File
    outputBinding:
      glob: $(inputs.output_dir)/(inputs.sample_ID)/coverage.bw
