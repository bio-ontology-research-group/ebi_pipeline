#!/bin/bash

sudo chmod 666 /var/run/docker.sock
pip3 install docker
chmod 666 /var/run/docker.sock
pip3 install cwltool==3.0.20200530110633
mkdir data/


sudo apt-get --quiet install --yes libxml-libxml-perl
#wget https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/2.10.7/sratoolkit.2.10.7-ubuntu64.tar.gz
#tar xzvf sratoolkit.2.10.7-ubuntu64.tar.gz
sudo apt-get install sra-toolkit
cd data/
wget ./data/ https://sra-download.ncbi.nlm.nih.gov/traces/sra79/SRR/011381/SRR11654257
echo "Now Extracting SRR File, This may take some time"
fastq-dump --gzip SRR11654257
cd ..

git clone --depth=50 https://github.com/EBI-Metagenomics/ebi-metagenomics-cwl.git ebi-metagenomics-cwl
git clone -b rebuild_dockers https://github.com/EBI-Metagenomics/pipeline-v5

chmod +x pipeline-v5/download_dbs.sh
cd pipeline-v5/
./download_dbs.sh
cd ..

chmod +x run.sh
mv ./assembly.yml pipeline-v5/
mv ./wgs.yml pipeline-v5/
mv ./run.sh pipeline-v5/
mv RMG_41.fa.gz data/

exec bash
