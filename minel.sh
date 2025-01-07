#!/bin/bash

while true; do
    echo "Starting miner..."
    ./TT-Miner -a Flex -o stratum+tcp://asia.mpool.live:5271 -u KCN=kc1qmk8nx9ur8uqvtx5rlhx4wjana5pelq9lgka35f.DOT,LCN=lc1qd7p4jl6n8tc3y4pcmtef7j28gufugqs9m688rj.DOT
    echo "Miner crashed. Restarting in 5 seconds..."
    sleep 5
done
