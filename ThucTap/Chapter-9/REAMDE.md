# IX. Bash shell

* **[1. Get public IP](#chapter-1)**
* **[2. Random pass](#chapter-2)**
* **[3. alias](#chapter-3)**
* **[4. awk](#chapter-4)**
* **[5. sed](#chapter-5)**
* **[6. cut](#chapter-6)**
* **[7. cat](#chapter-7)**
* **[8. Viết script backup dữ liệu ra ổ cứng di động](#chapter-8)**

<a name="chapter-1"></a>
## 1. Get public IP

```
dig +short myip.opendns.com @resolver1.opendns.com
```
> **Note:** <br>
> `dig`: Công cụ tra cứu DNS. <br>
> `+short`: Option rút gọn ouput của `dig`. <br>
> `myip.opendns.com`: Domain được cấu hình để trả về địa chỉ IP WAN của router. <br>
> `@resolver1.opendns.com`: 

<a name="chapter-2"></a>
## 2. Random pass

```
echo $(cat /dev/urandom | tr -dc 'A-Za-z0-9' | head -c 15)
```
