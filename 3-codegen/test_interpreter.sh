#!/bin/bash

# Try to find a portable way of getting rid of
# any stray carriage returns
if which dos2unix ; then
    DOS2UNIX="dos2unix"
elif which fromdos ; then
    DOS2UNIX="fromdos"
else
    # This works on a GNU version of sed. I think this
    # will work in OSX as well, but don't have a machine
    # on which to test that. From reading the OSX docs,
    # it looks compatible.
    # The code \x0D is the ASCII code of carriage-return,
    # so it the regex should delete any CRs at the end of
    # a line (or anywhere in a line)
    DOS2UNIX="sed -e s/\x0D//g -"
    # Tested for combinations of:
    # - Ubuntu
    # - Cygwin
    # and inputs formats:
    # - LF
    # - CRLF
fi

mkdir -p working

echo "========================================"
echo " Cleaning the temporaries and outputs"
make clean

echo "========================================"
echo " Force building interpreter"
make -B bin/interpreter
if [[ "$?" -ne "0" ]]; then
    echo "Error while building interpret."
    exit 1;
fi

echo "========================================="

PASSED=0
CHECKED=0

for i in test/programs/*; do
    b=$(basename ${i});
    mkdir -p working/$b

    PARAMS=$(head -n 1 $i/in.params.txt | ${DOS2UNIX} );

    echo "==========================="
    echo ""
    echo "Input file : ${i}"
    echo "Testing $b, params = ${PARAMS}"

    OK=0;

    bin/interpreter $i/in.code.txt ${PARAMS}  \
      < $i/in.input.txt \
      > working/$b/got.output.txt \
      2> working/$b/got.stderr.txt

    GOT_RESULT=$?;

    echo "${GOT_RESULT}" > working/$b/got.result.txt

    REF_RESULT=$(head -n 1 $i/ref.result.txt | ${DOS2UNIX} );

    if [[ "${GOT_RESULT}" -ne "${REF_RESULT}" ]]; then
        echo "  got result : ${GOT_RESULT}"
        echo "  ref result : ${REF_RESULT}"
        echo "  FAIL!";
        OK=1;
    fi

    GOT_OUTPUT=$(echo $(cat working/$b/got.output.txt | ${DOS2UNIX} ))
    REF_OUTPUT=$(echo $(cat $i/ref.output.txt | ${DOS2UNIX} ))

    if [[ "${GOT_OUTPUT}" != "${REF_OUTPUT}" ]]; then
        echo "  got output : ${GOT_OUTPUT}"
        echo "  ref output : ${REF_OUTPUT}"
        echo "  FAIL!";
        OK=1;
    fi

    if [[ "$OK" -eq 0 ]]; then
        PASSED=$(( ${PASSED}+1 ));
    fi

    CHECKED=$(( ${CHECKED}+1 ));
    echo ""
done


echo "########################################"
echo "Passed ${PASSED} out of ${CHECKED}".
echo ""

RELEASE=$(lsb_release -d)
if [[ $? -ne 0 ]]; then
    echo ""
    echo "Warning: This appears not to be a Linux environment"
    echo "         Make sure you do a final run on a lab machine or an Ubuntu VM"
else
    grep -q "Ubuntu 16.04" <(echo $RELEASE)
    FOUND=$?

    if [[ $FOUND -ne 0 ]]; then
        echo ""
        echo "Warning: This appears not to be the target environment"
        echo "         Make sure you do a final run on a lab machine or an Ubuntu VM"
    fi
fi
