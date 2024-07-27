#!/bin/bash

[[ ! -d node_modules ]] && echo abort: directory node_modules is missing && exit 1


# https://github.com/xthezealot/npmprune/blob/master/npmprune.sh
# base patterns + prod patterns + personnal additions
PATTERNS="
  __tests__
  _config.yml
  .*ignore
  .babel*
  .circle*
  .documentup*
  .ds_store
  .editorconfig
  .env*
  .git*
  .idea
  .lint*
  .npm*
  .nyc*
  .prettier*
  .tern-project
  .yarn-integrity
  .yarn-metadata.json
  .yarnclean
  .yo-*
  *.coffee
  *.flow*
  *.jst
  *.markdown
  *.md
  *.mkd
  *.swp
  *.tgz
  *appveyor*
  *coveralls*
  *eslint*
  *htmllint*
  *jshint*
  *readme*
  *stylelint*
  *travis*
  *tslint*
  *vscode*
  *wallaby*
  authors
  changelog
  changes
  circle.yml
  component.json
  contributors
  coverage
  doc
  docs
  example
  examples
  grunt*
  gulp*
  jenkins*
  jest.config.*
  jsconfig.json
  karma.conf*
  licence
  licence.txt
  license
  license.txt
  makefile
  npm-debug.log
  powered-test
  prettier.*
  test
  tests
  tsconfig.json

  *.map
  *.mts
  *.ts

  *.cts
  *.cjs
  tsup.config.js
  rollup.config.js
  babel.config.js
  .releaser.json
  .browserslistrc
"


# files count + total size before
COUNT_1=$(find node_modules | wc -l | xargs)
SIZE_1=$(du -sk node_modules | xargs | cut -f1 -d' ')

echo "$PATTERNS" | xargs | tr ' ' '\n' | while read p; do
  find node_modules -iname "$p" -exec rm -fr {} +
done


# skip if silent mode
[[ -n "$NODE_PRUNE_SILENT" ]] && exit

# files count + total size after
COUNT_2=$(find node_modules | wc -l | xargs)
SIZE_2=$(du -sk node_modules | xargs | cut -f1 -d' ')


# compute files removed
COUNT=$(bc <<< "$COUNT_1 - $COUNT_2")

# compute size removed
SIZE=$(bc -l <<< "($SIZE_1 - $SIZE_2) * 0.001")
[[ ${SIZE:0:1} == '.' ]] && SIZE=0${SIZE};
SIZE=$(awk -v v=$SIZE 'BEGIN{i=index(v,"."); if(i==0){print v}; print substr(v,0,i+2) }')


echo
printf "$(tput bold)         files total$(tput sgr0) %i\n" $COUNT_2
printf "$(tput bold)       files removed$(tput sgr0) %i\n" $COUNT
printf "$(tput bold)        size removed$(tput sgr0) %s Mb\n" $SIZE
echo
