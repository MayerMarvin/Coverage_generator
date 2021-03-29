cwlVersion: v1.0
class: CommandLineTool
requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement:
    dockerPull: evolbioinfo/minimap2
  InitialWorkDirRequirement:
    listing:
      - $(inputs.basecalled_dir)

baseCommand: ["minimap2"]
arguments:
  - valueFrom: "map-ont"
    prefix: "-ax"
    position: 1
  - valueFrom: "-L"
    position: 2
  - valueFrom: ">"
    position: 5
  - valueFrom: $(inputs.output_dir)/aligment.sam
    position: 6

inputs:
  - id: reference
    type: File
    inputBinding:
      position: 3
  - id: basecalled_dir
    type: Directory
    inputBinding:
      position: 4
  - id: output_dir
    type: Directory
  - id: sample_ID
    type: string

outputs:
  - id: alignment_sam
    type: File
    outputBinding:
      glob: $(inputs.output_dir)/aligment.sam
