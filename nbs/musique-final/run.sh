#!/bin/sh
dvc exp run --queue \
    -S run=1 \
    -S train.dataset.path='bdsaglam/musique-mini' \
    -S train.dataset.split='train' \
    -S train.optimizer='bfsrs-medium' \
    -S train.ensemble='no' \
    -S evaluation.dataset.path='bdsaglam/musique' \
    -S evaluation.dataset.split='validation' \
    -S qa.model='llama-3-70b-tgi' \
    -S qa.temperature='0.1' \
    -S qa.technique='cok'

dvc exp run --queue \
    -S run=1 \
    -S train.dataset.path='bdsaglam/musique-mini' \
    -S train.dataset.split='train' \
    -S train.optimizer='bfsrs-medium' \
    -S train.ensemble='no' \
    -S evaluation.dataset.path='bdsaglam/musique' \
    -S evaluation.dataset.split='validation' \
    -S qa.model='llama-3-70b-tgi' \
    -S qa.temperature='0.5' \
    -S qa.technique='cok'

dvc exp run --queue \
    -S run=1 \
    -S train.dataset.path='bdsaglam/musique-mini' \
    -S train.dataset.split='train' \
    -S train.optimizer='bfsrs-medium' \
    -S train.ensemble='no' \
    -S evaluation.dataset.path='bdsaglam/musique' \
    -S evaluation.dataset.split='validation' \
    -S qa.model='llama-3-70b-tgi' \
    -S qa.temperature='0.7' \
    -S qa.technique='cok'

