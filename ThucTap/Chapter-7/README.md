# Các khái niệm domain, hosting, dns

* **[1. Domain](#chapter-1)**
* **[2. Hosting](#chapter-2)**

<a name="chapter-1"></a>
### 1. Domain

#### a. Domain Name

- Domain name là một chuỗi các kí tự được dùng để định danh địa chỉ IP của Server.
- Tính chất của domain name:
  - Duy nhất, được cấp phát cho Server đăng kí trước.
  - 1 domain name gồm có top-level domain (TLD) và second-level/lower-level domain.
- Một số TLD phổ biến:
  - `com` (commercial): tên miền thương mại.
  - `net` (network): thưòng sử dụng cho các nhà cung cấp dịch vụ Internet.
  - `org` (organization): thường được sử dụng bởi các tổ chức phi lợi nhuận.
  - `info` (information).
  - `gov` (goverment): chính phủ.
  - `edu` (education): sử dụng cho gíao dục.
  - Ngoài ra còn 1 số TLD theo quốc gia gọi chung là country code top-level domain (ccTLD) như là `.vn`, `.cn`, `.jp`, `.uk`, ..

#### b. DNS

- DNS là viết tắt của Domain Name System, hệ thống phân gỉai tên miền.
- Cấu trúc của hệ thống tên miền:
  - Tên miền cấp cao nhất là tên miền root thể hiện bằng dấu `.`.
  - Dưới root là các tên miền gTLDs và ccTLDs.
- Máy chủ tên miền Name Server là máy chủ chứa cơ sở dữ liệu cho việc chuyển đổi giữa tên miền và IP.
- Máy chủ tên miền gồm 2 loại:
  - Primary name server: lấy dữ liệu từ cho các zone của nó từ các file có sẵn trên máy.
  - Secondary name server: lấy dữ liệu cho các zone từ các primary name server khác.
- Các bản ghi:
  - **Bản ghi A**: chỉ ra địa chỉ IP và tên miền. Cú pháp: `<domain-name> IN A <IP>`.
    ```
    traioi.com. IN A 192.168.1.1
    ```
  - **Bản ghi AAAA**: chỉ ra địa chỉ IPv6 và tên miền. Cú pháp: `<domain-name> IN AAAA <IPv6>`.
  - **Bản ghi CNAME**: cho phép nhiều tên miền trỏ tới địa chỉ IP. Cú pháp: `<alias-domain> IN CNAME <canonical-domain>`.
    ```
    traicam.com IN CNAME traioi.com
    ```
  - **Bản ghi MX**: khai báo trạm chuyển tiếp thư điện tử của một tên miền. Cú pháp: `<domain-name> IN MX <priority> <mail>`
    - `<domain-name>`: tên miền được khai báo để sử dụng như thư điện tử.
    - `<priority>`: (1-255), gía trị ưu tiên khi gửi thư qua nhiều trạm.
    - `<mail>`: tên của trạm chuyển tiếp thư điện tử.
    ```
    traioi.com IN MX 1 mail1.traioi.com
    traioi.com IN MX 2 mail2.traioi.com
    ```
    - Thư có cấu trúc `user@traioi.com` gửi đến `mail1.traioi.com`. Nếu `mail1.traioi.com` không thể nhận thì sẽ gửi đến `mail2.traioi.com`.
  - **Bản ghi NS**: khai báo máy chủ tên miền cho một tên miền. Cú pháp: `<domain-name> IN NS <name-server>`.
    ```
    traioi.com. IN NS dns.traioi.com.
    ```
    - Tên miền `traioi.com` sẽ do `dns.traioi.com` quản lý. Các record sẽ được lưu trên `dns.traioi.com`.
  - **Bản ghi PTR**: chuyển đổi địa chỉ IP sang tên miền. Cú pháp: `<reverse-IP>.in-addr.arpa IN PTR <domain-name>`.
    ```
    1.1.168.192.in-addr.arpa IN NS traioi.com
    ```
  - **Bản ghi NAPTR**: chứa đựng thông tin về các nguồn, những dịch vụ và ứng dụng nào sẽ được kết hợp với một số điện thoại xác định. Cú pháp: `<domain-name> IN NAPTR <serial> <priority> <flag> <service> <pattern> <replace>`.
    ```
    9.8.7.6.5.4.3.2.1.4.8.e164.arpa. IN NAPTR 10 10 "u" "mailto+E2U" "!^.*$!mailto:user@traioi.com!"
    ```
    - Khi thực hiện cuộc gọi `+84-123456789` thì thu được `mailto:user@traioi.com`.

<a name="chapter-2"></a>
### 2. Hosting

- Hosting là dịch vụ lưu trữ dữ và chia sẻ liệu trực tuyến, là không gian trên máy chủ có cài đặt các dịch vụ Internet.
- Các loại hosting:
  - Shared Hosting: Chia sẻ hosting.
  - Collocated hosting: Thuê chỗ đặt máy chủ
  - Dedicated Server: Máy chủ dùng riêng
  - Virtual Private Server: VPS là máy chủ riêng ảo
- OS của server gồm 2 loại:
  - Linux: hỗ trợ PHP, Joomla, .. các CMS, Framework mã nguồn mở.
  - Windows: hỗ trợ ASP, .NET, ..
- Dung lượng: bộ nhớ lưu trữ cho phép upload lên host.
- Băng thông (bandwidth): dung lượng thông tin tối đa mà website lưu chuyển.
- Max file: Số lượng file tối đa khi upload lên host.
- RAM: Bộ nhớ đệm.
- Subdomain: Số lượng tên miền phụ có thể tạo ra cho mỗi tên miền
- FTP accounts: Số lượng FTP account có thể tạo và dùng nó upload dữ liệu lên hosting