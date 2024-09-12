# $1 should be string to be outputed to the user
scanf () {
    unset SCANF
    print_ok "$1"
    read SCANF
}