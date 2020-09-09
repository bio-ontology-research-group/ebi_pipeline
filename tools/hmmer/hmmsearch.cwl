#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
$namespaces:
 edam: http://edamontology.org/
 s: http://schema.org/

label: "Biosequence analysis using profile hidden Markov models"

hints:
  DockerRequirement:
    dockerPull: quay.io/biocontainers/hmmer:3.2.1--hf484d3e_1

requirements:
  ShellCommandRequirement: {}
  ResourceRequirement:
    ramMin: 6000
    coresMin: 32
  InlineJavascriptRequirement: {}
  ScatterFeatureRequirement: {}

baseCommand: ["hmmsearch"]

arguments:
  - valueFrom: '> /dev/null'
    shellQuote: false
    position: 10
  - valueFrom: '2> /dev/null'
    shellQuote: false
    position: 11
  - prefix: --domtblout
    valueFrom: $(inputs.seqfile.nameroot)_hmmsearch.tbl
    position: 2
  - prefix: --cpu
    valueFrom: '32'
  - prefix: -o
    valueFrom: '/dev/null'
  - valueFrom: $(inputs.path_database.path)/$(inputs.database_name)
    position: 5
    

inputs:

  omit_alignment:
    type: boolean?
    inputBinding:
      position: 1
      prefix: "--noali"

  gathering_bit_score:
    type: boolean?
    inputBinding:
      position: 4
      prefix: "--cut_ga"

  seqfile:
    format: edam:format_1929  # FASTA
    type: File
    inputBinding:
      position: 6
      separate: true

  path_database:
    type: Directory
    # inputBinding:
    #  position: 12
    #  prefix: "##_DBdir "

  database_name:
    type: string
    # inputBinding:
    #  position: 13
    #  prefix: "##_DBname "



outputs:
  output_table:
    type: File
    format: edam:format_3475
    outputBinding:
      glob: "*_hmmsearch.tbl"

$schemas:
 - http://edamontology.org/EDAM_1.20.owl
 - https://schema.org/version/latest/schemaorg-current-http.rdf

's:author': 'Ekaterina Sakharova'
's:copyrightHolder': EMBL - European Bioinformatics Institute
's:license': "https://www.apache.org/licenses/LICENSE-2.0"
