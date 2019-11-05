#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow

label: "extract other ncrnas!"

requirements:
  ScatterFeatureRequirement: {}
  SubworkflowFeatureRequirement: {}
  ShellCommandRequirement: {}

inputs:
  input_sequences: {type: File, secondaryFiles: [.ssi] }
  other_ncRNA_ribosomal_models: File[]
  other_ncRNA_ribosomal_model_clans: File
  name_string: string

outputs:
  doverlapped_matches:
    type: File
    outputSource: find_ribosomal_ncRNAs/deoverlapped_matches
  ncrnas:
    type:
      type: array
      items: File
    outputSource: get_ncrnas/sequences

steps:

  find_ribosomal_ncRNAs:
    run: ../../workflows/subworkflows/cmsearch-multimodel-wf.cwl
    in:
      query_sequences: input_sequences
      covariance_models: other_ncRNA_ribosomal_models
      clan_info: other_ncRNA_ribosomal_model_clans
      targetFile: input_sequences
    out: [ deoverlapped_matches ]

  extract_coords:
    run: extract-coords_awk.cwl
    in:
      infernal_matches: find_ribosomal_ncRNAs/deoverlapped_matches
      name: name_string
    out: [ matched_seqs_with_coords ]

  get_coords:
    run: pull_ncrnas.cwl
    in:
      hits: extract_coords/matched_seqs_with_coords
      model: other_ncRNA_ribosomal_models
    out: [ matches ]

  get_ncrnas:
    run: ../easel/esl-sfetch-manyseqs.cwl
    scatter: names_contain_subseq_coords
    in:
      names_contain_subseq_coords: get_coords/matches
      indexed_sequences: input_sequences
    out: [ sequences ]






