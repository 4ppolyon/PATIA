#!/bin/sh

max=$(ls config | grep test* | wc -l)

echo $max

for i in $(seq 1 $max)
do
    java -cp "$(mvn dependency:build-classpath -Dmdep.outputFile=/dev/stdout -q):target/test-classes/:target/classes" \
        sokoban.LevelSolver $i
done
