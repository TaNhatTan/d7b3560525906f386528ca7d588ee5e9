#### 1. Port mạng ở backend phải được enable IPv6
 - Nếu chưa được enable thì phải enable
 - Vào property port mạng Chọn `install > protocol > Microsoft TCP/IPv6`

 ***Note: Ở bước này khi làm lần đầu thường sẽ bị màn hình xanh, sau khi khởi động lại và làm lại thì không bị nữa***

#### 2. Add IP proxy trên port mạng ở backend
 - Ví dụ ip proxy là `1.1.1.1` thì phải add thêm IP này vào port mạng ở backend bằng cách vào phần `Advanced` của port mạng
 - Khi add IP proxy, để tránh broadcast linh tinh thì tốt nhất nên add subnetmask cao nhất có thể: `255.255.255.252`; nếu ip bị add là ip broadcast của subnet đó thì giảm dần -> Ví dụ: ip `1.1.1.1` vừa là ip broadcast cho các subnetmask: `.252`,`.248`,`.240`; cho nên subnetmask được chọn là `255.255.255.224`

 ***Note: Cách tốt nhất là tìm 'trick' và add ip với subnetmask là `255.255.255.255` ( cách hay hơi mất thời gian nhưng an toàn tuyệt đối )***

#### 3. Config netsh port proxy ở backend
- Tạo file sau và để trong thư mục startup của user Administrator: `C:\Documents and Settings\Administrator\Start Menu\Programs\Startup\`. (Mục đích là portproxy tự run khi khởi động lại win)
```
[ traioi ~ ]#:/mnt/ntfs/Documents and Settings/Administrator/Start Menu/Programs/Startup# ls -la
total 8
drwxr-xr-x 2 root root  0 Jan  8 08:09 .
drwxr-xr-x 2 root root  0 Nov 19 15:10 ..
-rwxr-xr-x 1 root root 84 Nov 15 18:09 desktop.ini
-rwxr-xr-x 1 root root 99 Jan  8 07:42 proxy.bat
```
```
[ traioi ~ ]#:/mnt/ntfs/Documents and Settings/Administrator/Start Menu/Programs/Startup# cat proxy.bat
netsh interface portproxy add v4tov4 listenport=27866 connectport=6666 connectaddress=1.1.1.1
```

- Chạy file proxy.bat này
- Kiểm tra lại bằng 2 lệnh:
```
$ nestat -nao | findstr 27866
$ netsh interface portproxy show all
```

#### 4. Config ở proxy
- Ở proxy, mục đích forward về là forward về port `6666`, tuy nhiên, phải đi qua trung gian là port `27866`

```
# traioi
listen traioi_5622 1.1.1.1:5622
	source 0.0.0.0 usesrc clientip
	mode tcp
	server	sv1	10.1.1.2

listen traioi_6666 1.1.1.1:6666
	source 0.0.0.0 usesrc clientip
	mode tcp
	server	sv1	10.1.1.2:27866
```
