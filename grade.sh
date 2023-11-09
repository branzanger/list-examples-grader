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
    printf "Compiler Error: \n $(<$COMPILERERRORTXT)"
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
echo $(($(($RUN*100-$FAILED*100))/100))
fi

