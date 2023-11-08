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

# Compile and check for compiler errors
COMPILERERRORTXT="grading-area/compile-error.txt"
javac -cp "$CPATH" grading-area/*.java 2> $COMPILERERRORTXT 
if [[ $? -eq "1" ]]
then
    printf "Compiler Error: \n $(<$COMPILERERRORTXT)"
else
    echo Compile success
fi

# Run tests
java -cp "$CPATH" grading-area/TestListExamples.java