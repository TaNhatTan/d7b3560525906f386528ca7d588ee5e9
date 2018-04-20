## Check DDoS

* **[I. Check number of connections](#I)**
* **[II. Check deny IPs log](#II)**

<a name="I"></a>
### I. CHECK NUMBER OF CONNECTIONS
#### [+] All IPs:
```
netstat -npt | awk '{print $5}' | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' | cut -d: -f1 | sort | uniq -c | sort -nr | head
```

#### [+] For 1 IP on Port / Gen 3
```
ss -nat | grep <IP>:<Port> | awk '{print $5}' | grep -Eo "([0-9]{1,3}\.){3}[0-9]{1,3}" | sort | uniq -c | sort -nr
```

#### [+] For 1 IP on Port / Gen4
```
conntrack -L | grep <IP> | grep <Port> | awk '{print $5}' | grep -Eo "([0-9]{1,3}\.){3}[0-9]{1,3}" | sort | uniq -c | sort -nr
```

<a name="II"></a>
#### II. CHECK DENY IPS LOG
##### 1. Proxy Gen3:
```
tail -f /var/log/lfd.log
tail -f /var/log/message
```

##### 2. Proxy Gen4:
```
watch -n1 "ipset list | grep timeout"
watch -n1 "ipset list | grep timeout | sed 's/timeout/\|/' | sed 's/ts/ts \|/' | sed 's/tes/tes \|/'"
```
