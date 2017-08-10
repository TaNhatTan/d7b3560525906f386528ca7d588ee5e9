# X. Cài đặt mô hình Reverse Proxy

* **[1. Cài đặt dịch vụ Nginx](README.md#chapter-1)**
* **[2. Cài đặt dịch vụ Httpd](README2.md#chapter-2)**
* **[3. Cài đặt PHP](README3.md#chapter-3)**
* **[4. Cài đặt dịch vụ MySQL](README4.md#chapter-4)**
* **[5. Cấu hình Reverse Proxy](README5.md#chapter-5)**
* **[6. Cấu hình vhost](README6.md#chapter-6)**

<a name="chapter-0"></a>
## Giới thiệu

### a. Stable version và Mainline version

- **Stable version**: là phiên bản không bao gồm các tính năng mới, nhưng sẽ bao gồm các bản vá lỗ hổng nghiêm trọng giống như *mainline version*. *Stable version* thường được sử dụng cho servers.
- **Mainline version**: là phiên bản bao gồm các tính năng mới nhất, bản vá và luôn luôn up-to-date. *Mainline version* bao gồm luôn cả các modules thử nghiệm và có thể xuất hiện một số lỗ hổng mới.

### b. Pre-built package và Compiling from sources

- **Pre-built package**: là cách nhanh và dễ dàng để cài đặt phần mềm mã nguồn mở. Package này bao gồm hầu hết các modules chính thức của phần mềm và có sẵn trên đa số các hệ điều hành phổ biến.
- **Compiled from sources**: là cách cài đặt linh hoạt hơn, có thể thêm các modules bao gồm các modules của bên thứ ba hoặc các bản vábảo mật mới nhất.

### c. Chuẩn bị các phần mềm cài đặt

```
$ yum install -y wget
$ yum groupinstall -y "Development Tools"
```

<a name="chapter-1"></a>
## 1. Cài đặt dịch vụ Nginx

### a. Compiling from sources

- Trước khi cài đặt Nginx, cần phải cài đặt các phụ thuộc của nó.

#### Các thư viện liên quan

- Thư viện `PCRE`, required bởi Nginx core, Rewrite modules và cung cấp các hỗ trợ cho biểu thức chính quy.
```
$ wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.40.tar.gz
$ tar -zxf pcre-8.40.tar.gz
$ cd pcre-8.40
$ ./configure
$ make
$ sudo make install
```
- Thư viện `zlib`, required bởi Nginx Gzip module dùng để nén header.
```
$ wget http://zlib.net/zlib-1.2.11.tar.gz
$ tar -zxf zlib-1.2.11.tar.gz
$ cd zlib-1.2.11
$ ./configure
$ make
$ sudo make install
```
- Thư viện `OpenSSL`, required bởi Nginx SSL Module hỗ trợ giao thức HTTPS.
```
$ wget http://www.openssl.org/source/openssl-1.0.2f.tar.gz
$ tar -zxf openssl-1.0.2f.tar.gz
$ cd openssl-1.0.2f
$ ./Configure --prefix=/usr
$ make
$ sudo make install
```

#### Download  Source

- Nginx cung cấp những file mã nguồn cho cả stable và mainline versions.
- Dành cho `mainline version`.
```
$ wget http://nginx.org/download/nginx-1.11.13.tar.gz
$ tar zxf nginx-1.11.13.tar.gz
$ cd nginx-1.11.13
```
- Dành cho `stable version`.
```
$ wget http://nginx.org/download/nginx-1.12.0.tar.gz
$ tar zxf nginx-1.12.0.tar.gz
$ cd nginx-1.12.0
```

#### Cấu hình cài đặt
```
$ ./configure \
--user=nginx                          \
--group=nginx                         \
--prefix=/etc/nginx                   \
--sbin-path=/usr/sbin/nginx           \
--conf-path=/etc/nginx/nginx.conf     \
--pid-path=/var/run/nginx.pid         \
--error-log-path=/var/log/nginx/error.log \
--http-log-path=/var/log/nginx/access.log \
--with-pcre=../pcre-8.40               \
--with-zlib=../zlib-1.2.11
```
> **Note:**
>
> - ***--prefix***: Vị trí lưu các file cấu hình của Nginx (Mặc định: `/usr/bin/local/`).
> - ***--sbin-path***: Vị trí lưu file thực thi Nginx (Mặc định: *prefix*`/sbin/nginx/`).
> - ***--conf-path***: Vị trí lưu file cấu hình global của Nginx (Mặc định: *prefix*`/conf/nginx.conf`).
> - ***--pid-path***: Vị trí lưu file tiến trình PID của Nginx (Mặc định: *prefix*`/logs/nginx.pid`).
> - ***--error-log-path***: Vị trí lưu file log các lỗi khi thực thi Nginx (Mặc định: *prefix*`/logs/error.log`).
> - ***--http-log-path***: Vị trí lưu file log các request của HTTP server khi chạy Nginx (Mặc định: *prefix*`/logs/access.log`).
> - ***--with-pcre***: Vị trí mã nguồn của thư viện PCREi (ngx_http_rewrite_module).
> - ***--with-zlib***: Vị trí mã nguồn thư viện zlib (ngx_http_gzip_module).

#### Cài đặt
```
$ make
$ make install
```

#### Cấu hình

- Thêm `nginx` vào `systemd`.
```
$ vi /usr/lib/systemd/system/nginx.service
[Unit]
Description=The NGINX HTTP and reverse proxy server
After=network.target remote-fs.target nss-lookup.target

[Service]
Type=forking
PIDFile=/run/nginx.pid
ExecStartPre=/usr/sbin/nginx -t
ExecStart=/usr/sbin/nginx
ExecStop=/bin/kill -s QUIT $MAINPID
ExecReload=/bin/kill -s HUP $MAINPID
PrivateTmp=true
LimitNOFILE=infinity

[Install]
WantedBy=multi-user.target
```

#### Cấu hình sau compile

- Start Nginx on boot
```
$ systemctl enable nginx
```

#### Lỗi phát sinh

- *getpwnam("nginx") failed*
```
$ nginx -t
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: [emerg] getpwnam("nginx") failed
nginx: configuration file /etc/nginx/nginx.conf test failed
```
 - Do user thực thi Nginx chưa được xác định  hoặc user chưa tồn tại trong cấu hình nginx.
  - **Cách fix**:
  > - Thay đổi user cần thiết trong `nginx.conf`.
  > - Uncomment dòng `#user nobody;`

### b. Install a Pre-built package

- Pakage có thể được cài đặt từ:
 - ***Resposity mặc định của CentOS***: Đây là cách nhanh nhất, nhưng package có thể sẽ bị lạc hậu. Ví dụ, CentOS 7.0 mặc định cup cấp phiên bản NGINX/1.6.2 đã được phát hành vào tháng 9/2014.
 - ***Từ NGINX repo***: Cách này phải cài đặt *yum* repo 1 lần, nhưng package sẽ luôn ở phiên bản mới nhất.

#### Cài đặt NGINX package từ CentOS repo mặc định

- Cài đặt EPEL repo.
```
$ yum install epel-release
```

- Update repo và cài đặt NGINX Open Source.
```
$ yum update
$ yum install nginx
```

#### Cài đặt từ NGINX Repo

- Cài đặt *yum* repo cho CentOS bằng cách tạo file `nginx.repo` ở `/etc/yum.repos.d`.
```
$ vi /etc/yum.repos.d/nginx.repo
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/mainline/<OS>/<OSRELEASE>/$basearch/
gpgcheck=0
enabled=1
```
> **Note:**
>
> - ***OS***: Tên hệ điều hành: centos hoặc rhel.
> - ***OSRELEASE***: Phiên bản hệ điều hành: 6, 6.x, 7, 7.x.
> - ***/mainline***: Giữ cho package luôn ở phiên bản mới nhất.

Ví dụ cài đặt trên CentOS 7.0:
```
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/mainline/centos/7/$basearch/
gpgcheck=0
enabled=1
```

- Update repo và cài đặt NGINX Open Source.
```
$ yum update
$ yum install nginx
```
