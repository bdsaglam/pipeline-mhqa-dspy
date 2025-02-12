#!/bin/sh
dvc exp run --queue \
    -S run=1 \
    -S train.dataset.path='bdsaglam/musique-sweep' \
    -S train.dataset.split='train' \
    -S train.optimizer='noop' \
    -S train.ensemble='no' \
    -S evaluation.dataset.path='bdsaglam/musique-sweep' \
    -S evaluation.dataset.split='validation' \
    -S retrieve.model_type='golden' \
    -S retrieve.top_k='3' \
    -S qa.model='llama-3.3-70b-tgi' \
    -S qa.temperature='0.1' \
    -S qa.technique='agent-decompose'

dvc exp run --queue \
    -S run=1 \
    -S train.dataset.path='bdsaglam/musique-sweep' \
    -S train.dataset.split='train' \
    -S train.optimizer='noop' \
    -S train.ensemble='no' \
    -S evaluation.dataset.path='bdsaglam/musique-sweep' \
    -S evaluation.dataset.split='validation' \
    -S retrieve.model_type='t5' \
    -S retrieve.top_k='3' \
    -S qa.model='llama-3.3-70b-tgi' \
    -S qa.temperature='0.1' \
    -S qa.technique='agent-simple'

dvc exp run --queue \
    -S run=1 \
    -S train.dataset.path='bdsaglam/musique-sweep' \
    -S train.dataset.split='train' \
    -S train.optimizer='bfsrs-light' \
    -S train.ensemble='no' \
    -S evaluation.dataset.path='bdsaglam/musique-sweep' \
    -S evaluation.dataset.split='validation' \
    -S retrieve.model_type='golden' \
    -S retrieve.top_k='3' \
    -S qa.model='llama-3.3-70b-tgi' \
    -S qa.temperature='0.1' \
    -S qa.technique='agent-simple'

dvc exp run --queue \
    -S run=1 \
    -S train.dataset.path='bdsaglam/musique-sweep' \
    -S train.dataset.split='train' \
    -S train.optimizer='noop' \
    -S train.ensemble='no' \
    -S evaluation.dataset.path='bdsaglam/musique-sweep' \
    -S evaluation.dataset.split='validation' \
    -S retrieve.model_type='t5' \
    -S retrieve.top_k='3' \
    -S qa.model='llama-3.3-70b-tgi' \
    -S qa.temperature='0.1' \
    -S qa.technique='multihop-decompose'

dvc exp run --queue \
    -S run=1 \
    -S train.dataset.path='bdsaglam/musique-sweep' \
    -S train.dataset.split='train' \
    -S train.optimizer='noop' \
    -S train.ensemble='no' \
    -S evaluation.dataset.path='bdsaglam/musique-sweep' \
    -S evaluation.dataset.split='validation' \
    -S retrieve.model_type='golden' \
    -S retrieve.top_k='3' \
    -S qa.model='llama-3.3-70b-tgi' \
    -S qa.temperature='0.1' \
    -S qa.technique='multihop-decompose'

dvc exp run --queue \
    -S run=1 \
    -S train.dataset.path='bdsaglam/musique-sweep' \
    -S train.dataset.split='train' \
    -S train.optimizer='bfsrs-light' \
    -S train.ensemble='no' \
    -S evaluation.dataset.path='bdsaglam/musique-sweep' \
    -S evaluation.dataset.split='validation' \
    -S retrieve.model_type='golden' \
    -S retrieve.top_k='3' \
    -S qa.model='llama-3.3-70b-tgi' \
    -S qa.temperature='0.1' \
    -S qa.technique='agent-decompose'

dvc exp run --queue \
    -S run=1 \
    -S train.dataset.path='bdsaglam/musique-sweep' \
    -S train.dataset.split='train' \
    -S train.optimizer='bfsrs-light' \
    -S train.ensemble='no' \
    -S evaluation.dataset.path='bdsaglam/musique-sweep' \
    -S evaluation.dataset.split='validation' \
    -S retrieve.model_type='t5' \
    -S retrieve.top_k='3' \
    -S qa.model='llama-3.3-70b-tgi' \
    -S qa.temperature='0.1' \
    -S qa.technique='agent-decompose'

dvc exp run --queue \
    -S run=1 \
    -S train.dataset.path='bdsaglam/musique-sweep' \
    -S train.dataset.split='train' \
    -S train.optimizer='noop' \
    -S train.ensemble='no' \
    -S evaluation.dataset.path='bdsaglam/musique-sweep' \
    -S evaluation.dataset.split='validation' \
    -S retrieve.model_type='golden' \
    -S retrieve.top_k='3' \
    -S qa.model='llama-3.3-70b-tgi' \
    -S qa.temperature='0.1' \
    -S qa.technique='agent-simple'

dvc exp run --queue \
    -S run=1 \
    -S train.dataset.path='bdsaglam/musique-sweep' \
    -S train.dataset.split='train' \
    -S train.optimizer='bfsrs-light' \
    -S train.ensemble='no' \
    -S evaluation.dataset.path='bdsaglam/musique-sweep' \
    -S evaluation.dataset.split='validation' \
    -S retrieve.model_type='t5' \
    -S retrieve.top_k='3' \
    -S qa.model='llama-3.3-70b-tgi' \
    -S qa.temperature='0.1' \
    -S qa.technique='agent-simple'

dvc exp run --queue \
    -S run=1 \
    -S train.dataset.path='bdsaglam/musique-sweep' \
    -S train.dataset.split='train' \
    -S train.optimizer='noop' \
    -S train.ensemble='no' \
    -S evaluation.dataset.path='bdsaglam/musique-sweep' \
    -S evaluation.dataset.split='validation' \
    -S retrieve.model_type='t5' \
    -S retrieve.top_k='3' \
    -S qa.model='llama-3.3-70b-tgi' \
    -S qa.temperature='0.1' \
    -S qa.technique='agent-decompose'

dvc exp run --queue \
    -S run=1 \
    -S train.dataset.path='bdsaglam/musique-sweep' \
    -S train.dataset.split='train' \
    -S train.optimizer='bfsrs-light' \
    -S train.ensemble='no' \
    -S evaluation.dataset.path='bdsaglam/musique-sweep' \
    -S evaluation.dataset.split='validation' \
    -S retrieve.model_type='t5' \
    -S retrieve.top_k='3' \
    -S qa.model='llama-3.3-70b-tgi' \
    -S qa.temperature='0.1' \
    -S qa.technique='multihop-decompose'

