# XI. Tìm hiểu mô hình Reverse Proxy nâng cao

* **[1. Cài thêm memcached](#chapter-1)**
* **[2. Cài SSL cho 2 domain abc.com và test.com](#chapter-2)**
* **[3. Cấu hình ghi log cho NGINX và Apache](#chapter-3)**
* **[4. Cài đặt phpMyAdmin](#chapter-4)**
* **[5. Cài đặt vsftpd](#chapter-5)**

<a name="chapter-1"></a>
## 1. Cài thêm memcached

<a name="chapter-4"</a>
## 4. Cài đặt phpMyAdmin

### a. Giới thiệu

### b. Tải phpMyAdmin

- Tải source phpmyadmin.
```
$ cd /usr/share
$ wget https://files.phpmyadmin.net/phpMyAdmin/4.7.2/phpMyAdmin-4.7.2-all-languages.zip
```

- Giải nén
```
$ unzip phpMyAdmin-4.7.2-all-languages.zip
$ mv phpMyAdmin-4.7.2-all-languages phpmyadmin
$ chmod -R 755 phpmyadmin
```

### c. Cấu hình httpd cho phpmyadmin

```
$ vi /etc/httpd/conf.d/phpmyadmin.conf
<Directory "/usr/share/phpmyadmin">
  Require all granted
</Directory>

Alias /phpmyadmin /usr/share/phpmyadmin
Alias /phpMyAdmin /usr/share/phpmyadmin
```

### d. Config phpmyadmin

```
$ cp /usr/share/phpmyadmin/config.sample.inc.php /usr/share/phpmyadmin/config.inc.php
```
