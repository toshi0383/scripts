/\t\t\tbuildSettings/ {
    B="filter"
    print $0
}
!/\t\t\tbuildSettings/ {
    if (B != "filter") {
        print $0
    } else {
        if ($1 == "\t\t\t};") {
            B=""
            print $0
        }
    }
}
