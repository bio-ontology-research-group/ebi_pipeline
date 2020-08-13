class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  edam: 'http://edamontology.org/'
  s: 'http://schema.org/'

baseCommand:
  - cmsearch
inputs:
  - id: covariance_model_database
    type: File
    inputBinding:
      position: 1
  - id: cpu
    type: int?
    inputBinding:
      position: 0
      prefix: '--cpu'
    label: Number of parallel CPU workers to use for multithreads
  - default: false
    id: cut_ga
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--cut_ga'
    label: use CM's' GA gathering cutoffs as reporting thresholds
  - id: omit_alignment_section
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--noali'
    label: Omit the alignment section from the main output.
    doc: This can greatly reduce the output volume.
  - default: false
    id: only_hmm
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--hmmonly'
    label: 'Only use the filter profile HMM for searches, do not use the CM'
    doc: |
      Only filter stages F1 through F3 will be executed, using strict P-value
      thresholds (0.02 for F1, 0.001 for F2 and 0.00001 for F3). Additionally
      a bias composition filter is used after the F1 stage (with P=0.02
      survival threshold). Any hit that survives all stages and has an HMM
      E-value or bit score above the reporting threshold will be output.
  - id: query_sequences
    type: File
    format: edam:format_1929  # FASTA
    inputBinding:
      position: 2
    # streamable: true
  - id: search_space_size
    type: int
    inputBinding:
      position: 0
      prefix: '-Z'
    label: search space size in *Mb* to <x> for E-value calculations

outputs:
  - id: matches
    doc: 'http://eddylab.org/infernal/Userguide.pdf#page=60'
    label: 'target hits table, format 2'
    type: File
    format: edam:format_3475
    outputBinding:
      ##glob: $(inputs.query_sequences.basename).$(inputs.covariance_model_database.split('/').slice(-1)[0]).cmsearch_matches.tbl
      glob: $(inputs.query_sequences.basename).$(inputs.covariance_model_database.basename).cmsearch_matches.tbl
  - id: programOutput
    label: 'direct output to file, not stdout'
    type: File
    format: edam:format_3475
    outputBinding:
      ##glob: $(inputs.query_sequences.basename).$(inputs.covariance_model_database.split('/').slice(-1)[0]).cmsearch.out
      glob: $(inputs.query_sequences.basename).$(inputs.covariance_model_database.basename).cmsearch.out

doc: >
  Infernal ("INFERence of RNA ALignment") is for searching DNA sequence
  databases for RNA structure and sequence similarities. It is an implementation
  of a special case of profile stochastic context-free grammars called
  covariance models (CMs). A CM is like a sequence profile, but it scores a
  combination of sequence consensus and RNA secondary structure consensus,
  so in many cases, it is more capable of identifying RNA homologs that
  conserve their secondary structure more than their primary sequence.

  Please visit http://eddylab.org/infernal/ for full documentation.

  Version 1.1.2 can be downloaded from
  http://eddylab.org/infernal/infernal-1.1.2.tar.gz
label: Search sequence(s) against a covariance model database

arguments:
  - position: 0
    prefix: '--tblout'
    ##valueFrom: $(inputs.query_sequences.basename).$(inputs.covariance_model_database.split('/').slice(-1)[0]).cmsearch_matches.tbl
    valueFrom: $(inputs.query_sequences.basename).$(inputs.covariance_model_database.basename).cmsearch_matches.tbl
  - position: 0
    prefix: '-o'
    ##valueFrom: $(inputs.query_sequences.basename).$(inputs.covariance_model_database.split('/').slice(-1)[0]).cmsearch.out
    valueFrom: $(inputs.query_sequences.basename).$(inputs.covariance_model_database.basename).cmsearch.out

hints:
  - class: SoftwareRequirement
    packages:
      infernal:
        specs:
          - 'https://identifiers.org/rrid/RRID:SCR_011809'
        version:
          - 1.1.2
  - class: DockerRequirement
    dockerPull: mgnify/pipeline-v5.cmsearch:latest

requirements:
  - class: InlineJavascriptRequirement
  - class: ResourceRequirement
    ramMin: 24000
    coresMin: 4
$schemas:
  - 'http://edamontology.org/EDAM_1.16.owl'
  - 'https://schema.org/version/latest/schemaorg-current-http.rdf'
's:copyrightHolder': EMBL - European Bioinformatics Institute
's:license': 'https://www.apache.org/licenses/LICENSE-2.0'
's:author': Michael Crusoe, Maxim Scheremetjew
