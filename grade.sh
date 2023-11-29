CPATH='.;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone -q $1 student-submission
echo 'Finished cloning'

# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests

# Test for File existence and correct name
if [[ ! -f student-submission/ListExamples.java ]]
then
    echo ListExamples.java does not exist
    echo Please make sure ListExamples.java is nammed correctly and is in the correct directory
    exit
fi

# Copy necessary files into grading-area
cp student-submission/ListExamples.java grading-area/
cp TestListExamples.java grading-area/
cp -r lib grading-area
cd grading-area

# Compile and check for compiler errors
COMPILERERRORTXT="compile-error.txt"
javac -cp "$CPATH" *.java 2> $COMPILERERRORTXT 
if [[ $? -eq "1" ]]
then
    printf "Compiler Error: \n $(<$COMPILERERRORTXT)\n"
    printf "Score: 0"
    exit
else
    echo Compile success
fi

# Run tests
TESTS="test-output.txt"
TESTPARSE="test-parse.txt"
TESTNUMPARSE="test-ran-failed.txt"
java -cp "$CPATH" org.junit.runner.JUnitCore TestListExamples > $TESTS

VALID="valid.txt"
egrep -o "OK \(" $TESTS > $VALID

if [[ -s $VALID ]]
then
    echo All tests passed.
else
# Runs if there are failed tests
grep "Tests run: " $TESTS > $TESTPARSE
egrep -o "[0-9]+" $TESTPARSE > $TESTNUMPARSE

readarray -t RESULT < $TESTNUMPARSE

RUN=${RESULT[0]}
FAILED=${RESULT[1]}
let x=$RUN*100 y=$FAILED*100 z=x-y u=z/100
echo Score: $(($RUN-$FAILED))/$RUN
fi

