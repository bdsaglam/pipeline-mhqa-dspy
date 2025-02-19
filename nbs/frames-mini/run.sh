#!/bin/sh

dvc exp run --queue \
    -S run=1 \
    -S train.dataset.path='bdsaglam/frames-musique-mini' \
    -S train.dataset.name='default' \
    -S train.dataset.split='"test[:20]"' \
    -S train.optimizer='bfsrs-light' \
    -S train.ensemble='no' \
    -S evaluation.dataset.path='bdsaglam/frames-musique-mini' \
    -S evaluation.dataset.name='default' \
    -S evaluation.dataset.split='"test[20:]"' \
    -S qa.model='llama-3.3-70b' \
    -S qa.temperature='0.5' \
    -S run='1' \
    -S retrieve.model_type='golden' \
    -S retrieve.top_k='1' \
    -S qa.technique='cot'

dvc exp run --queue \
    -S run=1 \
    -S train.dataset.path='bdsaglam/frames-musique-mini' \
    -S train.dataset.name='default' \
    -S train.dataset.split='"test[:20]"' \
    -S train.optimizer='bfsrs-light' \
    -S train.ensemble='no' \
    -S evaluation.dataset.path='bdsaglam/frames-musique-mini' \
    -S evaluation.dataset.name='default' \
    -S evaluation.dataset.split='"test[20:]"' \
    -S qa.model='llama-3.3-70b' \
    -S qa.temperature='0.0' \
    -S run='1' \
    -S retrieve.model_type='golden' \
    -S retrieve.top_k='1' \
    -S qa.technique='cot'

dvc exp run --queue \
    -S run=1 \
    -S train.dataset.path='bdsaglam/frames-musique-mini' \
    -S train.dataset.name='default' \
    -S train.dataset.split='"test[:20]"' \
    -S train.optimizer='noop' \
    -S train.ensemble='no' \
    -S evaluation.dataset.path='bdsaglam/frames-musique-mini' \
    -S evaluation.dataset.name='default' \
    -S evaluation.dataset.split='"test[20:]"' \
    -S qa.model='llama-3.3-70b' \
    -S qa.temperature='0.5' \
    -S run='1' \
    -S retrieve.model_type='golden' \
    -S retrieve.top_k='1' \
    -S qa.technique='cot'

dvc exp run --queue \
    -S run=1 \
    -S train.dataset.path='bdsaglam/frames-musique-mini' \
    -S train.dataset.name='default' \
    -S train.dataset.split='"test[:20]"' \
    -S train.optimizer='miprov2-light' \
    -S train.ensemble='no' \
    -S evaluation.dataset.path='bdsaglam/frames-musique-mini' \
    -S evaluation.dataset.name='default' \
    -S evaluation.dataset.split='"test[20:]"' \
    -S qa.model='llama-3.3-70b' \
    -S qa.temperature='0.0' \
    -S run='1' \
    -S retrieve.model_type='golden' \
    -S retrieve.top_k='1' \
    -S qa.technique='cot'

dvc exp run --queue \
    -S run=1 \
    -S train.dataset.path='bdsaglam/frames-musique-mini' \
    -S train.dataset.name='default' \
    -S train.dataset.split='"test[:20]"' \
    -S train.optimizer='noop' \
    -S train.ensemble='no' \
    -S evaluation.dataset.path='bdsaglam/frames-musique-mini' \
    -S evaluation.dataset.name='default' \
    -S evaluation.dataset.split='"test[20:]"' \
    -S qa.model='llama-3.3-70b' \
    -S qa.temperature='0.0' \
    -S run='1' \
    -S retrieve.model_type='golden' \
    -S retrieve.top_k='1' \
    -S qa.technique='cot'

dvc exp run --queue \
    -S run=1 \
    -S train.dataset.path='bdsaglam/frames-musique-mini' \
    -S train.dataset.name='default' \
    -S train.dataset.split='"test[:20]"' \
    -S train.optimizer='miprov2-light' \
    -S train.ensemble='no' \
    -S evaluation.dataset.path='bdsaglam/frames-musique-mini' \
    -S evaluation.dataset.name='default' \
    -S evaluation.dataset.split='"test[20:]"' \
    -S qa.model='llama-3.3-70b' \
    -S qa.temperature='0.5' \
    -S run='1' \
    -S retrieve.model_type='golden' \
    -S retrieve.top_k='1' \
    -S qa.technique='cot'

