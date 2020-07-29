#!/bin/bash

# Get Trimmomatic v0.35
echo Trimmomatic
wget http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/Trimmomatic-0.35.zip 
unzip Trimmomatic-0.35.zip Trimmomatic-0.35
rm Trimmomatic-0.35.zip 
 
# Get BioPython v1.65
echo BioPython
pip2.7 install BioPython==1.65

# Get Infernal v1.1.2
echo Infernal
wget http://eddylab.org/infernal/infernal-1.1.2.tar.gz
tar -zxvf infernal-1.1.2.tar.gz infernal-1.1.2/
rm infernal-1.1.2.tar.gz 

# Get FragGeneScan v1.20
echo FragGeneScan
wget https://downloads.sourceforge.net/project/fraggenescan/FragGeneScan1.20.tar.gz
tar -zxvf infernal-1.1.2.tar.gz infernal-1.1.2/

# Get InterProScan v5.25.64.0
echo InterProScan
wget ftp://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/5.25-64.0/interproscan-5.25-64.0-64-bit.tar.gz 
tar -zxvf interproscan-5.25-64.0-64-bit.tar.gz interproscan-5.25-64
rm interproscan-5.25-64.0-64-bit.tar.gz 

# Get MAPSeq v1.2.2
echo MapSeq
wget https://github.com/jfmrod/MAPseq/releases/download/v1.2.2/mapseq-1.2.2-linux.tar.gz
tar -zxvf mapseq-1.2.2-linux.tar.gz  mapseq-1.2.2
rm mmapseq-1.2.2-linux.tar.gz  

# Get cmsearch_deoverlap script v0.01
echo Cmsearch
wget https://github.com/nawrockie/cmsearch_tblout_deoverlap/archive/0.01.tar.gz 
mv 0.01.tar.gz cmsearch_deoverlap_0.01.tar.gz 
tar -zxvf cmsearch_deoverlap_0.01.tar.gz cmsearch_deoverlap_0.01
rm cmsearch_deoverlap_0.01.tar.gz 

# Get SeqPrep v1.2
echo SeqPrep
wget https://github.com/jstjohn/SeqPrep/archive/v1.2.zip 
mv v1.2.zip SeqPrep_v1.2.zip 
unzip SeqPrep_v1.2.zip SeqPrep_v1.2
rm SeqPrep_v1.2.zip 
 
# Get biom-format
pip2.7 install numpy
pip2.7 install Cython
pip2.7 install biom-format==2.1.7
pip2.7 install h5py
 

## ADDITIONAL TOOLS NEEDED
## qc-stats --> get from V5 pipeline
## 
## after that search and replace all absolute paths of the form:
## /home/kibriyam/workpipelines/ebi_pipeline/externaltools/ ; OR 
## /home/kibriyam/workpipelines/ebi_pipeline/

exec bash
