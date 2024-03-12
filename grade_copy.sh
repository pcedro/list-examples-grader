
CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission 2> cloning-output.txt
echo 'Finished cloning'

# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

if [[ -f student-submission/ListExamples.java ]]
then
    cp student-submission/*.java grading-area
    cp -r lib grading-area
else
    echo "Missing ListExamples.java file"
    echo "Score: 0"
    exit
fi

cd grading-area
# Then, add here code to compile and run, and do any post-processing of the
# tests
javac -cp $CPATH *.java

if [[ $? -ne 0 ]]
then
    echo "Compilation error"
    echo "Score: 0"
    exit
fi

java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > junit-output.txt

successes=$(grep -e "OK" junit-output.txt)
if ! (( -z $successes ))
then
    IMPORTS=$(grep -n "import" student-submission/ListExamples.java)
    if [ "$IMPORTS" != "import java.util.ArrayList;"] || [ "$IMPORTS" != "import java.util.List;
"]
    then
        echo "Illegal imports"
        echo "Score: 0%"
        exit
    fi
    echo "Score: 100%"
    exit
failed=$(grep -e "Tests" -e "Failure" junit-output.txt)
cat junit-output.txt
IMPORTS = grep -n "import" student-submission/ListExamples.java
if [ "$IMPORTS" != "import java.util.ArrayList;"] || [ "$IMPORTS" != "import java.util.List;
"]
then
    echo "Illegal imports"
    echo "Score: 0%"
    exit
fi