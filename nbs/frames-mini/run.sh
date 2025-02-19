#!/bin/sh

dvc exp run --queue \
    -S train.dataset.path='bdsaglam/frames-musique-mini' \
    -S train.dataset.name='default' \
    -S train.dataset.split='"test[:20]"' \
    -S train.optimizer='bfsrs-one-shot' \
    -S train.ensemble='no' \
    -S evaluation.dataset.path='bdsaglam/frames-musique-mini' \
    -S evaluation.dataset.name='default' \
    -S evaluation.dataset.split='"test[20:]"' \
    -S qa.model='qwen-2.5-32b' \
    -S qa.temperature='0.5' \
    -S run='1' \
    -S retrieve.model_type='t5' \
    -S retrieve.top_k='2' \
    -S qa.technique='agent-decompose'

dvc exp run --queue \
    -S train.dataset.path='bdsaglam/frames-musique-mini' \
    -S train.dataset.name='default' \
    -S train.dataset.split='"test[:20]"' \
    -S train.optimizer='bfsrs-one-shot' \
    -S train.ensemble='no' \
    -S evaluation.dataset.path='bdsaglam/frames-musique-mini' \
    -S evaluation.dataset.name='default' \
    -S evaluation.dataset.split='"test[20:]"' \
    -S qa.model='qwen-2.5-32b' \
    -S qa.temperature='0.5' \
    -S run='1' \
    -S retrieve.model_type='t5' \
    -S retrieve.top_k='2' \
    -S qa.technique='multihop-decompose'

dvc exp run --queue \
    -S train.dataset.path='bdsaglam/frames-musique-mini' \
    -S train.dataset.name='default' \
    -S train.dataset.split='"test[:20]"' \
    -S train.optimizer='bfsrs-one-shot' \
    -S train.ensemble='no' \
    -S evaluation.dataset.path='bdsaglam/frames-musique-mini' \
    -S evaluation.dataset.name='default' \
    -S evaluation.dataset.split='"test[20:]"' \
    -S qa.model='qwen-2.5-32b' \
    -S qa.temperature='0.0' \
    -S run='1' \
    -S retrieve.model_type='t5' \
    -S retrieve.top_k='2' \
    -S qa.technique='multihop-decompose'

dvc exp run --queue \
    -S train.dataset.path='bdsaglam/frames-musique-mini' \
    -S train.dataset.name='default' \
    -S train.dataset.split='"test[:20]"' \
    -S train.optimizer='noop' \
    -S train.ensemble='no' \
    -S evaluation.dataset.path='bdsaglam/frames-musique-mini' \
    -S evaluation.dataset.name='default' \
    -S evaluation.dataset.split='"test[20:]"' \
    -S qa.model='qwen-2.5-32b' \
    -S qa.temperature='0.5' \
    -S run='1' \
    -S retrieve.model_type='t5' \
    -S retrieve.top_k='2' \
    -S qa.technique='agent-decompose'

dvc exp run --queue \
    -S train.dataset.path='bdsaglam/frames-musique-mini' \
    -S train.dataset.name='default' \
    -S train.dataset.split='"test[:20]"' \
    -S train.optimizer='miprov2-light' \
    -S train.ensemble='no' \
    -S evaluation.dataset.path='bdsaglam/frames-musique-mini' \
    -S evaluation.dataset.name='default' \
    -S evaluation.dataset.split='"test[20:]"' \
    -S qa.model='qwen-2.5-32b' \
    -S qa.temperature='0.5' \
    -S run='1' \
    -S retrieve.model_type='t5' \
    -S retrieve.top_k='2' \
    -S qa.technique='multihop-decompose'

dvc exp run --queue \
    -S train.dataset.path='bdsaglam/frames-musique-mini' \
    -S train.dataset.name='default' \
    -S train.dataset.split='"test[:20]"' \
    -S train.optimizer='noop' \
    -S train.ensemble='no' \
    -S evaluation.dataset.path='bdsaglam/frames-musique-mini' \
    -S evaluation.dataset.name='default' \
    -S evaluation.dataset.split='"test[20:]"' \
    -S qa.model='qwen-2.5-32b' \
    -S qa.temperature='0.5' \
    -S run='1' \
    -S retrieve.model_type='t5' \
    -S retrieve.top_k='2' \
    -S qa.technique='multihop-decompose'

dvc exp run --queue \
    -S train.dataset.path='bdsaglam/frames-musique-mini' \
    -S train.dataset.name='default' \
    -S train.dataset.split='"test[:20]"' \
    -S train.optimizer='miprov2-light' \
    -S train.ensemble='no' \
    -S evaluation.dataset.path='bdsaglam/frames-musique-mini' \
    -S evaluation.dataset.name='default' \
    -S evaluation.dataset.split='"test[20:]"' \
    -S qa.model='qwen-2.5-32b' \
    -S qa.temperature='0.5' \
    -S run='1' \
    -S retrieve.model_type='t5' \
    -S retrieve.top_k='2' \
    -S qa.technique='agent-decompose'

dvc exp run --queue \
    -S train.dataset.path='bdsaglam/frames-musique-mini' \
    -S train.dataset.name='default' \
    -S train.dataset.split='"test[:20]"' \
    -S train.optimizer='bfsrs-one-shot' \
    -S train.ensemble='no' \
    -S evaluation.dataset.path='bdsaglam/frames-musique-mini' \
    -S evaluation.dataset.name='default' \
    -S evaluation.dataset.split='"test[20:]"' \
    -S qa.model='qwen-2.5-32b' \
    -S qa.temperature='0.0' \
    -S run='1' \
    -S retrieve.model_type='t5' \
    -S retrieve.top_k='2' \
    -S qa.technique='agent-decompose'

dvc exp run --queue \
    -S train.dataset.path='bdsaglam/frames-musique-mini' \
    -S train.dataset.name='default' \
    -S train.dataset.split='"test[:20]"' \
    -S train.optimizer='miprov2-light' \
    -S train.ensemble='no' \
    -S evaluation.dataset.path='bdsaglam/frames-musique-mini' \
    -S evaluation.dataset.name='default' \
    -S evaluation.dataset.split='"test[20:]"' \
    -S qa.model='qwen-2.5-32b' \
    -S qa.temperature='0.0' \
    -S run='1' \
    -S retrieve.model_type='t5' \
    -S retrieve.top_k='2' \
    -S qa.technique='multihop-decompose'

dvc exp run --queue \
    -S train.dataset.path='bdsaglam/frames-musique-mini' \
    -S train.dataset.name='default' \
    -S train.dataset.split='"test[:20]"' \
    -S train.optimizer='noop' \
    -S train.ensemble='no' \
    -S evaluation.dataset.path='bdsaglam/frames-musique-mini' \
    -S evaluation.dataset.name='default' \
    -S evaluation.dataset.split='"test[20:]"' \
    -S qa.model='qwen-2.5-32b' \
    -S qa.temperature='0.0' \
    -S run='1' \
    -S retrieve.model_type='t5' \
    -S retrieve.top_k='2' \
    -S qa.technique='multihop-decompose'

dvc exp run --queue \
    -S train.dataset.path='bdsaglam/frames-musique-mini' \
    -S train.dataset.name='default' \
    -S train.dataset.split='"test[:20]"' \
    -S train.optimizer='bfsrs-one-shot' \
    -S train.ensemble='no' \
    -S evaluation.dataset.path='bdsaglam/frames-musique-mini' \
    -S evaluation.dataset.name='default' \
    -S evaluation.dataset.split='"test[20:]"' \
    -S qa.model='qwen-2.5-32b' \
    -S qa.temperature='0.0' \
    -S run='1' \
    -S retrieve.model_type='t5' \
    -S retrieve.top_k='2' \
    -S qa.technique='agent-simple'

dvc exp run --queue \
    -S train.dataset.path='bdsaglam/frames-musique-mini' \
    -S train.dataset.name='default' \
    -S train.dataset.split='"test[:20]"' \
    -S train.optimizer='noop' \
    -S train.ensemble='no' \
    -S evaluation.dataset.path='bdsaglam/frames-musique-mini' \
    -S evaluation.dataset.name='default' \
    -S evaluation.dataset.split='"test[20:]"' \
    -S qa.model='qwen-2.5-32b' \
    -S qa.temperature='0.0' \
    -S run='1' \
    -S retrieve.model_type='t5' \
    -S retrieve.top_k='2' \
    -S qa.technique='agent-decompose'

dvc exp run --queue \
    -S train.dataset.path='bdsaglam/frames-musique-mini' \
    -S train.dataset.name='default' \
    -S train.dataset.split='"test[:20]"' \
    -S train.optimizer='miprov2-light' \
    -S train.ensemble='no' \
    -S evaluation.dataset.path='bdsaglam/frames-musique-mini' \
    -S evaluation.dataset.name='default' \
    -S evaluation.dataset.split='"test[20:]"' \
    -S qa.model='qwen-2.5-32b' \
    -S qa.temperature='0.0' \
    -S run='1' \
    -S retrieve.model_type='t5' \
    -S retrieve.top_k='2' \
    -S qa.technique='agent-simple'

dvc exp run --queue \
    -S train.dataset.path='bdsaglam/frames-musique-mini' \
    -S train.dataset.name='default' \
    -S train.dataset.split='"test[:20]"' \
    -S train.optimizer='noop' \
    -S train.ensemble='no' \
    -S evaluation.dataset.path='bdsaglam/frames-musique-mini' \
    -S evaluation.dataset.name='default' \
    -S evaluation.dataset.split='"test[20:]"' \
    -S qa.model='qwen-2.5-32b' \
    -S qa.temperature='0.0' \
    -S run='1' \
    -S retrieve.model_type='t5' \
    -S retrieve.top_k='2' \
    -S qa.technique='agent-simple'

dvc exp run --queue \
    -S train.dataset.path='bdsaglam/frames-musique-mini' \
    -S train.dataset.name='default' \
    -S train.dataset.split='"test[:20]"' \
    -S train.optimizer='miprov2-light' \
    -S train.ensemble='no' \
    -S evaluation.dataset.path='bdsaglam/frames-musique-mini' \
    -S evaluation.dataset.name='default' \
    -S evaluation.dataset.split='"test[20:]"' \
    -S qa.model='qwen-2.5-32b' \
    -S qa.temperature='0.0' \
    -S run='1' \
    -S retrieve.model_type='t5' \
    -S retrieve.top_k='2' \
    -S qa.technique='agent-decompose'

dvc exp run --queue \
    -S train.dataset.path='bdsaglam/frames-musique-mini' \
    -S train.dataset.name='default' \
    -S train.dataset.split='"test[:20]"' \
    -S train.optimizer='bfsrs-one-shot' \
    -S train.ensemble='no' \
    -S evaluation.dataset.path='bdsaglam/frames-musique-mini' \
    -S evaluation.dataset.name='default' \
    -S evaluation.dataset.split='"test[20:]"' \
    -S qa.model='qwen-2.5-32b' \
    -S qa.temperature='0.0' \
    -S run='1' \
    -S retrieve.model_type='golden' \
    -S retrieve.top_k='1' \
    -S qa.technique='cot'

dvc exp run --queue \
    -S train.dataset.path='bdsaglam/frames-musique-mini' \
    -S train.dataset.name='default' \
    -S train.dataset.split='"test[:20]"' \
    -S train.optimizer='bfsrs-one-shot' \
    -S train.ensemble='no' \
    -S evaluation.dataset.path='bdsaglam/frames-musique-mini' \
    -S evaluation.dataset.name='default' \
    -S evaluation.dataset.split='"test[20:]"' \
    -S qa.model='qwen-2.5-32b' \
    -S qa.temperature='0.5' \
    -S run='1' \
    -S retrieve.model_type='t5' \
    -S retrieve.top_k='2' \
    -S qa.technique='agent-simple'

dvc exp run --queue \
    -S train.dataset.path='bdsaglam/frames-musique-mini' \
    -S train.dataset.name='default' \
    -S train.dataset.split='"test[:20]"' \
    -S train.optimizer='miprov2-light' \
    -S train.ensemble='no' \
    -S evaluation.dataset.path='bdsaglam/frames-musique-mini' \
    -S evaluation.dataset.name='default' \
    -S evaluation.dataset.split='"test[20:]"' \
    -S qa.model='qwen-2.5-32b' \
    -S qa.temperature='0.5' \
    -S run='1' \
    -S retrieve.model_type='t5' \
    -S retrieve.top_k='2' \
    -S qa.technique='agent-simple'

dvc exp run --queue \
    -S train.dataset.path='bdsaglam/frames-musique-mini' \
    -S train.dataset.name='default' \
    -S train.dataset.split='"test[:20]"' \
    -S train.optimizer='noop' \
    -S train.ensemble='no' \
    -S evaluation.dataset.path='bdsaglam/frames-musique-mini' \
    -S evaluation.dataset.name='default' \
    -S evaluation.dataset.split='"test[20:]"' \
    -S qa.model='qwen-2.5-32b' \
    -S qa.temperature='0.5' \
    -S run='1' \
    -S retrieve.model_type='t5' \
    -S retrieve.top_k='2' \
    -S qa.technique='agent-simple'

