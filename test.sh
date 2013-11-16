#!/bin/bash

function green {
  echo -e "$(tput setaf 2)$1$(tput sgr0)"
}

function red {
  echo -e "$(tput setaf 1)$1$(tput sgr0)"
}

function assert_result () {
  if [ -z "$1" ]; then
    red "  FAIL: No value given to assert"
  elif [ "${1}" == 0 ]; then
    green "  PASS"
  else
    red "  FAIL: expected 0, actual ${1}"
  fi
}

function test_nasm () {
  echo "test_nasm:"

  arch=$(/usr/bin/arch)
  if [ "${arch}" == "x86_64" ]; then
    elf_arch="elf64"
  else
    elf_arch="elf32"
  fi

  nasm -f "${elf_arch}" hello.asm
  assert_result $?
}

function test_ld () {
  echo "test_ld:"

  ld -e _start -o hello hello.o
  assert_result $?
}

function test_executable () {
  echo "test_executable:"

  ./hello
  assert_result $?
}

function cleanup () {
  rm hello.o
  rm hello
}


test_nasm
test_ld
test_executable

cleanup