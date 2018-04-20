### I. Check number of connections
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
