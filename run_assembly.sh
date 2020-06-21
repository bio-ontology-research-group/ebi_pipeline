#!/bin/bash

export ANALYSIS=assembly

cwltool --enable-dev workflows/conditionals/${ANALYSIS}-wf--v.5-cond.cwl ${ANALYSIS}.yml
