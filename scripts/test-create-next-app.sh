#!/bin/bash

START_PATH=$(pwd)
REPO_ROOT=$(realpath "$(dirname $0)/..")
TEST_ROOT="$REPO_ROOT/__create-next-app-test__"

cleanup() {
  rm -rf $TEST_ROOT
  cd $START_PATH
}

rm -rf $TEST_ROOT &&
mkdir $TEST_ROOT &&
cd $TEST_ROOT &&
npx --package=create-next-app@canary create-next-app test-app --ts &&
cd test-app &&
npm run build

if [[ ! -z $(git status -s) ]];then
  echo "!!!! Detected changes !!!! End user would get git diff after first build"
  git status

  cleanup
  
  exit 1
fi

cleanup

exit $?
