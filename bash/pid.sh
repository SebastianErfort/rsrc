# PIDs
echo $!     # current pid
echo derp & # background process
wait
echo $!     # now returns bg proc's PID
