#!/bin/sh
dvc exp run --queue \
    -S run=1 \
    -S train.dataset.path='bdsaglam/musique-sweep' \
    -S train.dataset.split='train' \
    -S train.optimizer='miprov2-light' \
    -S train.ensemble='no' \
    -S evaluation.dataset.path='bdsaglam/musique-sweep' \
    -S evaluation.dataset.split='validation' \
    -S qa.model='llama-3.3-70b-tgi' \
    -S qa.temperature='0.1' \
    -S qa.technique='cot'

dvc exp run --queue \
    -S run=1 \
    -S train.dataset.path='bdsaglam/musique-sweep' \
    -S train.dataset.split='train' \
    -S train.optimizer='bfsrs-medium' \
    -S train.ensemble='no' \
    -S evaluation.dataset.path='bdsaglam/musique-sweep' \
    -S evaluation.dataset.split='validation' \
    -S qa.model='llama-3.3-70b-tgi' \
    -S qa.temperature='0.1' \
    -S qa.technique='cot'

dvc exp run --queue \
    -S run=1 \
    -S train.dataset.path='bdsaglam/musique-sweep' \
    -S train.dataset.split='train' \
    -S train.optimizer='miprov2-light' \
    -S train.ensemble='no' \
    -S evaluation.dataset.path='bdsaglam/musique-sweep' \
    -S evaluation.dataset.split='validation' \
    -S qa.model='llama-3.3-70b-tgi' \
    -S qa.temperature='0.1' \
    -S qa.technique='agent-simple'

dvc exp run --queue \
    -S run=1 \
    -S train.dataset.path='bdsaglam/musique-sweep' \
    -S train.dataset.split='train' \
    -S train.optimizer='bfsrs-medium' \
    -S train.ensemble='no' \
    -S evaluation.dataset.path='bdsaglam/musique-sweep' \
    -S evaluation.dataset.split='validation' \
    -S qa.model='llama-3.3-70b-tgi' \
    -S qa.temperature='0.1' \
    -S qa.technique='agent-simple'

