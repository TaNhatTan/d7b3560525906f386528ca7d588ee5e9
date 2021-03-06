# Báo cáo thực tập

> Mô tả: Báo cáo trong quá trình thực tập.
>
> Người viết: Trái Ôỉ
>
> Lần cuối chỉnh sửa: 14/04/2017

## Nội dung


* **[I. Cài OS/Tool cho công việc](#chapter-1)**
* **[II. Cài Centos/RAID/LVM](#chapter-2)**
* **[III. Cách kiểm tra các phần cứng server](#chapter-3)**
* **[IV. Linux Filesystem](#chapter-4)**
* **[V. Umask, suid, guid, sticky bit](#chapter-5)**
* **[VI. Files, directories permission](#chapter-6)**
* **[VII. Các khái niệm domain, hosting, dns](#chapter-7)**  
* **[VIII. Tìm hiểu SystemD, Init](#chapter-8)**
* **[IX. Bash shell](#chapter-9)**
* **[X. Cài đặt mô hình Reverse Proxy](#chapter-10)**
* **[XI. Tìm hiểu mô hình Reverse Proxy nâng cao](#chapter-11)**
* **[XII. Mô hình reverse proxy - bảo mật cơ bản](#chapter-12)**
* **[XIII. Final](#chapter-13)**

<a name="chapter-1"></a>
### I. Cài OS/Tool cho công việc

- [x] Cài OS.
- [x] Cài keepass.
- [x] Cài máy ảo: Virtualbox.

<a name="chapter-2"></a>
### II. Cài Centos/RAID/LVM

1. [x] [Cài 1 máy ảo linux](./Chapter-2#buoc-1).
2. [x] [Chia partition](./Chapter-2#buoc-2):

	| Partition | Filesystem | Size |
	| --- | --- | --- |
	| /boot/ | ext2 | 500MB |
	| / | ext4 | Còn lại |
3. [Cấu hình RAID 1](./Chapter-2#buoc-3).
	- [x] Add thêm 2 ổ cứng
	- [x] Cấu hình RAID 1 cho 2 ổ cứng bằng command line.
	- [x] Mount partition lên `/data`.
	- [x] Đảm bảo auto mount partition sau khi reboot.
4. [Cấu hình LVM](./Chapter-2#buoc-4).
	- [x] Add thêm 3 ổ cứng
	- [x] Cấu hình LVM trên 3 ổ cứng vừa add.
	- [x] Tạo thêm 2 logical volume và mount thành `/data2` và `/data3`
	- [x] Đảm bảo auto mount partition sau khi reboot.

>**Lưu ý**:
> + Dung lượng ổ cứng có thể chọn tùy thích
> + Lưu lại các command sau khi thao tác và nộp lại.
> + Bật ssh cho các máy ảo này ssh vào kiểm tra cấu hình sau khi hoàn tất.

<a name="chapter-3"></a>
### III. Cách kiểm tra các phần cứng server

- [x] [Kiểm tra một số thông tin của OS](Chapter-3#chapter-1)
- [x] [Kiểm tra CPU](Chapter-3#chapter-2)
- [x] [Kiểm tra các thiết bị PCI](Chapter-3#chapter-3)
- [x] [Kiểm tra bộ nhớ lưu trữ](Chapter-3#chapter-4)
- [x] [Kiểm tra thông tin trên đĩa](Chapter-3#chapter-5)
- [x] [Kiểm tra thông tin card mạng](Chapter-3#chapter-6)
- [x] [Kiểm tra thông tin BIOS](Chapter-3#chapter-7)
- [x] [Kiểm tra thông tin Mainboard](Chapter-3#chapter-8)

<a name="chapter-4"></a>
### IV. Linux Filesystem

- [x] [/etc/profile](Chapter-4#chapter-1)
- [x] [/etc/bashrc](Chapter-4#chapter-2)
- [x] [/boot/](Chapter-4#chapter-3)
- [x] [/tmp](Chapter-4#chapter-4)
- [x] [/var/log/](Chapter-4#chapter-5)
- [x] [/etc/filesystems](Chapter-4#chapter-6)
- [x] [Thông tin về account](Chapter-4#chapter-7)

<a name="chapter-5"></a>
### V. Umask, SUID, SGID, sticky bit

- [x] [umask](Chapter-5#chapter-1)
- [x] [SUID](Chapter-5#chapter-2)
- [x] [SGID](Chapter-5#chapter-3)
- [x] [sticky bit](Chapter-5#chapter-4)

<a name="chapter-6"></a>
### VI. Files, directories permission

- [x] [Phân quyền trong Linux](Chapter-6#chapter-1)
- [x] [Biểu diễn phân quyền](Chapter-6#chapter-2)
- [x] [Thay đổi quyền](Chapter-6#chapter-3)

<a name="chapter-7"></a>
### VII. Các khái niệm domain, hosting, dns

- [x] [Domain](Chapter-7#chapter-1)
- [x] [Hosting](Chapter-7#chapter-2)

<a name="chapter-8"></a>
### VIII. Tìm hiểu SystemD, Init

- [x] [init System](Chapter-8#chapter-1)
- [x] [SystemD](Chapter-8#chapter-2)
- [x] [So sánh Init và SystemD](Chapter-8#chapter-3)

<a name="chapter-9"></a>
### IX. Bash shell

- [x] Get public ip
- [x] random pass
- [x] alias
- [x] awk
- [x] sed
- [x] cut
- [x] cat
- [ ] Viết script backup dữ liệu trong /home/$USER ra ổ cứng di động: backup incremental rotate 7 ngày, có backup, đặt cron, đặt cron, có exclude thư mục.

<a name="chapter-10"></a>
### X. Cài đặt mô hình Reverse Proxy
- [x] [Cài đặt dịch vụ Nginx](Chapter-10/README.md#chapter-1)
- [x] [Cài đặt dịch vụ Httpd](Chapter-10/README2.md#chapter-2)
- [x] [Cài đặt PHP](Chapter-10/README3.md#chapter-3)
- [x] [Cài đặt dịch vụ MySQL](Chapter-10/README4.md#chapter-4)
- [x] [Cấu hình Reverse Proxy](Chapter-10/README5.md#chapter-5)
- [x] [Cấu hình vhost cho domain abc.com và test.com.](Chapter-10/README6.md#chapter-6)

<a name="chapter-11"></a>
### XI. Tìm hiểu mô hình Reverse Proxy nâng cao
- [ ] Cài thêm memcached:
  - Kết nối 2 website abc.com và test.com với memcached.
- [ ] Cài SSL cho 2 domain abc.com và test.com
  - Sử dụng Self-Signed SSL Certificate.
- [ ] Cấu hình NGINX và Apache ghi log ở level error, access, rotate daily.
- [ ] Cài đặt phpMyAdmin.
- [ ] Cài đặt vsftpd, tạo tài khoản ftp cho 2 site abc.com và test.com

<a name="chapter-12"></a>
### XII. Mô hình reverse proxy - bảo mật cơ bản
- Cài đặt thêm 2 module cho nginx:
  - [ ] testcookie.
  - [ ] pagespeed.
- [ ]  Bật chức năng chứng thực bằng user và password khi đăng nhập vào trang admin của 2 website abc.com và test.com
- [ ] Cấu hình chỉ cho phép truy cập vào trang admin từ các IP cố định.
  - Chỉ chấp nhận truy cập từ IP 192.168.0.100 đến 192.168.0.200.
- [ ] Cấu hình chỉ cho phép truy cập dịch vụ nginx và ssh từ bên ngoài, các dịch vụ khác chỉ truy cập được từ chính localhost.

<a name="chapter-11"></a>
### XI. VestaCP
- [ ] Tìm hiểu Vesta CP
- [ ] Vesta File system
- [ ] Đọc hiểu, customize một số script của Vesta

<a name="chapter-12"></a>
### XII. Iptables, firewalld, CSF

- [ ] Iptables workflow
- [ ] Firewalld architecture
- [ ] CSF fundamental
- [ ] Viết script đơn giản để nat, filter,...
- [ ] Mô hình demo:
	- INTERNET => FIREWALL => WEB
	- Viết rule iptables để NAT port 80 của web ra ngoài
	- Viết rule iptables để giới hạn SSH trên firewall, chỉ allow 2 IP: 1.1.1.1 và 2.2.2.2, còn lại deny all

<a name="chapter-13"></a>
### XIII. Final

- [ ] Build hệ thống hoàn chỉnh: haproxy, reverse proxy, firewall limit ports
