print () {
    echo -n "$1"
}

println () {
    echo "$1"
}

print_ok () {
    echo -n -e "$BGreen"
    print "$1"
    echo -n -e "$Color_Off"
}

println_ok () {
    echo -n -e "$BGreen"
    println "$1"
    echo -n -e "$Color_Off"
}

print_imp () {
    echo -n -e "$BBlue"
    print "$1"
    echo -n -e "$Color_Off"
}

println_imp () {
    echo -n -e "$BBlue"
    println "$1"
    echo -n -e "$Color_Off"
}

print_err () {
    echo -n -e "$BRed"
    print "$1"
    echo -n -e "$Color_Off"
}

println_err () {
    echo -n -e "$BRed"
    println "$1"
    echo -n -e "$Color_Off"
}