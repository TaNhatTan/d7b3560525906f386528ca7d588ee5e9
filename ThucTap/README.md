# Báo cáo thực tập

> Mô tả: Báo cáo trong quá trình thực tập.
>
> Người viết: Trái Ôỉ
>
> Lần cuối chỉnh sửa: 13/04/2017

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
* **[X. Cài đặt các dich vụ](#chapter-10)**
* **[XI. VestaCP](#chapter-11)**
* **[XII. Iptables, firewalld, CSF](#chapter-12)**
* **[XIII. Final](#chapter-13)**

<a name="chapter-1"></a>
### I. Cài OS/Tool cho công việc

<a name="chapter-2"></a>
### II. Cài Centos/RAID/LVM

1. [ ] Cài 1 máy ảo linux.
2. [ ] Chia partition:

	| Partition | Filesystem | Size |
	| --- | --- | --- |
	| /boot/ | ext2 | 500MB |
	| / | ext4 | Còn lại |
3. Add thêm 2 ổ cứng
	- [ ] Cấu hình raid 1 cho 2 ổ cứng bằng command line.
	- [ ] Mount partition lên /data.
	- [ ] Đảm bảo auto mount partition sau khi reboot.
4. Add thêm 3 ổ cứng 
	- [ ] Cấu hình LVM trên 3 ổ cứng vừa add.
	- [ ] Tạo thêm 2 logical volume và mount thành /data2 và /data3
	- [ ] Đảm bảo auto mount partitiontion sau khi reboot.

>**Lưu ý**: 
> + Dung lượng ổ cứng có thể chọn tùy thích
> + Lưu lại các command sau khi thao tác và nộp lại.
> + Bật ssh cho các máy ảo này ssh vào kiểm tra cấu hình sau khi hoàn tất.

<a name="chapter-3"></a>
### III. Cách kiểm tra các phần cứng server

<a name="chapter-4"></a>
### IV. Linux Filesystem

- [ ] /etc/profile
- [ ] /etc/bashrc
- [ ] /boot/
- [ ] /tmp/

<a name="chapter-5"></a>
### V. Umask, suid, guid, sticky bit

<a name="chapter-6"></a>
### VI. Files, directories permission

<a name="chapter-7"></a>
### VII. Các khái niệm domain, hosting, dns
Các loại records: PTR, A, Alias, MX,...

<a name="chapter-8"></a>
### VIII. Tìm hiểu SystemD, Init
So sánh 2 loại

<a name="chapter-9"></a>
### IX. Bash shell

- [ ] Get public ip
- [ ] random pass
- [ ] alias
- [ ] awk
- [ ] sed
- [ ] cut
- [ ] cat
- [ ] Viết script backup dữ liệu trong /home/$USER ra ổ cứng di động: backup incremental rotate 7 ngày, có backup, đặt cron, đặt cron, có exclude thư mục.

<a name="chapter-10"></a>
### X. Cài đặt các dich vụ
- [ ] Build reverse proxy from source
- [ ] Nginx, Apache, PHP, MYSQL: compile from source
- [ ] PHP Handler
- [ ] Deploy Wordpress on reverse proxy

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