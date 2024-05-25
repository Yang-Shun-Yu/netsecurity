#!/bin/bash
python3 /exploit/proxy.py &
python3 /exploit/server.py --debug &
sleep 2
curl -vvv --limit-rate 100 --location --proxy socks5h://127.0.0.1:1080 http://localhost:8080