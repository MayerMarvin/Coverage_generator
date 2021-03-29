doc: Sort a bam file by read names.
cwlVersion: v1.0
class: CommandLineTool
requirements:
  DockerRequirement:
    dockerPull: kerstenbreuer/samtools:1.7
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - $(inputs.alignment_bam)

baseCommand: ["samtools", "sort"]
arguments:
  - valueFrom: ">"
    position: 4
  - valueFrom: $(inputs.output_dir)/(inputs.sample_ID)/alignment.bam
    position: 5

inputs:
  - alignment_bam:
    type: File
    inputBinding:
      position: 3
  - id: sample_ID
    type: string
  - id: output_dir
    type: Directory

outputs:
  alignment_bam_sorted:
    type: File
    outputBinding:
      glob: $(inputs.output_dir)/(inputs.sample_ID)/alignment_sorted.bam
