# V. Umask, suid, guid, sticky bit

* **[1. umask](#chapter-1)**
* **[2. SUID](#chapter-2)**
* **[3. SGID](#chapter-3)**
* **[4. sticky bit](#chapter-4)**

<a name="chapter-1"></a>
### 1. umask

- `umask` viết tắt user file-creation mode mask (user-mask).
- Khi file hoặc folder được tạo ra sẽ có quyền hạn nhất định sẽ được xác định trên 2 gía trị là `mask` và `base permission`.
  - `Base perm` của file là 666 (rw-rw-rw) và thư mục là 777 (rwxrwxrwx), `base perm` không thể thay đổi.
  - `Mask` là gía trị được thiết lập bởi người dùng bằng lệnh `umask`.
- Cách tính quyền dựa trên `mask` và `base perm`.
  - Ví dụ 1 file có `base perm` là 666 (110110110) và `mask` là 022 (000010010).
  - Lấy phần bù của `mask` là `111101101`.
  - Quyền truy cập của file là `110 110 110` AND `111 101 101` = `110 100 100` = 644 (rw-r--r--).
  - Hoặc lấy 666 - 022 = 644.
- Sử dụng lệnh `umask`: `umask <mask>`
```
$ umask 022
```

<a name="chapter-2"></a>
### 2. SUID

- `suid` viết tắt Set User ID.
-  Khi SUID bit được kích hoạt trên script file, bất cứ user nào có quyền thực thi scripts file này đều có khả năng chạy script ấy với tư cách của owner file đó. 
- Ví dụ:
```
$ ls -l /usr/bin/passwd 
-rwsr-xr-x. 1 root root 27832 Jun 10  2014 /usr/bin/passwd
```
- `rws` có kí tự `s` tức là SUID được kích hoạt tại quyền thực thi cho user.
- Để thiết lập SUID cho file thực thi: 
  - `chmod u+s <file>`: Chế độ symbolic.
  - `chmod 4xxx <file>`: Chế độ numberic.

<a name="chapter-3"></a>
### 3. SGID

- `sgid` viết tắt Set Group ID.
- Giống như SUID nhưng sử dụng cho group.
- Để thiết lập SGID cho file:
  - `chmod g+s <file>`: Chế độ symbolic.
  - `chmod 2xxx <file>`: Chế độ numberic.

<a name="chapter-4"></a>
### 4. sticky bit

- Khi sticky bit được kích hoạt, chỉ owner của file đó mới có quyền trên file cho dù người dùng khác có full (rwx) perm trên đó.
- Để thiết lập sticky bit:
  - `chmod +t <file>`: Chế độ symbolic.
  - `chmod 1xxx <file>`: Chế độ numberic.