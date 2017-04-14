# IV. Linux Filesystem

* **[1. /etc/profile](#chapter-1)**
* **[2. /etc/bashrc](#chapter-2)**
* **[3. /boot/](#chapter-3)**
* **[4. /tmp](#chapter-4)**
* **[5. /var/log/](#chapter-5)**
* **[6. /etc/filesystems](#chapter-6)**
* **[7. Thông tin về account](#chapter-7)**

<a name="chapter-1"></a>
### 1. /etc/profile

- Là chương trình tự động khởi động khi login vào account.
- Dùng để thiết lập các cấu hình môi trường cho shell như `PATH`, `alias`, ...
- Có chức năng giống với `/etc/bashrc`.
- Để thiết lập các scripts tự khởi động cho từng user nhất định khi login thì add script đó vào `/home/$USER/.profile`.

<a name="chapter-2"></a>
### 2. /etc/bashrc

- Là chương trình tự động khởi động khi mở terminal.
- Dùng để thiết lập các cấu hình môi trường cho shell như `PATH`, `alias`, ...
- Có chức năng giống với `/etc/profile`.
- Để thiết lập các scripts tự khởi động cho từng user nhất định khi login thì add script đó vào `/home/$USER/.bashrc`.

<a name="chapter-3"></a>
### 3. /boot/

- Là thư mục chứa các file, nhân, vmlinuz tự khởi động khi load vào Linux.
  - `vmlinuz`: Nhân Linux.
  - `initrd.img`: Filesystem tạm thời, được sử dụng trước khi tải kernel.
  - `System.map`: Bảng biểu tượng tìm kiếm.
  - `/grub`, `/grub2`: Chứa các cấu hình và file của chương trình quản lí nhân OS.

<a name="chapter-4"></a>
### 4. /tmp

- Chứa các file, folder tạm được sử dụng bởi hệ thống.
- Tự động xóa khi khởi động lại hệ thống.

<a name="chapter-5"></a>
### 5. /var/log

- Chứa các file, folder chứa log của các chương trình đang hoạt động trên hệ thống.
  - `/var/log/messages`: Log của hệ thống, gồm cả log khi hệ thống khởi động, mail, cron, daemon, ..
  - `/var/log/dmesg`: Thông tin về bộ đệm, hiện thị thông tin về các thiết bị phần cứng mà kernel phát hiện khi khởi động.
  - `/var/log/auth.log`: Thông tin về user login và xác thực, ...
  - `/var/log/boot.log`: Thông tin được log khi hệ thống khởi động.
  - `/var/log/lastlog`: Thông tin login gần nhất của user, `lastlog` không hiển thị ở dạng ASCII nên phải dùng lệnh `lastlog`.
  - `/var/log/yum.log`: Thông tin về package được cài đặt khi dùng `yum`.
  - `/var/log/wtmp`: Thông tin về user đang login vào hệ thống, dùng lệnh `who` để xem.

<a name="chapter-6"></a>
### 6. /etc/filesystems

- Liệt kê các filesystems đó thể sử dụng trên hệ thống

<a name="chapter-7"></a>
### 7. Thông tin về account

- Gồm các file chứa thông tin về account
  - `/etc/group`: Thông tin về group, groupid của user.
  - `/etc/passwd`: Thông tin về password của user.
  - `/etc/shadow`: Chưa password của user, mặc định chỉ có thể xem bởi user `root`.