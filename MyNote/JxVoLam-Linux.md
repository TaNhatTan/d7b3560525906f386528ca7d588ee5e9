#### I. SETUP GAME SERVER
##### 1. Setup lib:
```
yum install glibc.i686 libuuid.i686 libstdc++.i686 libgcc.i686
```

##### 2. Setup mysql:
```
yum install mysql-server
```
***Pass default: Abcd6789***

#### II. KHÁCH HÀNG THAO TÁC:  
- Phân quyền cho các file sau có quyền execute:
```
chmod +x gateway/goddess_y gateway/bishop_y gateway/s3relay/s3relay_y server1/jx_linux_y
```
- Sửa file `goddess.cfg` phần InternetIp về IP local server
- Sửa file `bishop.cfg` phần MacAddress, Account (account này phải khác các account trước), InternetIp về IP local server
- Sửa file `s3relay/relay_config.ini` với các thông số giống `bishop.cfg`
- Sửa table serverlist (trong MySQL) trên vps window, add thêm IP + MAC IP public của server linux.
- Sửa InternetIp  của file `server1/servercfg.ini` về IP proxy
- Khách hàng bảo trì tất cả server, restart + reboot vps windb

#### III. KỸ THUẬT THAO TÁC
- Mở port game trên proxy.
- Setup IP Proxy trên GameServer.
- Cấu hình iptables để NAT port game ra proxy.
```
iptables -t nat -I PREROUTING -d <ip-backend>/32 -p tcp -m tcp --dport 6666 -j DNAT --to-destination <ip-proxy>
```

***Note: Port login: 5622 + Port game: 6666, nếu có sự thay đổi port phải báo kỹ thuật để đổi port.***
