#!/bin/bash

source ./config.sh

GCC_VERSIONS_INPUT=()
CLANG_VERSIONS_INPUT=()

usage ()
{
  echo "Usage: $0 [options]"
  echo
  echo "Options:"
  echo "  -g version --gcc version       Build GCC container with specified version."
  echo "  -c version --clang version     Build Clang container with specified version."
  echo "  -a --all                       Build all containers."
  echo "  -h --help                      Print this help."
  echo
  echo "Supported versions:"
  echo -n "  GCC: "
  for tuple in "${GCC_UBUNTU_TUPLES[@]}"
  do
    IFS=' ' read -r -a array <<< "$tuple"
    echo -n "${array[0]} "
  done
  echo
  echo -n "  Clang: "
  for tuple in "${CLANG_GCC_UBUNTU_TUPLES[@]}"
  do

    IFS=' ' read -r -a array <<< "$tuple"
    echo -n "${array[0]} "
  done
  echo
  echo
  echo "Examples:"
  echo "  $0 -g 5 -g 6 -c 12 -c 13, builds GCC 5, 6 and Clang 12, 13 containers."
}

validate_compiler_version()
{
  local compiler_name=$1
  local compiler_version=$2
  local versions=()

  if [ "$compiler_name" = "gcc" ]
  then
    versions=("${GCC_SUPPORTED_VERSIONS[@]}")
  elif [ "$compiler_name" = "clang" ]
  then
    versions=("${CLANG_SUPPORTED_VERSIONS[@]}")
  else
    echo "Unknown compiler name: $compiler_name"
    exit 1
  fi
  
  local version=""
  for version in "${versions[@]}"
  do
    if [ "$version" = "$compiler_version" ]
    then
      return 0
    fi
  done
  return 1

}

build_gcc_container ()
{
 echo -e "\nBuilding a container with GCC_VERSION=$1 from UBUNTU_VERSION=$2"
 $SUDO_CMD docker build \
  --build-arg GCC_VERSION=$1 \
  --build-arg UBUNTU_VERSION=$2 \
  --build-arg UNAME=$(id -nu) \
  --build-arg UID=$(id -u) \
  --build-arg GID=$(id -g)  \
  -t kernel-build-container:gcc-${1} .
}


build_clang_container ()
{
 echo -e "\nBuilding a container with CLANG_VERSION=$1 and GCC_VERSION=$2 from UBUNTU_VERSION=$3"
 $SUDO_CMD docker build \
  --build-arg CLANG_VERSION=$1 \
  --build-arg GCC_VERSION=$2 \
  --build-arg UBUNTU_VERSION=$3 \
  --build-arg UNAME=$(id -nu) \
  --build-arg UID=$(id -u) \
  --build-arg GID=$(id -g)  \
  -t kernel-build-container:clang-${1} .
}

main()
{
  while [ $# -gt 0 ]
  do
    case "${1}" in
      -g|--gcc)
        shift
        GCC_VERSIONS_INPUT+=("$1")
        ;;
      -c|--clang)
        shift
        CLANG_VERSIONS_INPUT+=("$1")
        ;;
      -a|--all)
        GCC_VERSIONS_INPUT=("${GCC_SUPPORTED_VERSIONS[@]}")
        CLANG_VERSIONS_INPUT=("${CLANG_SUPPORTED_VERSIONS[@]}")
        OPT_ALL=1
        ;;
      -h|--help)
        usage
        exit 0
        ;;
      *|?)
        echo "Unknown option ${1}"
        usage
        exit 1
        ;;
    esac
    shift
  done
}

main "$@"


if [ -z "$OPT_ALL" ]
then
  # check if GCC_VERSIONS_INPUT contains only supported versions
  for v in "${GCC_VERSIONS_INPUT[@]}"
  do
    validate_compiler_version "gcc" "$v"
    if [ $? -eq 1 ]
    then
      echo "Unknown GCC version: $v"
      exit 1
    fi
  done
  # check if CLANG_VERSIONS_INPUT contains only supported versions
  for v in "${CLANG_VERSIONS_INPUT[@]}"
  do
    validate_compiler_version "clang" "$v"
    if [ $? -eq 1 ]
    then
      echo "Unknown Clang version: $v"
      exit 1
    fi
  done
fi



groups | grep docker
NEED_SUDO=$?

if [ $NEED_SUDO -eq 1 ]
then
	echo "Hey, we gonna use sudo for running docker"
	SUDO_CMD="sudo"
else
	echo "Hey, you are in docker group, sudo is not needed"
	SUDO_CMD=""
fi

set -e

# build GCC containers
for version in "${GCC_VERSIONS_INPUT[@]}"
do
  # find ubuntu version for this version
  for tuple in "${GCC_UBUNTU_TUPLES[@]}"
  do
    IFS=' ' read -r -a array <<< "$tuple"
    if [ "${array[0]}" = "$version" ]
    then
      ubuntu_version="${array[1]}"
      break
    fi
  done
  build_gcc_container ${version} ${ubuntu_version}
done

# build Clang containers
for clang_version in "${CLANG_VERSIONS_INPUT[@]}"
do
  # find ubuntu version for this clang version
  for tuple in "${CLANG_GCC_UBUNTU_TUPLES[@]}"
  do
    IFS=' ' read -r -a array <<< "$tuple"
    if [ "${array[0]}" = "$clang_version" ]
    then
      gcc_version="${array[1]}"
      ubuntu_version="${array[2]}"
      break
    fi
  done
  build_clang_container ${clang_version} ${gcc_version} ${ubuntu_version}
done
