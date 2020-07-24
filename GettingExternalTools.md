# Getting the external tools required
Get the following tools required by this pipeline as follows:

```
$ ## Get Trimmomatic v0.35
$ wget http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/Trimmomatic-0.35.zip 
$ 
$ ## Get BioPython v1.65
$ pip2.7 install BioPython==1.65
$ 
$ ## Get Infernal v1.1.2
$ wget http://eddylab.org/infernal/infernal-1.1.2.tar.gz 
$
$ ## Get FragGeneScan v1.20
$ wget https://downloads.sourceforge.net/project/fraggenescan/FragGeneScan1.20.tar.gz
$
$ ## Get InterProScan v5.25.64.0
$ wget ftp://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/5.25-64.0/interproscan-5.25-64.0-64-bit.tar.gz 
$
$ ## Get MAPSeq v1.2.2
$ wget https://github.com/jfmrod/MAPseq/releases/download/v1.2.2/mapseq-1.2.2-linux.tar.gz  
$
$ ## Get cmsearch_deoverlap script v0.01
$ wget https://github.com/nawrockie/cmsearch_tblout_deoverlap/archive/0.01.tar.gz 
$ mv 0.01.tar.gz cmsearch_deoverlap_0.01.tar.gz  
$
$ ## Get SeqPrep v1.2
$ wget https://github.com/jstjohn/SeqPrep/archive/v1.2.zip 
$ mv v1.2.zip SeqPrep_v1.2.zip 
$ 
$ ## Get biom-format
$ pip2.7 install numpy
$ pip2.7 install Cython
$ pip2.7 install biom-format==2.1.7
$ pip2.7 install h5py
$ 

## ADDITIONAL TOOLS NEEDED
## qc-stats --> get from V5 pipeline
## 
## after that search and replace all absolute paths of the form:
## /home/kibriyam/workpipelines/ebi_pipeline/externaltools/ ; OR 
## /home/kibriyam/workpipelines/ebi_pipeline/ 
```

Compile and setup (or symlink) the above under `externaltools/`


# Compiling Infernal 
```
> tar xf infernal-1.1.2.tar.gz
> cd infernal-1.1.2
> ./configure --prefix <target directory>
> make
> make check
> make install
```
By default, programs are installed in /usr/local/bin and man pages in /usr/local/share/man/man1/. You can change the /usr/local prefix to any directory you want using the `./configure --prefix` option, as in `./configure --prefix <target directory>`.

The EBI pipeline requires the Easel library package as well. These ARE NOT installed by default, in case you already have a copy of Easel separately installed. To install these do:
```
> cd easel 
> make install
```
