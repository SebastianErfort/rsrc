#!/usr/bin/env bash
# Create a named pipe and direct the STDOUT of a command there. It can then be used to pipe to another command.
mkfifo named.pipe
echo 'foo bar' > named.pipe
# Output example
# zip --fifo file.zip named.pipe
# rm named.pipe
