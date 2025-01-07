#!/bin/bash

while true; do
    echo "Starting miner..."
    ./TT-Miner -a Flex -o stratum+tcp://eu.mpool.live:5271 -u LCN=lc1qd7p4jl6n8tc3y4pcmtef7j28gufugqs9m688rj.TEST
    echo "Miner crashed. Restarting in 5 seconds..."
    sleep 5
done
