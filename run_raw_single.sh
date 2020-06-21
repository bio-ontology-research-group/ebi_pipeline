#!/bin/bash

export ANALYSIS1=raw-reads
export ANALYSIS2=wgs
export TYPE=single
cwltool --enable-dev workflows/conditionals/${ANALYSIS1}-wf-${TYPE}-v.5-cond.cwl ${ANALYSIS2}.yml
