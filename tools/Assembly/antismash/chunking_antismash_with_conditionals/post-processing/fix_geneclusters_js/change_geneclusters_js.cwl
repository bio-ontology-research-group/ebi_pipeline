#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

label: "change EMBL and GBK files"

requirements:
  InlineJavascriptRequirement: {}
  ResourceRequirement:
    coresMax: 1
    ramMin: 1000

hints:
  DockerRequirement:
    dockerPull: mgnify/pipeline-v5.python3:latest

inputs:
  input_geneclusters_js:
    type: File
    inputBinding:
      prefix: -i
  output_filename:
    type: string
    inputBinding:
      prefix: -o
  accession:
    type: string
    inputBinding:
      prefix: -a

baseCommand: [ change_geneclusters_ctg_js.py ]

outputs:
  fixed_js:
    type: File
    outputBinding:
      glob: $(inputs.output_filename)

$namespaces:
 edam: http://edamontology.org/
 s: http://schema.org/
$schemas:
 - http://edamontology.org/EDAM_1.20.owl
 - https://schema.org/version/latest/schema.rdf

's:author': 'Ekaterina Sakharova'
's:copyrightHolder': EMBL - European Bioinformatics Institute
's:license': "https://www.apache.org/licenses/LICENSE-2.0"