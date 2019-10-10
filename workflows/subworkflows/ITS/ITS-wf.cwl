#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
label: "ITS SubWorkflow"

requirements:
  SubworkflowFeatureRequirement: {}
  MultipleInputFeatureRequirement: {}
  InlineJavascriptRequirement: {}
  StepInputExpressionRequirement: {}
  ScatterFeatureRequirement: {}
#  SchemaDefRequirement:
#    types:
#      - $import: ../tools/biom-convert/biom-convert-table.yaml

inputs:
  query_sequences: File
  LSU_coordinates: File
  SSU_coordinates: File
  unite_database: {type: File, secondaryFiles: [.mscluster] }
  unite_taxonomy: File
  unite_otus: File
  itsone_database: {type: File, secondaryFiles: [.mscluster] }
  itsone_taxonomy: File
  itsone_otus: File
  otu_unite_label: string
  otu_itsone_label: string

outputs:
  masking_file:
    type: Directory
    outputSource: move_masking_file/out

  unite_folder:
    type: Directory
    outputSource: run_unite/out_dir

  itsonedb_folder:
    type: Directory
    outputSource: run_itsonedb/out_dir


#ADD QUALITY CONTROLLED READS

steps:
  cat:
    run: ../../../tools/mask-for-ITS/cat-SSU-LSU.cwl
    in:
      SSU_coords: SSU_coordinates
      LSU_coords: LSU_coordinates
    out: [ all-coordinates ]

  #if proportion < 0.90 then carry on, update with potential "conditional"
  #mask SSU/LSU

  reformat_coords:
    run: ../../../tools/mask-for-ITS/format-bedfile.cwl
    in:
      all_coordinates: cat/all-coordinates
    out: [ maskfile ]

  mask_for_ITS:
    run: ../../../tools/mask-for-ITS/bedtools.cwl
    in:
      sequences: query_sequences
      maskfile: reformat_coords/maskfile
    out: [masked_sequences]

  gzip_masking:
    run: ../../../utils/gzip.cwl
    in:
      uncompressed_file: mask_for_ITS/masked_sequences
    out: [compressed_file]

  move_masking_file:
    run: ../../../utils/return_directory.cwl
    in:
      list:
        source:
          - gzip_masking/compressed_file
        linkMerge: merge_nested
      dir_name: { default: 'sequence-categorisation' }
    out: [out]

#run unite and ITSonedb

  run_unite:
    run: ../classify-otu-visualise.cwl
    in:
      fasta: mask_for_ITS/masked_sequences
      mapseq_ref: unite_database
      mapseq_taxonomy: unite_taxonomy
      otu_ref: unite_otus
      otu_label: otu_unite_label
      return_dirname: {default: 'taxonomy-summary/its/unite'}
      file_for_prefix: query_sequences
    out: [ out_dir ]

  run_itsonedb:
    run: ../classify-otu-visualise.cwl
    in:
      fasta: mask_for_ITS/masked_sequences
      mapseq_ref: itsone_database
      mapseq_taxonomy: itsone_taxonomy
      otu_ref: itsone_otus
      otu_label: otu_itsone_label
      return_dirname: {default: 'taxonomy-summary/its/itsonedb'}
      file_for_prefix: query_sequences
    out: [ out_dir ]