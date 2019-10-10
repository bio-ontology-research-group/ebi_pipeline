#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
label: "merges output of seqprep and unzips for paired end reads, or unzips file for single end"
requirements:
  ResourceRequirement:
    coresMax: 1
    ramMin: 100  # just a default, could be lowered

hints:
 DockerRequirement:
   dockerPull: 'alpine:3.7'
 SoftwareRequirement:
   packages: { gunzip }

inputs:

 target_reads:
   type: File
   #format: edam:format_1930  # FASTQ
   inputBinding: { position: 1 }
   label: "merged seq prep output"

 forward_unmerged_reads:
   type: File?
   #format: edam:format_1930  # FASTQ
   inputBinding: { position: 2 }
   label: "for seqprep result: unmerged forward seqprep output or single end reads"

 reverse_unmerged_reads:
   type: File?
   #format: edam:format_1930  # FASTQ
   inputBinding: { position: 3 }
   label: " unmerged reverse seqprep output"

 assembly:
    type: boolean?
    label: "is this an assembly file?"

 reads:
    type: boolean?
    label: "are these raw reads or amplicon reads?"

baseCommand: [ gunzip, -c ]

outputs:
  unzipped_merged_reads:
    type: stdout

stdout: ${ var ext = "";
       if (inputs.assembly) { ext = inputs.target_reads.nameroot.split('.')[0] + '_FASTA.fasta.unfiltered'; }
       if (inputs.reads) { ext = inputs.target_reads.nameroot.split('.')[0] + '_FASTQ.fastq'; }
       return ext; }

$namespaces:
 edam: http://edamontology.org/
 s: http://schema.org/
$schemas:
 - http://edamontology.org/EDAM_1.16.owl
 - https://schema.org/docs/schema_org_rdfa.html

s:license: "https://www.apache.org/licenses/LICENSE-2.0"
s:copyrightHolder: "EMBL - European Bioinformatics Institute"