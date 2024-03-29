#!/bin/sh

domain=pddl/$1/domain.pddl
problems=$(find pddl/$1 -type f -name "p00*.pddl")

for problem in $problems; do
  echo $problem
  echo "HSP's plan:"
  java -cp libs/pddl4j-4.0.0.jar fr.uga.pddl4j.planners.statespace.HSP $domain $problem | grep "\[0\]"

  echo "\nSAT Planner's plan:"
  java -cp libs/*:out/production/PATIA SATEncoding $domain $problem | grep "Step"

  echo "\n"
done