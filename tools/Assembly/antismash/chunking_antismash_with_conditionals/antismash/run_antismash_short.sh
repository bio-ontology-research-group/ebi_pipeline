#!/bin/bash

while getopts i:o:g:n:f: option; do
	case "${option}" in
		i) INPUT=${OPTARG};;
		o) OUTFOLDER=${OPTARG};;
	esac
done

# echo "run antismash"
# if [ -z "$CONDA_ENV" ]; then
#     echo "conda enviroment is empty = using docker"
# else
#     source ${CONDA_ENV} antismash
# fi 

SCRIPT_DIR=$(dirname $(readlink -f "$BASH_SOURCE"))
ENV_DIR=$SCRIPT_DIR/antismash-env

echo "ANTISMASH: checking conda environment "
if [ ! -d $ENV_DIR ]; then
    echo "conda enviroment directory >"$ENV_DIR"< not present"
	exit -1
else
   echo "ANTISMASH: activating conda environment"
   ##eval "$(conda shell.bash hook)"
   ##conda activate "./"$ENV_DIR"/"
   eval "$(conda shell.bash hook)"
   ##source /opt/anaconda3/etc/profile.d/conda.sh
   conda activate $ENV_DIR
fi 

# echo "ANTISMASH: activating conda environment "
# ##eval "$(conda shell.bash hook)"
# /opt/anaconda3/bin/activate "./"$ENV_DIR"/"

echo "ANTISMASH: run antismash"
antismash --genefinding prodigal-m --smcogs --asf --disable-svg --knownclusterblast --outputfolder ${OUTFOLDER} ${INPUT}

