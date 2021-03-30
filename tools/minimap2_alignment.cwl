cwlVersion: v1.0
class: CommandLineTool
requirements:
  InlineJavascriptRequirement: {}
#  DockerRequirement:
#    dockerPull: nanozoo/minimap2
#    dockerOutputDirectory: /storage/data2/cwl_test/alignment
  InitialWorkDirRequirement:
    listing:
      - $(inputs.output_dir)

baseCommand: ["/home/nanopore/anaconda3/envs/uncalled-env/bin/minimap2"]
arguments:
  - valueFrom: "map-ont"
    prefix: "-ax"
    position: 1
  - valueFrom: "-L"
    position: 2
#  - valueFrom: ">"
#    position: 5
#    shellQuote: False
  - valueFrom: $(inputs.output_dir.path)/alignment.sam
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

outputs:
#  alignment_sam
#    type: stdout
#stdout: $(inputs.output_dir.path)/alignment.sam

  - id: alignment_sam
    type: File
    outputBinding:
      glob: $(inputs.output_dir.path)/alignment.sam
