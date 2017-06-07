# X. Cài đặt các dịch vụ
 
* **[1. Compile HAproxy from source](#chapter-1)**
* **[2. Compile Nginx from source](#chapter-2)**
* **[3. Compile Apache from source](#chapter-3)**
* **[4. Compile PHP from source](#chapter-4)**
* **[5. Compile MySQL from source](#chapter-5)**
* **[6. PHP Handler](#chapter-6)**
* **[7. Deploy Wordpress on reverse proxy](#chapter-7)**

<a name="chapter-1"></a>
## 1. Compile HAproxy from source
 
### Giới thiệu

- HAproxy, viết tắt của High Availablity Proxy, là phần mềm mã nguồn mở cân bằng tải TCP/HTTP và giải pháp proxy phổ biến chạy trên Linux, Solaris và FreeBSD. HAproxy phổ biến là nhờ cải thiện hiệu suất và độ tin cậy của môi trường máy chủ bằng cách cân bằng tải trên nhiều máy chủ (ví dụ: web, ứng dụng, cơ sở dữ liệu). Nó được sử dụng trong nhiều môi trường lớn như Github, Imgur, Instagram và Twitter.
 
### Các thuật ngữ trong HAproxy
 
#### Access Control List (ACL)
 
- Việc sử dụng danh sách kiểm soát truy cập (ACL) cung cấp giải pháp linh hoạt để đưa ra quyết định dựa trên nội dung trích ra từ request, response hoặc bất kì trạng thái môi trường nào, bao gồm những việc như:
  - Trích xuất một mẫu dữ liệu từ một dòng, bảng hoặc môi trường.
  - Tùy chọn áp dụng một số chuyển đổi định dạng cho mẫu.
  - Áp dụng 1 hoặc nhiều phương pháp pattern matching trên mẫu.
- Cú pháp của ACL trong HAproxy:
```
acl <aclname> <criterion>[,<converter>] [flags] [operator] [<pattern>] ...
```
> **Note:** <br>
> `<aclname>`: Tên của ACL, thường được dùng để mô tả rule. Bao gồm chữ hoa, chữ thường, số, '-', '_', '.' và ':'. <br>
> `<criterion>`: Dựa trên lấy mẫu, nó mô tả phần yêu request, response mà ACL áp dụng. <br>
> `<converter>`: Một hoặc nhiều `<converter>` có thể được chỉ định, cách nhau bởi dấu phẩy ','. Chúng có thể được sử dụng để tương tác với dữ liệu được cung cấp bởi `<criterion>`. <br>
> `flags`: Làm chính xác hơn về vị trí và cách áp dụng ACL. <br>
> `operator`: Áp dụng toán tử khi kết hợp dữ liệu được cung cấp bởi `<criterion>` và `<pattern>`. <br>
> `<pattern>`: Dữ liệu được cung cấp bởi `<criterion>` được so sánh với danh sách `<pattern>`.

- Một ACL trả về 2 giá trị:
  - *TRUE*: khi dữ liệu được cung cấp bởi `<criterion>` khớp với ít nhất một trong `<pattern>`.
  - *FALSE*: khi dữ liệu được cung cấp bởi `<criterion>` không khớp với bất kì `<pattern>`.
- Ví dụ:
```
acl req.fhdr(X-Forwarded-For) -m ip 10.0.0.0/8 172.16.0.0/12 192.168.0.0/16 
```
> **Note:** <br>
> Convert header X-Forwareded-For thành địa chỉ IP và so sánh với các địa chỉ IP private.

#### Backends
 
- Backends là máy chủ hoặc một tập các máy chủ sẽ nhận được yêu cầu chuyển tiếp. Backends có thể cân bằng tải dựa trên một số thuật toán cân bằng tải bao gồm:
	- Round-robin
	- Static round-robin
	- Least connections
- Ví dụ về Backend:
```
$ cat /etc/haproxy/haproxy.cfg
backend http-in
   balance roundrobin
   server s1 web1.traioi.com:80 check
   server s2 web2.traioi.com:80 check
```

#### Frontends

- Frontends được sử dụng để xác định các yêu cầu được chuyển tiếp như thế nào đến backends, bao gồm:
	- IP addresses và ports
	- ACLs
	- use_backend rules.

### Các loại Load Balancing

#### No load balancing

- Nếu 1 web server gặp sự cố, user sẽ không thể kết nối vào web server nữa. thêm vào đó, nếu nhiều users cố gắng kết nối vào server đồng thời và server không thể xử ký kịp thời, sẽ khiến cho kết nối bị chậm hoặc không thể kết nối.

#### Layer 4 load balancing

- 1 cách đơn giản để cân bằng tải network traffic đến nhiều servers là sử dụng layer 4 (transport layer) load balancing. Cách load balancing này sẽ chuyển tiếp user traffic dựa trên IP và port.

<p align="center">
	<img src="./layer_4_load_balancing.png">
</p>

- User truy cập vào load balancer, load balancer sẽ chuyển tiếp user's request đến nhóm *web-backend* của backend servers. Lúc này, backend server được chọn sẽ trả lời lại user's request. Tuy nhiên, tất cả các servers trong *web-backend* nên có nội dung giống nhau, để tránh trường hợp user nhận được nội dung không mong muốn. Lúc này, cả 2 web servers sẽ được kết nối với cùng 1 database server.

#### Layer 7 load balancing

- Một phương pháp phức tạp hơn để cân bằng tải network traffic là sử dụng layer 7 (application layer) load balancing. Sử dụng layer 7 cho phép load balancer chuyển tiếp request đến backend servers khác dựa trên nội dung của user's request. Chế độ này cho phép bạn chạy nhiều ứng dụng web servers trên cùng domain và port.

<p align="center">
	<img src="./layer_7_load_balancing.png">
</p>

- Trong ví dụ này, nếu user gửi requests *yourdomain.com/blog*, họ sẽ được chuyển tiếp đến backend *blog* (là server chạy ứng dụng blog). Các request khác sẽ được chuyển tiếp đến *web-backend* (là server đang chạy các ứng dụng khác). Cả 2 trường hợp đều sử dụng chung database server.

```
frontend http
	bind *:80
	mode http

	acl url_blog path_beg /blog
	use_backend blog-backend if url_blog
	
	default_backend web-backend
```
> **Note:** <br>
> `acl url_blog path_beg /blog`: trùng khớp với request nếu path của user request bắt đầu với */blog* <br>
> `use_backend blog-backend if url_blog`: sử dụng ACL để chuyển tiếp traffic đến *blog-backend* <br>
> `default_backend web-backend`: Tất cả các traffic mặc định sẽ được chuyển tiếp đến *web-backend*.

### Compile HAproxy from source

#### Môi trường thực nghiệm

- **Virtual machine:** Virtualbox 5.0.32
- **Operating System:** CentoOS 6.9
- **HAproxy version:** 1.5.19

#### Compile HAproxy from source

- Tải source HAproxy từ trang chủ.
```
$ wget https://www.haproxy.org/download/1.5/src/haproxy-1.5.19.tar.gz
```

- Giải nén
```
$ tar xvzf haproxy-1.5.19.tar.gz
$ cd haproxy-1.5.19
```

- Compile from source.
```
$ make TARGET=generic
$ make install
```
> **Note:** <br>
> `TARGET=generic`: Sử dụng các tuỳ chọn mặc định khi compile.

- 
