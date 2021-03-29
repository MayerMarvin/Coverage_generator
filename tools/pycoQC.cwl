cwlVersion: v1.0
class: CommandLineTool
requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement:
    dockerPull: nanozoo/pycoqc
  InitialWorkDirRequirement:
    listing:
      - $(inputs.sequencing_summary)

baseCommand: ["pycoQC"]
arguments:
  - valueFrom: $(inputs.output_dir)/(inputs.sample_ID)/(inputs.sample_ID)_pycoQC_output.html
    prefix: "-o"
inputs:
  - id: sample_ID
    type: string
  - id: sequencing_summary
    type: File
    inputBinding:
      position: 1
      prefix: "-f"
  - id: output_dir
    type: Directory
outputs:
  - id: pycoqc_output_html
    type: File
    outputBinding:
      glob: $(inputs.output_dir)/(inputs.sample_ID)/(inputs.sample_ID)_pycoQC_output.html
