cwlVersion: v1.0
class: CommandLineTool
requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement:
    dockerPull: nanozoo/pycoqc
  InitialWorkDirRequirement:
    listing:
      - $(inputs.output_dir)

baseCommand: ["pycoQC"]
arguments:
  - valueFrom: $(inputs.output_dir.path)/pycoQC_output.html
    prefix: "-o"
inputs:
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
      glob: $(inputs.output_dir.path)/pycoQC_output.html
#"*.html"
