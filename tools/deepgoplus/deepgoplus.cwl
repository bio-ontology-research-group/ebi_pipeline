#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
$namespaces:
 edam: http://edamontology.org/
 s: http://schema.org/

requirements:
  ResourceRequirement:
    coresMax: 1
    ramMin: 4000
  InitialWorkDirRequirement:
    listing:
      - entry: $(inputs.database)
        writable: true

hints:
 DockerRequirement:
   dockerPull: coolmaksat/deepgoplus

inputs:
  database:
    type: Directory
    inputBinding:
     prefix: "--data-root"

  CGC_results_faa:
    type: File
    format: edam:format_1929
    inputBinding:
      prefix: -if

  output_name:
    type: string
    inputBinding:
      prefix: -of

baseCommand: ["deepgoplus"]

outputs:
  dgp_results:
    type: File
    format: edam:format_3475
    outputBinding:
      glob: "*.tsv"

##  stderr: stderr
##  stdout: stdout

$schemas:
 - http://edamontology.org/EDAM_1.16.owl
 - https://schema.org/version/latest/schemaorg-current-http.rdf

s:license: "https://opensource.org/licenses/BSD-3-Clause"
s:copyrightHolder: "BORG - Bio-Ontology Research Group KAUST"
