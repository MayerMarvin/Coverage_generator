cwlVersion: v1.0
class: CommandLineTool
requirements:
  InlineJavascriptRequirement: {}
#  DockerRequirement:
#    dockerPull: genomicpariscentre/guppy

baseCommand: ["guppy_basecaller"]
arguments:
  - valueFrom: "auto"
    prefix: "-x"
    position: 4
  - valueFrom: $(inputs.basecalled_output_dir)/(inputs.sample_ID)/
    prefix: "-s"
    position: 2
  - valueFrom: "--disable_pings"
    position: 5
inputs:
  - id: in_fast5_dir
    type: Directory
    inputBinding:
      position: 1
      prefix: "-i"
  - id: basecalled_output_dir
    type: Directory
  - id: sample_ID
    type: string
  - id: guppy_config
    type: string
    inputBinding:
      position: 3
      prefix: "-c"

outputs:
  - id: basecalled_dir
    type: Directory
    outputBinding:
      glob: $(inputs.basecalled_output_dir)/(inputs.sample_ID)/
  - id: sequencing_summary
    type: File
    outputBinding:
      glob: $(inputs.basecalled_output_dir)/(inputs.sample_ID)/sequencing_summary.txt
