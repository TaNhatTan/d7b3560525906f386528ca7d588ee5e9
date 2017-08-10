016# X. Cài đặt mô hình Reverse Proxy

* **[1. Cài đặt dịch vụ Nginx](README.md#chapter-1)**
* **[2. Cài đặt dịch vụ Httpd](README2.md#chapter-2)**
* **[3. Cài đặt PHP](README3.md#chapter-3)**
* **[4. Cài đặt dịch vụ MySQL](README4.md#chapter-4)**
* **[5. Cấu hình Reverse Proxy](README5.md#chapter-5)**
* **[6. Cấu hình vhost](README6.md#chapter-6)**

<a name="chapter-5"></a>
## 5. Cấu hình Reverse Proxy

### a. Giới thiệu

- Nhược điểm của Apache là kém linh hoạt, xử lí chậm và chiếm nhiều bộ nhớ mỗi khi xử lí dữ liệu dù là tĩnh hay động.
- Nginx có tốc độ xử lí nhanh hợn, linh hoạt và nhẹ hơn Apache nhưng Nginx khi xử lí các dữ liệu PHP thì đôi lúc sẽ hoạt động không như ý muôn.
- Sử dụng Nginx làm reverse proxy cho Apache giúp tiết kiệm tài nguyên và xử lí các trang web nhanh hơn. Nginx sẽ làm trung gian gửi dữ liệu đã xử lí thông qua Apache đến trình duyệt.
- Tóm gọn là Apache xử lí tốt các dữ liệu thực thi từ backend như PHP, còn Nginx xử lí tốt các dữ liệu tĩnh (như HTML, CSS, JS, các tập tin hình ảnh, ..) đặc biệt là cache.

### b. How does it work

- Ở đây Apache sẽ xử lí PHP thông qua module mod_php, còn Nginx sẽ có nhiệm vụ đọc dữ liệu nhận được, xử lí các file tĩnh, cache.
- Trình duyệt sẽ đọc dữ liệu từ server truyền về thông qua cổng 80 (Nginx), lúc này Nginx sẽ tự động gửi các truy vấn từ file có đuôi mở rộng là .php đến cổng của Apache (8080) cho Apache xử lí rồi Apache trả dữ liệu lại cho Nginx, Nginx gửi lại trình duyệt cho người đọc.

### c. Cấu hình

#### Cấu hình backend

##### Yêu cầu
- Thay đổi cổng dịch vụ trên Apache để trình duyệt không thể đọc trực tiếp.
```
$ vi /etc/httpd/conf/httpd.conf
..
Listen 8080
..
```

- Cài đặt module `remoteip`. `remoteip` sẽ nhận X-Forwarded-For header từ proxy server và điều chỉnh lại remote address của client.
```
$ mkdir /data/httpd/mod_remoteip/
$ cd /data/httpd/mod_remoteip/
$ wget https://svn.apache.org/repos/asf/httpd/httpd/trunk/modules/metadata/mod_remoteip.c
$ apxs -n remoteip -cia mod_remoteip.c
$ vi /etc/httpd/conf.d/modules.conf
..
LoadModule remoteip_module /usr/sbin/modules/mod_remoteip.so
```

##### Các biến cấu hình

- RemoteIPHeader
> - **Mô tả**: Khai báo trường header sẽ được sử dụng cho địa IP useragent.
> - **Cú pháp**: RemoteIPHeader header-field
> - **Ví dụ**: RemoteIPHeader X-Forwarded-For

- RemoteIPInternalProxy
> - **Mô tả**: Khai báo địa chỉ IP intranet của clients tin cậy.
> - **Cú pháp**: RemoteIPInternalProxy proxy-ip|proxy-ip/subnet|hostname ...
> - **Ví dụ**: RemoteIPInternalProxy 192.168.56.101

- RemoteIPProxyList
> - **Mô tả**: Khai báo địa chỉ IP intranet của clients tin cậy.
> - **Cú pháp**: RemoteIPProxyList filename
> - **Ví dụ**: RemoteIPInternalProxyList proxy/trusted-proxies.lst
> ```
> $ cat proxy/trusted-proxies.lst
> 192.168.56.101
> 192.168.57.101
> ```

- RemoteIPProxiesHeader
> - **Mô tả**: Khai báo trường header sẽ ghi lại các địa chỉ IP trung gian.
> - **Cú pháp**: RemoteIPProxiesHeader HeaderFieldName
> - **Ví dụ**: RemoteIPProxiesHeader X-Forwarded-By

- RemoteIPTrustedProxy
> - **Mô tả**: Khai báo địa chỉ IP intranet của clients tin cậy.
> - **Cú pháp**: RemoteIPTrustedProxy proxy-ip|proxy-ip/subnet|hostname ...
> - **Ví dụ**: RemoteIPTrustedProxy 10.0.2.16/28

- RemoteIPTrustedProxyList
> - **Mô tả**: Khai báo địa chỉ IP intranet của clients tin cậy.
> - **Cú pháp**: RemoteIPTrustedProxyList filename
> - **Ví dụ**: RemoteIPInternalProxyList proxy/trusted-proxies.lst
> ```
> $ cat proxy/trusted-proxies.lst
> 192.168.56.101
> 192.168.57.101
> ```

#### Cấu hình frontend

-
