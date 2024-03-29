#!/bin/sh

touch config.txt

if [ -z "$1" ]; then
    echo "Usage: ./run.sh <level>"
    exit 1
fi

echo $1 > config.txt

mkdir -p plans

java --add-opens java.base/java.lang=ALL-UNNAMED \
      -server -Xms2048m -Xmx2048m \
      -cp "$(mvn dependency:build-classpath -Dmdep.outputFile=/dev/stdout -q):target/test-classes/:target/classes" \
      sokoban.SokobanMain
