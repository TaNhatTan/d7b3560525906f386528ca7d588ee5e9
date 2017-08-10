# X. Cài đặt mô hình Reverse Proxy

* **[1. Cài đặt dịch vụ Nginx](README.md#chapter-1)**
* **[2. Cài đặt dịch vụ Httpd](README2.md#chapter-2)**
* **[3. Cài đặt PHP](README3.md#chapter-3)**
* **[4. Cài đặt dịch vụ MySQL](README4.md#chapter-4)**
* **[5. Cấu hình Reverse Proxy](README5.md#chapter-5)**
* **[6. Cấu hình vhost](README6.md#chapter-6)**

<a name="chapter-2"></a>
## 2. Cài đặt dịch vụ Httpd

### a. Compiling from sources

- Apache httpd sử dụng *libtool* và *autoconf* để tạo môi trường cài đặt giống như các project Open Source khác.

#### Yêu cầu

- Tải Apache httpd.
```
$ wget http://mirrors.viethosting.com/apache//httpd/httpd-2.4.25.tar.gz
$ tar -xvzf httpd-2.4.25.tar.gz
```

- Tải APR (Apache Portable Runtime).
```
$ wget http://mirrors.viethosting.com/apache//apr/apr-1.6.2.tar.gz
$ tar -xvzf apr-1.6.2.tar.gz
$ mkdir httpd-2.4.25/srclib/apr
$ mv apr-1.6.2/* httpd-2.4.25/srclib/apr/
```
- Tải APR-Util.
```
$ wget http://mirrors.viethosting.com/apache//apr/apr-util-1.6.0.tar.gz
$ tar -xvzf apr-util-1.6.0.tar.gz
$ mkdir httpd-2.4.25/srclib/apr-util
$ mv apr-util-1.6.0/* httpd-2.4.25/srclib/apr-util/
```

#### Compile httpd from source

```
$ cd httpd-2.4.25
$ ./configure           \
--bindir=/usr/bin       \
--sbindir=/usr/sbin     \
--prefix=/etc/httpd     \
--exec-prefix=/usr/sbin \
--with-included-apr     \
--enable-so             \
--enable-auth-digest    \
--enable-rewrite        \
--enable-deflate        \
--enable-headers
```
> **Note:**
>
> - ***enable-so***: Cho phép cài đặt module của bên thứ ba.
> - ***enable-auth-digest***: Module cho phép xác thực người dùng sử dụng MD5.
> - ***enable-rewrite***: Module cho phép viết lại các rule áp dụng cho URL trên `httpd.conf`, `.htaccess`.
> - ***enable-deflate***: Sử dụng zlib nén nội dung trước khi chuyển cho client.
> - ***enable-headers***: Tuỳ chỉnh HTTP request và response headers.

```
$ make
$ make install
```

#### Cấu hình

- Thêm `httpd` vào `systemd`.
```
$ vi /usr/lib/systemd/system/httpd.service
[Unit]
Description=MySQL Server
After=network.target remote-fs.target nss-lookup.target

[Service]
Type=forking
PIDFile=/etc/httpd/logs/httpd.pid
ExecStart=/usr/sbin/apachectl start
ExecStop=/usr/sbin/apachectl graceful-stop
ExecReload=/usr/sbin/apachectl graceful
PrivateTmp=true
LimitNOFILE=infinity

[Install]
WantedBy=multi-user.target
```

#### Cấu hình sau compile

- Start Httpd on boot
```
$ systemctl enable httpd
```

#### Lỗi phát sinh

- fatal error: expat.h: No such file or directory
```
$ make
...
Making all in apr-util
make[2]: Entering directory `/root/httpd/httpd-2.4.25/srclib/apr-util'
make[3]: Entering directory `/root/httpd/httpd-2.4.25/srclib/apr-util'
/bin/sh /root/httpd/httpd-2.4.25/srclib/apr/libtool --silent --mode=compile gcc -g -O2 -pthread   -DHAVE_CONFIG_H  -DLINUX -D_REENTRANT -D_GNU_SOURCE   -I/root/httpd/httpd-2.4.25/srclib/apr-util/include -I/root/httpd/httpd-2.4.25/srclib/apr-util/include/private  -I/root/httpd/httpd-2.4.25/srclib/apr/include    -o xml/apr_xml.lo -c xml/apr_xml.c && touch xml/apr_xml.lo
xml/apr_xml.c:35:19: fatal error: expat.h: No such file or directory
 #include <expat.h>
                   ^
compilation terminated.
make[3]: *** [xml/apr_xml.lo] Error 1
make[3]: Leaving directory `/root/httpd/httpd-2.4.25/srclib/apr-util'
make[2]: *** [all-recursive] Error 1
make[2]: Leaving directory `/root/httpd/httpd-2.4.25/srclib/apr-util'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/root/httpd/httpd-2.4.25/srclib'
make: *** [all-recursive] Error 1
```
 - Do thiếu thư viện `expat.h`.
 - **Cách fix:**
 > - Cài thêm bộ thư viện expat bằng lệnh `yum install -y expat-devel`
