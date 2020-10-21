#!/usr/bin/env
cwlVersion: v1.0
class: ExpressionTool

requirements:
  InlineJavascriptRequirement: {}


inputs:
  initial_file:
    type: File

  out_file_name:
    type: string

outputs:
  renamed_file:
    type: File

expression: |
  ${
    inputs.initial_file.basename = inputs.out_file_name;
    return { "renamed_file": inputs.initial_file };
  }


$namespaces:
 edam: http://edamontology.org/
 s: http://schema.org/
$schemas:
 - http://edamontology.org/EDAM_1.16.owl
 - https://schema.org/version/latest/schemaorg-current-http.rdf

s:license: "https://www.apache.org/licenses/LICENSE-2.0"
s:copyrightHolder: "EMBL - European Bioinformatics Institute"