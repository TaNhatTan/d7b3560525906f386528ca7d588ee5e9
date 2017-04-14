# VI. Files, directories permission

* **[1. Phân quyền trong Linux](#chapter-1)**
* **[2. Biểu diễn phân quyền](#chapter-2)**
* **[3. Thay đổi quyền](#chapter-3)**

<a name="chapter-1"></a>
### 1. Phân quyền trong Linux

- Quản lí quyền hạn của mọi đối tượng trên Linux. Gíup tăng tính bảo mật.
- Mỗi đối tượng gồm 3 loại quyền:
  - **read**: đọc (r) (4)
  - **write**: ghi/sửa đổi (w) (2)
  - **execute**: thực thi (x) (1)
- Mỗi quyền gồm 3 loại user:
  - **owner**: chủ sở hửu của đối tượng.
  - **group**: nhóm các user có quyền hạn giống đối tượng.
  - **other**: các user còn lại không thuộc 2 loại trên.
- user `root` là duy nhất, có đầy đủ mọi quyền hạn, có quyền cấp và lấy lại quyền cho các user khác.

<a name="chapter-2"></a>
### 2. Biểu diễn phân quyền

#### a. Ký tự

- Gồm 10 kí tự:

| Type | | Owner | Group | Others |
| --- |--- | --- | --- | --- |
| Directory | d | rwx | rwx | rwx |
| Link/ Symlink | l | rwx | rwx | rwx |
| File | - | rwx | rwx | rwx |

- Vị trí các bit `deny` được biểu diễn bằng dấu `-`.
- Ví dụ:
```
$ ls -l /etc/passwd
-rw-r--r--. 1 root root 1006 Apr 13 22:25 /etc/passwd
```
  - Bit đầu tiên là `-`: file thông thường.
  - 3 bit `owner` là `rw-`: user `root` được phép đọc và thay đổi.
  - 3 bit `group` là `r--`: các users trong group `root` được phép đọc nhưng không được chỉnh sửa/xóa file.
  - 3 bit `other` là `r--`: các users không phải `root` và không nằm trong group `root` được phép đọc nhưng không được phép chỉnh sửa/xóa file.

#### b. Số

- Gồm 3 số:

| Owner | Group | Others |
| --- | --- | --- |
| <perm> | <perm> | <perm> |

- `<perm>` đại diện cho các số:
  - 0: cấm tất cả các quyền (---)
  - 1: thực thi (--x)
  - 2: ghi/sửa/xóa (-w-)
  - 3: thực thi + ghi (-wx)
  - 4: đọc (r--)
  - 5: đọc + thực thi (r-x)
  - 6: đọc + ghi (rw-)
  - 7: đọc + ghi + thực thi (rwx)

<a name="chapter-3"></a>
### 3. Thay đổi quyền

#### a. chmod

- Thay đổi quyền hạn lên đối tượng cho các user.
- Điều kiện: có quyền `root` hoặc là owner của file/folder.
```
$ chmod 755 test
$ ls -l test
-rwxr-xr-x. 1 root root 0 Apr 14 15:01 test
```

#### b. chown

- Thay đổi owner của đối tượng.
- Điều kiện: có quyền `root`.
```
$ chown admin test
$ ls -l test
-rwxr-xr-x. 1 admin root 0 Apr 14 15:01 test
```

#### c. chgrp

- Thay đổi group cho đối tượng.
- Điều kiện: có quyền `root` hoặc là owner của file, đồng thời cũng thuộc group owner của file.
```
$ chgrp admin test
$ ls -l test
-rwxr-xr-x. 1 root admin 0 Apr 14 15:01 test
```