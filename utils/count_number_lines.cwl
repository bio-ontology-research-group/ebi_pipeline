#!/usr/bin/env
cwlVersion: v1.0
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}
  ResourceRequirement:
    coresMax: 1
    ramMin: 200  # just a default, could be lowered

hints:
  - class: DockerRequirement
    dockerPull: 'alpine:3.7'

inputs:
  input_file:
    type: File
    streamable: true

baseCommand: [ sh ]

arguments:
  - valueFrom: |
      expr \$(cat $(inputs.input_file.path) | wc -l)
    prefix: -c

stdout: count

outputs:
  number:
    type: int
    outputBinding:
      glob: count
      outputEval: $(Number(self[0].contents))
      loadContents: true


$namespaces:
 edam: http://edamontology.org/
 s: http://schema.org/
$schemas:
 - http://edamontology.org/EDAM_1.16.owl
 - https://schema.org/version/latest/schemaorg-current-http.rdf

s:license: "https://www.apache.org/licenses/LICENSE-2.0"
s:copyrightHolder: "EMBL - European Bioinformatics Institute"