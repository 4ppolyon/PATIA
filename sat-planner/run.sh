#!/bin/sh

javac -cp "libs/*" -d build src/*.java

java -cp libs/*:build/ $@