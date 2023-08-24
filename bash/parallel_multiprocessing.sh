#!/bin/bash
function task1() {
    echo "Running task1..."
    sleep 5
    echo "Done task1"
}
function task2() {
    echo "Running task2..."
    sleep 2
    echo "Done task2"
}

function example1 () {
    task1 &
    task2 &
    wait
    echo "All done!"
}

# parallel commands
function sleep_some_print_some () {
    # derp
    sleep $1
    echo done $1s
}

function example2 () {
    for t in 2 5 10; do
        echo Sleeping for ${t}s...
        sleep_some_print_some $t &
    done
    wait
}

select example in example1 example2
do
    $example
done
