BEGIN {
    if ( !indent ) { indent=2 }
    indp=0
}
# Front matter
/---/{ if (NR==1) {fm=1} else {fm=0} }
# Skip front matter and code blocks
{
    if ( !fm ) {
        l=$0; sub(/^\s*/,"",l) # line without indentation
        indc=length($0)-length(l) # current indentation
        indd=indc - indp # indentation difference
        if ( indd > 0 ) {
            if ( indd != indent ) {
                print FILENAME
                nextfile
            }
        }
        indp=indc
    }
}
