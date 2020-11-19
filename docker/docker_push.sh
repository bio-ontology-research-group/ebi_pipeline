#!/usr/bin/env bash

export DOCKER_USERNAME=ashrafborg
export DOCKER_PASSWORD=

##echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

docker push ashrafborg/pipeline-v5.python3:latest
docker push ashrafborg/pipeline-v5.python2:latest
docker push ashrafborg/pipeline-v5.bash-scripts:latest

# biom-convert 
docker push ashrafborg/pipeline-v5.biom-convert:latest
# mapseq
docker push ashrafborg/pipeline-v5.mapseq:latest
# mapseq2biom
docker push ashrafborg/pipeline-v5.mapseq2biom:latest
# cmsearch-deoverlap
docker push ashrafborg/pipeline-v5.cmsearch-deoverlap:latest
# krona
docker push ashrafborg/pipeline-v5.krona:latest
# cmsearch
docker push ashrafborg/pipeline-v5.cmsearch:latest
# trimmomatic
docker push ashrafborg/pipeline-v5.trimmomatic:latest
# easel
docker push ashrafborg/pipeline-v5.easel:latest
# SeqPrep
docker push ashrafborg/pipeline-v5.seqprep:latest

# mOUTs
docker push ashrafborg/pipeline-v5.motus:latest
# filter paird reads tool 
docker push ashrafborg/pipeline-v5.filter-paired
# bedtools
docker push ashrafborg/pipeline-v5.bedtools:latest

# hmmer
docker push ashrafborg/pipeline-v5.hmmer:latest
# GO
docker push ashrafborg/pipeline-v5.go-summary:latest

# FragGeneScan
docker push ashrafborg/pipeline-v5.fraggenescan:latest
# Prodigal
docker push ashrafborg/pipeline-v5.prodigal:latest
# Prodigal + FGS post-processing
docker push ashrafborg/pipeline-v5.protein-post-processing:latest

# Genome properties
docker push ashrafborg/pipeline-v5.genome-properties:latest

# diamond
docker push ashrafborg/pipeline-v5.diamond:latest

# eggnog
docker push ashrafborg/pipeline-v5.eggnog:latest

# antismash
docker push ashrafborg/pipeline-v5.antismash:latest

# IPS
docker push ashrafborg/pipeline-v5.interproscan:latest

# DNA chunking (perl)
docker push ashrafborg/pipeline-v5.dna_chunking:latest
