#!/bin/bash

# fail if any commands fails
set -e

# debug log
set -x

# Backup

mv dvc.yaml dvc.yaml.bak
mv params.yaml params.yaml.bak
mv .dvcignore .dvcignore.bak

mkdir -p tmp/backup/.dvc
mv .dvc/config tmp/backup/.dvc/config
mv .dvc/.gitignore tmp/backup/.dvc/.gitignore

rm -rf data/generated
mv data/ tmp/backup/data/

# Destroy

rm -rf .dvc/cache
rm -rf .dvc/tmp

dvc destroy -f

aws s3 rm s3://bds-dvc/pipeline-mhqa-dspy --recursive --profile dvc

# Restore

dvc init
mv dvc.yaml.bak dvc.yaml
mv params.yaml.bak params.yaml
rm .dvcignore
mv .dvcignore.bak .dvcignore

rm .dvc/config
mv tmp/backup/.dvc/config .dvc/config

cp -r tmp/backup/data data

dvc add data/raw

rm .dvc/.gitignore
mv tmp/backup/.dvc/.gitignore .dvc/.gitignore
