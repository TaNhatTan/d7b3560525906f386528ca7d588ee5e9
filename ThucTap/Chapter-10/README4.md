# X. Cài đặt mô hình Reverse Proxy

* **[1. Cài đặt dịch vụ Nginx](README.md#chapter-1)**
* **[2. Cài đặt dịch vụ Httpd](README2.md#chapter-2)**
* **[3. Cài đặt PHP](README3.md#chapter-3)**
* **[4. Cài đặt dịch vụ MySQL](README4.md#chapter-4)**
* **[5. Cấu hình Reverse Proxy](README5.md#chapter-5)**
* **[6. Cấu hình vhost](README6.md#chapter-6)**

<a name="chapter-4"></a>
## Cài đặt dịch vụ MySQL

### a. Giới thiệu

- MySQL là hệ quản trị cơ sở dữ liệu tự do nguồn mở phổ biến nhất thế giới và được các nhà phát triển rất ưa chuộng trong quá trình phát triển ứng dụng. Vì MySQL là cơ sở dữ liệu tốc độ cao, ổn định và dễ sử dụng, có tính khả chuyển, hoạt động trên nhiều hệ điều hành cung cấp một hệ thống lớn các hàm tiện ích rất mạnh. Với tốc độ và tính bảo mật cao, MySQL rất thích hợp cho các ứng dụng có truy cập CSDL trên internet. (Nguồn: Wikipedia).

### b. Compiling from source

#### Yêu cầu

- Tạo user và group cho mysql.
```
$ groupadd mysql
$ useradd -r -g mysql -s /bin/false mysql
```

- Tạo thư mục để tải source MySQL.
```
$ mkdir mysql
$ cd mysql
```

- Tải source MySQL từ trang chủ.
```
$ wget https://dev.mysql.com/get/Downloads/MySQL-5.7/mysql-boost-5.7.18.tar.gz
$ tar xvzf mysql-boost-5.7.18.tar.gz
```

#### Compile PHP from source

```
$ cd mysql-5.7.18
$ mkdir bld
$ cd bld
$ cmake \
-DDOWNLOAD_BOOST=1 \
-DWITH_BOOST=../boost/ \
-DCURSES_LIBRARY=/usr/lib/libncurses.so \
-DCURSES_INCLUDE_PATH=/usr/include \
..
```
```
$ make
$ make install
```

#### Cấu hình sau compile

- Phân quyền cho MySQL.
```
$ cd /usr/local/mysql
$ chown -R mysql .
$ chgrp -R mysql .
$ bin/mysqld --initialize --user=mysql
$ chown -R root .
$ chown -R mysql data
```

- Tạo password cho tài khoản root
```
$ mysqld_safe --skip-grant &
$ mysql -u root
mysql> use mysql;
mysql> update user set authentication_string=password('root') where user='root';
mysql> exit;
$ killall -9 mysqld_safe
$ killall -9 mysqld
```

- Tạo script cho init.
```
$ cp /usr/local/mysql/support-files/mysql.server /etc/init.d/mysql
```

- Start MYSQL-Server on boot.
```
$ chkconfig mysql on
```

#### Lỗi phát sinh

- cmake/readline.cmake:107 (FIND_CURSES).
```
$ cmake -DDOWNLOAD_BOOST=1 -DWITH_BOOST=../boost/ ..
...
-- Could NOT find Curses (missing:  CURSES_LIBRARY CURSES_INCLUDE_PATH)
CMake Error at cmake/readline.cmake:64 (MESSAGE):
  Curses library not found.  Please install appropriate package,

      remove CMakeCache.txt and rerun cmake.On Debian/Ubuntu, package name is libncurses5-dev, on Redhat and derivates it is ncurses-devel.
Call Stack (most recent call first):
  cmake/readline.cmake:107 (FIND_CURSES)
  cmake/readline.cmake:197 (MYSQL_USE_BUNDLED_EDITLINE)
  CMakeLists.txt:488 (MYSQL_CHECK_EDITLINE)
...
```
  - Do thiếu package `ncurses-devel`.
  - **Cách fix:**
    > - Cài thêm bằng lệnh `yum install ncurses-devel`.
