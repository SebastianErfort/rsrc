# TODO
# - quotes `>`?
# Front matter
/---/{
    if (NR==1) {fm=1} else {fm=0}
}
# Fenced code blocks
/```/{ cb++ }
!fm && ( cb % 2 == 0 ) {
    if ( m&&/^\s*[-+\*] / ) {
        l=$0
        sub(/^\s*/,"",l)
        indc=length($0)-length(l) # indentation
        if ( indc >= indp ){ print "" }
    }
    {
        l=$0
        sub(/^\s*/,"",l)
        indp=length($0)-length(l) # indentation
        if (/^\s*$|^\s*[-+\*]/) {
            m=0
        } else {
            m=1
        }
    }
}
{ print }
