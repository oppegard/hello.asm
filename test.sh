#!/bin/bash

function green {
  echo -e "$(tput setaf 2)$1$(tput sgr0)"
}

function red {
  echo -e "$(tput setaf 1)$1$(tput sgr0)"
}

function test_nasm () {
  nasm -f elf hello.asm
}

function cleanup () {
  rm hello.o
}


test_nasm
if [ $? == 0 ]
  then
  green "test_nasm passed"
else
  red "test_nasm failed"
fi

cleanup