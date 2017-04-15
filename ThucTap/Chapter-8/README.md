# VIII. Tìm hiểu SystemD, Init

* **[1. Init](#chapter-1)**
* **[2. SystemD](#chapter-2)**
* **[3. So sánh Init và SystemD](#chapter-3)**

<a name="chapter-1"></a>
### 1. Init

- Là tiến trình khởi động đầu tiên trong Linux.
- Nhiệm vụ của init là start và stop các process, services, .. 
- Do init là tiến trình đầu tiên trên hệ thống nên PID=1.
- Có 3 kiểu Init system chính trong hệ thống Linux:
  - **SystemV**: phiên bản truyền thống của init system.
  - **Upstart**: sử dụng trong các phiên bản Ubuntu < 15.04.
  - **Systemd**: sử dụng trên nhiều distro Linux hiện nay, dần thay thế init system mặc định.

<a name="chapter-2"></a>
### 2. SystemD

- SystemD còn có thể mount filesystems, quản lý network sockets, ..
- SystemD chia ra các đơn vị unit:
  - **Service unit** (.service): để start và stop các dịch vụ.
  - **Mount unit**(.mount): để quản lý các mount point.
  - **Target unit**(.target): điều khiển các runlevels.

<a name="chapter-3"></a>
### 3. So sánh Init và SystemD

#### a. Service Related Commands
| SysV Init | SystemD | Notes |
| --- | --- | --- |
| service &lt;service&gt; start | systemctl start &lt;service&gt;.service | Start &lt;service&gt; |
| service &lt;service&gt; stop | systemctl stop &lt;service&gt;.service | Stop &lt;service&gt; |
| service &lt;service&gt; restart | systemctl restart &lt;service&gt;.service | Restart &lt;service&gt; |
| service &lt;service&gt; reload | systemctl reload &lt;service&gt;.service | Reload &lt;service&gt; |
| service &lt;service&gt; status | systemctl status &lt;service&gt;.service | &lt;service&gt; status |
| service &lt;service&gt; condrestart | systemctl condrestart &lt;service&gt;.service | Restart khi &lt;service&gt; đang chạy |
| chkconfig &lt;service&gt; on | systemctl enable <systemctl>.service | Enable &lt;service&gt; khi boot |
| chkconfig &lt;service&gt; off | systemctl disable <systemctl>.service | Disable &lt;service&gt; khi boot |
| chkconfig &lt;service&gt; | systemctl is-enabled <systemctl>.service | Kiểm tra nếy &lt;service&gt; đang ở startup |
| chkconfig &lt;service&gt; --add | systemctl daemon-reload | Tạo thêm &lt;service&gt; |

#### b. Runlevels

| SysV Init | SystemD | Notes |
| --- | --- | --- |
| 0 | runlevel0.target, poweroff.target | Tạm dừng hệ thống |
| 1, s, single | runlevel1.target, rescue.target | Single user mode |
| 2 | runlevel2.target, multi-user.target | Multi user |
| 3 | runlevel3.target, multi-user.target | Multi user with network | 
| 4 | runlevel4.target, multi-user.target | |
| 5 | runlevel5.target, graphical.target | Multi user with graphical |
| 6 | runlevel6.target, reboot.target | Reboot |
| emergency | emergency.target | Emergency Shell |
| telinit3 | systemctl isolate multi.target | Change to multi user runlevel |
| `sed s/^id:*initdefault:/id:3:initdefault:/` | ln -sf /lib/systemd/system/multi-user.target /etc/systemd/system/default.target | Set multi-user target on next boot |
| runlevel | systemctl get-default | Check current runlevel |
| `set s/^id:*initdefault:/id:3:initdefault:/` | systemctl set-default multi-user.target | Change default runlevel |

#### c. Miscellaneous Commands

| SysV Init | SystemD | Notes |
| --- | --- | --- |
| halt | systemctl halt | System halt |
| poweroff | systemctl poweroff | Power off the system |
| reboot | systemctl reboot | Restart the system | 
| pm-suspend | systemctl suspend | Suspend the system |
| pm-hibernate | systemctl hibernate | Hibernate |
| tail -f /var/log/messages, tail -f /var/log/syslog | journalctl -f | Follow the system log file |

#### d. SystemD new Commands

| SystemD | Notes |
| --- | --- |
| systemctl.&lt;service&gt; start -H user@host | Execute a systemd command on remote host |
| systemd.analyze, systemd.analyze time | Check boot time |
| systemctl kill &lt;service&gt; | Kill all processes related to &lt;service&gt; |
| journalctf --since=today | Get logs for events for today |
| hostnamectl | Hostname and other host related infomation |
| timedatectl | Date and time of system with timezone and other information |
