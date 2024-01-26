#!/bin/bash

function print_help {
	echo "usage: $0 compiler src_dir out_dir [-n] [-h] [-e] [-- cmd with args]"
	echo "  -n    launch container in non-interactive mode"
	echo "  -e    space-separated list of environment variables"
	echo "  -h    print this help"
	echo ""
	echo "  If cmd is empty, we will start an interactive bash in the container."
}

groups | grep docker
NEED_SUDO=$?

set -eu

if [ $NEED_SUDO -eq 1 ]
then
	echo "Hey, we gonna use sudo for running docker"
	SUDO_CMD="sudo"
else
	echo "Hey, you are in docker group, sudo is not needed"
	SUDO_CMD=""
fi

if [ $# -lt 3 ]
then
	print_help
	exit 1
fi

COMPILER=$1
echo "Starting \"kernel-build-container:$COMPILER\""

SRC="$2"
echo "Source code directory \"$SRC\" is mounted at \"~/src\""

OUT="$3"
echo "Build output directory \"$OUT\" is mounted at \"~/out\""

shift 3

# defaults
CIDFILE=""
ENV=""
INTERACTIVE="-it"

while [[ $# -gt 0 ]]; do
  case $1 in
    -n|--non-interactive)
      INTERACTIVE=""
      CIDFILE="--cidfile $OUT/container.id"
      echo "Run docker in NON-interactive mode"
      shift
      ;;
    -e|--env)
      for var in $2
      do
        ENV="$ENV -e $var"
      done
      shift 2
      ;;
    -h|--help)
      print_help
      exit 0
      ;;
    --)
      shift
      break
      ;;
    -*|--*)
      echo "Unknown option $1"
      print_help
      exit 1
      ;;
  esac
done

echo "Container environment: $ENV"

if [ ! -z $INTERACTIVE ]
then
	echo "Run docker in interactive mode"
fi

if [ $# -gt 0 ]
then
	echo -e "Gonna run \"$@\"\n"
else
	echo -e "Gonna run interactive bash...\n"
fi

# Z for setting SELinux label
exec $SUDO_CMD docker run $ENV $INTERACTIVE $CIDFILE --rm \
  -v $SRC:/home/$(id -nu)/src:Z \
  -v $OUT:/home/$(id -nu)/out:Z \
  kernel-build-container:$COMPILER "$@"
