#!/bin/bash

sudo chmod 666 /var/run/docker.sock
pip3 install cwltool==3.0.20200530110633
mkdir data/


sudo apt-get --quiet install --yes libxml-libxml-perl
wget https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/2.10.7/sratoolkit.2.10.7-ubuntu64.tar.gz
tar xzvf sratoolkit.2.10.7-ubuntu64.tar.gz
wget ./data/ https://sra-download.ncbi.nlm.nih.gov/traces/sra79/SRR/011381/SRR11654257


git clone --depth=50 https://github.com/EBI-Metagenomics/ebi-metagenomics-cwl.git ebi-metagenomics-cwl
git clone -b rebuild_dockers https://github.com/EBI-Metagenomics/pipeline-v5

chmod +x pipeline-v5/download_dbs.sh
#./pipeline-v5/download_dbs.sh

cp ./assembly.yml pipeline-v5/
cp ./wgs.yml pipeline-v5/
cp ./run.sh pipeline-v5/

exec bash
