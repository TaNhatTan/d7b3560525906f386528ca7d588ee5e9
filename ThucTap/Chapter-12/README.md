# XII. Mô hình reverse proxy - bảo mật cơ bản

* **[1. Cài đặt thêm module testcookie cho nginx](#chapter-1)**
* **[2. Cài đặt thêm module pagespeed cho nginx](#chapter-2)**
* **[3. Bật chức năng chứng thực bằng user và password](#chapter-3)**
* **[4. Cấu hình chỉ cho phép truy cập vào trang admin từ các IP cố định](#chapter-4)**
* **[5. Cấu hình chỉ cho phép truy cập dịch vụ nginx và ssh từ bên ngoài](#chapter-5)**

<a name="chapter-1"></a>
## 1. Cài thêm testcookie

### a. Giới thiệu

- *testcookie* là module của nginx sử dụng cookie dựa trên challenge/response.

- Sử dụng để chống tấn công Ddos L7.

#### Workflow

(Updating..)

### b. Compiling from source

- Tải source về từ Github.
```
$ cd nginx/nginx-1.10.2/
$ mkdir testcookie-nginx-module
$ git clone https://github.com/kyprizel/testcookie-nginx-module.git testcookie-nginx-module
```

- Compiling from source.
```
$ ./configure --with-compat --add-dynamic-module=./testcookie-nginx-module
$ make
$ make install
```

### c. Cấu hình

- Load module.
```
$ vi /etc/nginx/nginx.conf
load_module /usr/lib64/nginx/modules/ngx_pagespeed.so;
```

#### Các biến cấu hình

(Updating..)

#### Cấu hình

- Cấu hình chung.
```
$ vi /etc/nginx/conf.d/testcookie.conf
testcookie off;
testcookie_name traioi;
testcookie_secret traioitraioitraioitraioitraioitraioitraioitraioitraioi;
testcookie_session $remote_addr;
#testcookie_arg traioi;
testcookie_max_attempts 3;
testcookie_p3p 'CP="CUR ADM OUR NOR STA NID", policyref="/w3c/p3p.xml"';
testcookie_fallback https://$host$request_uri;
testcookie_redirect_via_refresh on;
testcookie_refresh_encrypt_cookie on;
testcookie_refresh_encrypt_cookie_key deadbeefdeadbeefdeadbeefdeadbeef;
testcookie_refresh_encrypt_cookie_iv deadbeefdeadbeefdeadbeefdeadbeef;
```

- Enable testcookie cho trang abc.com
```
$ vi /etc/nginx/conf.d/abc.com.conf
...
location / {
  ...
  testcookie on;
  ...
}
...
```

- Enable testcookie cho trang test.com
```
$ vi /etc/nginx/conf.d/test.com.conf
...
location / {
  ...
  testcookie on;
  ...
}
...
```

<a name="chapter-2"></a>
## 2. Cài thêm pagespeed

### a. Giới thiệu

- **ngx_pagespeed** tăng tốc độ cho website và giảm thời gian tải trang bằng cách tự động áp dụng những pracices tốt nhất về hiệu suất cho trang và content để không phải chỉnh sửa những content đã tồn tại và workflow.

#### Workflow

(Updating..)

### b. Compiling from source

- Tải source về từ Github.
```
$ cd nginx/nginx-1.10.2/
$ mkdir pagespeed-nginx-module
$ cd pagespeed-nginx-module/
$ NPS_VERSION=1.12.34.2-stable
$ wget https://github.com/pagespeed/ngx_pagespeed/archive/v${NPS_VERSION}.zip
$ unzip v${NPS_VERSION}.zip
$ cd ngx_pagespeed-${NPS_VERSION}/
$ NPS_RELEASE_NUMBER=${NPS_VERSION/stable/}
$ psol_url=https://dl.google.com/dl/page-speed/psol/${NPS_RELEASE_NUMBER}.tar.gz
$ [ -e scripts/format_binary_url.sh ] && psol_url=$(scripts/format_binary_url.sh PSOL_BINARY_URL)
$ wget ${psol_url}
$ tar -xzvf $(basename ${psol_url})
```

- Compiling from source.
```
$ ./configure --with-compat --add-dynamic-module=./pagespeed-nginx-module/ngx_pagespeed-1.12.34.2-stable
$ make
$ make install
```

### c. Cấu hình

- Load module.
```
$ vi /etc/nginx/nginx.conf
load_module /usr/lib64/nginx/modules/ngx_pagespeed.so;
```

#### Các biến cấu hình

- **RespectVary:** Pagespeed sẽ bỏ qua các header `Vary` để giảm kích thước bộ nhớ cache, ngoại trừ `Vary: Accept-Encoding`.

- **DisableRewriteOnNoTransform:** Ở mặc định, pagespeed sẽ không ghi đè mã nguồn có `Cache-Control: no-transform` được set ở Response Header.

(Upating ..)

#### Cấu hình

- Cấu hình chung.
```
$ vi /etc/nginx/conf.d/pagespeed.conf
pagespeed off;
pagespeed RespectVary on;
pagespeed DisableRewriteOnNoTransform off;
pagespeed LowercaseHtmlNames on;
pagespeed ModifyCachingHeaders off;
pagespeed XHeaderValue "Powered By TraiOi";
pagespeed PreserveUrlRelativity on;
pagespeed ListOutstandingUrlsOnError on;
```

- Enable pagespeeds cho trang abc.com
```
$ vi /etc/nginx/conf.d/abc.com.conf
...
location / {
  ...
  pagespeed on;
  ...
}
...
```

- Enable pagespeeds cho trang test.com
```
$ vi /etc/nginx/conf.d/test.com.conf
...
location / {
  ...
  pagespeed on;
  ...
}
...
```

<a name="chapter-3"></a>
## 3. Bật chức năng chứng thực bằng user và password

### a. Đối với user abc (Wordpress)

- Tạo user và password bằng `htpassword` cho user `abc` với password là `abc`.
```
$ htpasswd -c /home/abc/.htpasswd abc
New password:
Re-type new password:
Adding password for user abc
$ cat /home/abc/.htpasswd
abc:$apr1$XXv35Pqs$onYx4w7ADDEzyH/lNYTDz.
```

-  Thêm chức năng chức thực cho trang `wp-admin`.
```
$ vi /home/abc/public_html/wp-admin/.htaccess
# Basic Authentication
AuthType basic
AuthName "Admin abc.com (Wordpress)"
AuthUserFile /home/abc/.htpasswd
Require valid-user
```

### b. Đối với user test (Magento)

- Tạo user và password bằng `htpassword` cho user `test` với password là `test`.
```
$ htpasswd -c /home/test/.htpasswd test
New password:
Re-type new password:
Adding password for user test
$ cat /home/test/.htpasswd
test:$apr1$csuUzZ4C$Y4Xmj6LzdUmm5CHDaVluK.
```

- Thêm chức năng chức thực cho trang `adminlogin`
```
$ vi /etc/httpd/conf.d/test.com.conf
...
<LocationMatch "^/adminlogin">
    AuthName "Hello"
    AuthUserFile /home/test/.htpasswd
    AuthType basic
    Require valid-user
</LocationMatch>
...
```

<a name="chapter-4"></a>
## 4. Cấu hình chỉ cho phép truy cập vào trang admin từ các IP cố định

- Xác định các IP được phép truy cập từ IP `192.168.0.100` đến `192.168.0.200`.
```
$ vi /etc/nginx/blockips.conf
deny 192.168.0.96/31;
deny 192.168.0.99/32;
allow 192.168.0.96/27;
allow 192.168.0.128/27;
allow 192.168.0.160/27;
allow 192.168.0.192/29;
deny all;
```

### a. Đối với user abc (Wordpress)

- Chỉ cho phép truy cập vào trang `wp-admin`.
```
$ vi /etc/nginx/conf.d/abc.com.conf
...
location ~* ^/(wp-admin|wp-login\.php)$ {
    include         /etc/nginx/blockips.conf;
    try_files      $uri @fallback;
    proxy_pass      http://192.168.0.153:8080;
}
...
```

### b. Đối với user test (Magento)

- Chỉ cho phép truy cập vào trang `adminlogin`.
```
$ vi /etc/nginx/conf.d/test.com.conf
...
location ~* ^/(adminlogin)$ {
   include        /etc/nginx/blockips.conf;
   try_files      $uri @fallback;
   proxy_pass      http://192.168.0.153:8080;
}
...
```

<a name="chapter-5"></a>
## 5. Cấu hình chỉ cho phép truy cập dịch vụ nginx và ssh từ bên ngoài

### a. Cấu hình chỉ cho phép truy cập dịch vụ nginx và ssh từ bên ngoài

```
$ Chain IN_public_allow (1 references)
target     prot opt source               destination         
ACCEPT     tcp  --  anywhere             anywhere             tcp dpt:http ctstate NEW
ACCEPT     tcp  --  anywhere             anywhere             tcp dpt:ssh ctstate NEW
ACCEPT     tcp  --  anywhere             anywhere             tcp dpt:https ctstate NEW
```

#### Workflow

(Updating...)

### b. Các dịch vụ khác chỉ truy cập được từ chính localhost

(Updating...)

#### Workflow

(Updating...)
