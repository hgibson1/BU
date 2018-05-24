set nf [new Simulator]
$ns nametrace-all $nf

proc finish {} {
    global ns nf
    $ns flush-trace
    close $nf
    exec nam out.name &
    exit 0
}

$ns at 5.0 "finish"
$ns run
 
