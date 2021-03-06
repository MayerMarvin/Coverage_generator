doc: Sort a bam file by read names.
cwlVersion: v1.0
class: CommandLineTool
requirements:
  DockerRequirement:
    dockerPull: kerstenbreuer/samtools:1.7
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - $(inputs.alignment_sam)

baseCommand: ["samtools", "view", "-bS"]
arguments:
  - valueFrom: ">"
    position: 4
  - valueFrom: $(inputs.output_dir.path)/alignment.bam
    position: 5

inputs:
  - id: alignment_sam
    type: File
    inputBinding:
      position: 3
  - id: sample_ID
    type: string
  - id: output_dir
    type: Directory

outputs:
  - id: alignment_bam
    type: File
    outputBinding:
      glob: $(inputs.output_dir.path)/alignment.bam
