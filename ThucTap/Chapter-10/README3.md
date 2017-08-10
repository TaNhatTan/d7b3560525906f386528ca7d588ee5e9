# X. Cài đặt mô hình Reverse Proxy

* **[1. Cài đặt dịch vụ Nginx](README.md#chapter-1)**
* **[2. Cài đặt dịch vụ Httpd](README2.md#chapter-2)**
* **[3. Cài đặt PHP](README3.md#chapter-3)**
* **[4. Cài đặt dịch vụ MySQL](README4.md#chapter-4)**
* **[5. Cấu hình Reverse Proxy](README5.md#chapter-5)**
* **[6. Cấu hình vhost](README6.md#chapter-6)**

<a name="chapter-3"></a>
## 3. Cài đặt PHP

### a. Giới thiệu

- **PHP** (viết tắt hồi quy "PHP: Hypertext Preprocessor") là một ngôn ngữ lập trình kịch bản hay một loại mã lệnh chủ yếu được dùng để phát triển các ứng dụng viết cho máy chủ, mã nguồn mở, dùng cho mục đích tổng quát. Nó rất thích hợp với web và có thể dễ dàng nhúng vào trang HTML. Do được tối ưu hóa cho các ứng dụng web, tốc độ nhanh, nhỏ gọn, cú pháp giống C và Java, dễ học và thời gian xây dựng sản phẩm tương đối ngắn hơn so với các ngôn ngữ khác nên PHP đã nhanh chóng trở thành một ngôn ngữ lập trình web phổ biến nhất thế giới.

### b. Compiling from source

#### Yêu cầu

- Tạo thư mục để tải source PHP.
```
$ mkdir php
$ cd php
```

- Tải source PHP về từ github.
```
$ git clone https://github.com/php/php-src.git ./
```

#### Compile PHP from source

```
./buildconf --force
./configure --prefix=/usr/local/php7 \
    --with-config-file-path=/usr/local/php7/etc \
    --with-config-file-scan-dir=/usr/local/php7/etc/conf.d \
    --enable-bcmath \
    --with-bz2 \
    --with-curl \
    --enable-filter \
    --enable-fpm \
    --with-gd \
    --enable-gd-native-ttf \
    --with-freetype-dir \
    --with-jpeg-dir \
    --with-png-dir \
    --enable-intl \
    --enable-mbstring \
    --with-mcrypt \
    --enable-mysqlnd \
    --with-mysql-sock=/var/lib/mysql/mysql.sock \
    --with-mysqli=mysqlnd \
    --with-pdo-mysql=mysqlnd \
    --with-pdo-sqlite \
    --disable-phpdbg \
    --disable-phpdbg-webhelper \
    --enable-opcache \
    --with-openssl \
    --enable-simplexml \
    --with-sqlite3 \
    --enable-xmlreader \
    --enable-xmlwriter \
    --enable-zip \
    --with-zlib  \
    --with-apxs2
```
> **Note:**
>
> - ***--enable-bcmath***: Sử dụng Binary Calculator để tính các số có kích thước lớn.
> - ***--enable-filter***: Sử dụng các kỹ thuật lọc dữ liệu như validation hoặc sanitization.
> - ***--with-gd***: Sử dụng các thư viện GD.
> - ***---enable-intl***: Sử dụng iternationalization extension là wrapper cho các thư viện ICU.
> - ***--enable-mbstring***: Sử dụng các ký tự có encoding đặc biệt như UTF-8, UCS-2, ..
> - ***--with-mcrypt***: Sử dụng thư viện mcrypt hỗ trợ các phương thức mã hoá.
> - ***--enable-opcache***: Sử dụng opcache để cải thiện hiệu năng của PHP.

```
$ make
$ make install
```

- Các thư mục cấu hình sau khi compile.
```
Installing shared extensions:     /usr/local/php7/lib/php/extensions/no-debug-non-zts-20151012/
Installing PHP CLI binary:        /usr/local/php7/bin/
Installing PHP CLI man page:      /usr/local/php7/php/man/man1/
Installing PHP FPM binary:        /usr/local/php7/sbin/
Installing PHP FPM config:        /usr/local/php7/etc/
Installing PHP FPM man page:      /usr/local/php7/php/man/man8/
Installing PHP FPM status page:      /usr/local/php7/php/php/fpm/
Installing PHP CGI binary:        /usr/local/php7/bin/
Installing PHP CGI man page:      /usr/local/php7/php/man/man1/
Installing build environment:     /usr/local/php7/lib/php/build/
Installing header files:          /usr/local/php7/include/php/
Installing helper programs:       /usr/local/php7/bin/
...
Installing man pages:             /usr/local/php7/php/man/man1/
...
Installing PEAR environment:      /usr/local/php7/lib/php/
...
Wrote PEAR system config file at: /usr/local/php7/etc/pear.conf
...
Installing PDO headers:          /usr/local/php7/include/php/ext/pdo/
```

#### Cấu hình trên httpd.
```
$ vi /etc/httpd/conf.d/php.conf
<Files ".user.ini">
    <IfModule mod_authz_core.c>
        Require all denied
    </IfModule>
</Files>

AddType text/html .php
DirectoryIndex index.php

<IfModule  mod_php7.c>
    <FilesMatch \.php$>
        SetHandler application/x-httpd-php
    </FilesMatch>

    php_value session.save_handler "files"
    php_value session.save_path    "/usr/local/php7/include/php/ext/session"
    #php_value soap.wsdl_cache_dir  "/var/lib/php/mod_php/wsdlcache"
    #php_value opcache.file_cache   "/var/lib/php/mod_php/opcache"
</IfModule>
```

#### Lỗi phát sinh

- configure: error: xml2-config not found. Please check your libxml2 installation.
```
$ ./configure ...
...
checking for atoll... yes
checking for strftime... (cached) yes
checking whether to enable LIBXML support... yes
checking libxml2 install dir... no
checking for xml2-config path...
configure: error: xml2-config not found. Please check your libxml2 installation.
```
 - Do thiếu package `libxml2-dev`.
 - **Cách fix:**
  > - Cài thêm bằng lệnh `yum install libxml2-devel`.

- configure: error: Please reinstall the BZip2 distribution
```
$ ./configure ...
...
checking if the location of ZLIB install directory is defined... no
checking for zlib version >= 1.2.0.4... 1.2.7
checking for gzgets in -lz... yes
checking whether to enable bc style precision math functions... yes
checking for BZip2 support... yes
checking for BZip2 in default path... not found
configure: error: Please reinstall the BZip2 distribution
```
 - Do thiếu package `bzip2-devel`.
 - **Cách fix:**
  > - Cài thêm bằng lệnh `yum install bzip2-devel`.

- configure: error: Please reinstall the libcurl distribution - easy.h should be in <curl-dir>/include/curl/
```
$ ./configure ...
...
checking for BZip2 in default path... found in /usr
checking for BZ2_bzerror in -lbz2... yes
checking whether to enable calendar conversion support... no
checking whether to enable ctype functions... yes
checking for cURL support... yes
checking for cURL in default path... not found
configure: error: Please reinstall the libcurl distribution -
    easy.h should be in <curl-dir>/include/curl/  
```
 - Do thiếu package `curl-devel`.
 - **Cách fix:**
  > - Cài thêm bằng lệnh `yum install curl-devel`.

- configure: error: jpeglib.h not found.
```
$ ./configure ...
...
checking for the location of libwebp... no
checking for the location of libjpeg... yes
checking for the location of libpng... yes
checking for the location of libXpm... no
checking for FreeType 2... yes
checking whether to enable truetype string function in GD... yes
checking whether to enable JIS-mapped Japanese font support in GD... no
If configure fails try --with-webp-dir=<DIR>
configure: error: jpeglib.h not found.
```
 - Do thiếu package `libjpeg-devel`.
 - **Cách fix:**
  > - Cài thêm bằng lệnh `yum install libjpeg-devel`.

- configure: error: png.h not found.
```
$ ./configure ...
...
checking for the location of libwebp... no
checking for the location of libjpeg... yes
checking for the location of libpng... yes
checking for the location of libXpm... no
checking for FreeType 2... yes
checking whether to enable truetype string function in GD... yes
checking whether to enable JIS-mapped Japanese font support in GD... no
If configure fails try --with-webp-dir=<DIR>
checking for jpeg_read_header in -ljpeg... yes
configure: error: png.h not found.
```
 - Do thiếu package `libpng-devel`
 - **Cách fix:**
  > - Cài thêm bằng lệnh `yum install libpng-devel`.

- configure: error: freetype-config not found.
```
$ ./configure ..
...
checking for the location of libpng... yes
checking for the location of libXpm... no
checking for FreeType 2... yes
checking whether to enable truetype string function in GD... yes
checking whether to enable JIS-mapped Japanese font support in GD... no
If configure fails try --with-webp-dir=<DIR>
checking for jpeg_read_header in -ljpeg... yes
checking for png_write_image in -lpng... yes
If configure fails try --with-xpm-dir=<DIR>
configure: error: freetype-config not found.
```
 - Do thiếu package `freetype-devel`
 - **Cách fix:**
  > - Cài thêm bằng lệnh `yum install freetype-devel`.

- configure: error: Unable to detect ICU prefix or no failed. Please verify ICU install prefix and make sure icu-config works.
```
$ ./configure ..
...
checking for IMAP support... no
checking for IMAP Kerberos support... no
checking for IMAP SSL support... no
checking for Firebird support... no
checking whether to enable internationalization support... yes
checking for icu-config... no
checking for location of ICU headers and libraries... not found
configure: error: Unable to detect ICU prefix or no failed. Please verify ICU install prefix and make sure icu-config works.
```
 - Do thiếu package thư viện ICU `libicu-devel`
 - **Cách fix:**
  > - Cài thêm bằng lệnh `yum install libicu-devel`.

- configure: error: mcrypt.h not found. Please reinstall libmcrypt
```
$ ./configure ..
...
checking for working alloca.h... (cached) yes
checking for alloca... (cached) yes
checking for working memcmp... yes
checking for stdarg.h... (cached) yes
checking for mcrypt support... yes
configure: error: mcrypt.h not found. Please reinstall libmcrypt.
```
 - Do thiếu package `libmcrypt-devel`
 - **Cách fix:**
  > - Cài thêm bằng lệnh `yum install libmcrypt-devel`.

- make: *** [ext/openssl/openssl.lo] Error 1
```
$ ./configure ...
...
/root/php/ext/openssl/openssl.c:5450:39: error: dereferencing pointer to incomplete type
  data = zend_string_alloc(DH_size(pkey->pkey.dh), 0);
                                       ^
/root/php/ext/openssl/openssl.c:5451:64: error: dereferencing pointer to incomplete type
  len = DH_compute_key((unsigned char*)ZSTR_VAL(data), pub, pkey->pkey.dh);
                                                                ^
make: *** [ext/openssl/openssl.lo] Error 1
```
 - Do thiếu package `openssl-devel`
 - **Cách fix:**
  > - Cài thêm bằng lệnh `yum install openssl-devel`.
