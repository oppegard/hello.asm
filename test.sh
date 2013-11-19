#!/bin/bash

function green {
  echo -e "$(tput setaf 2)$1$(tput sgr0)"
}

function red {
  echo -e "$(tput setaf 1)$1$(tput sgr0)"
}

function assert_zero () {
  if [ -z "$1" ]; then
    red "  FAIL: No value given to assert"
  elif [ "${1}" == 0 ]; then
    green "  PASS"
  else
    red "  FAIL: expected 0, actual was ${1}"
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
  assert_zero $?
}

function test_ld () {
  echo "test_ld:"

  ld_output=`ld -e _start -o hello hello.o 2>&1`
  assert_zero $?
  if [ -z "${ld_output}" ]; then
    green "  PASS"
  else
    red "  FAIL: expected no output, actual was ${ld_output}"
  fi
}

function test_executable () {
  echo "test_executable:"

  ./hello 2>&1 > /dev/null
  assert_zero $?
}

function test_executable_output () {
  echo "test_executable_output:"

  expected_str="Hello world!"
  exe_output=`./hello`
  if [ "${expected_str}" == "${exe_output}" ]; then
    green "  PASS"
  else
    red "  FAIL: expected '${expected_str}', actual was '${exe_output}'"
  fi
}


function cleanup () {
  rm hello.o
  rm hello
}


test_nasm
test_ld
test_executable
test_executable_output

cleanup