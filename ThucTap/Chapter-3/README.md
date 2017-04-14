# III. Cách kiểm tra các phần cứng server

* **[1. Kiểm tra một số thông tin của OS](#chapter-1)**
* **[2. Kiểm tra CPU](#chapter-2)**
* **[3. Kiểm tra các thiết bị PCI](#chapter-3)**
* **[4. Kiểm tra bộ nhớ lưu trữ](#chapter-4)**
* **[5. Kiểm tra thông tin trên đĩa](#chapter-5)**
* **[6. Kiểm tra thông tin card mạng](#chapter-6)**
* **[7. Kiểm tra thông tin BIOS](#chapter-7)**
* **[8. Kiểm tra thông tin Mainboard](#chapter-8)**

<a href="chapter-1"></a>
### 1. Kiểm tra một số thông tin của OS

#### a. uname

- Hiển thị thông tin hệ thống
```
$ uname -a
Linux localhost.localdomain 3.10.0-514.el7.x86_64 #1 SMP Tue Nov 22 16:42:41 UTC 2016 x86_64 x86_64 x86_64 GNU/Linux
```

#### b. /etc/redhat-release

- Hiển thị tên distro Linux OS.
```
$ cat /etc/redhat-release 
CentOS Linux release 7.3.1611 (Core)
```

#### c. top

- Liệt kê các tiến trình đang hoạt động
```
$ top
top - 04:30:00 up  1:16,  2 users,  load average: 0.00, 0.01, 0.05
Tasks:  90 total,   1 running,  89 sleeping,   0 stopped,   0 zombie
%Cpu(s):  0.0 us,  0.0 sy,  0.0 ni, 98.7 id,  1.3 wa,  0.0 hi,  0.0 si,  0.0 st
KiB Mem :  1016476 total,   651712 free,   102860 used,   261904 buff/cache
KiB Swap:        0 total,        0 free,        0 used.   745736 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S %CPU %MEM     TIME+ COMMAND                               
    1 root      20   0  128092   6700   3948 S  0.0  0.7   0:01.81 systemd                               
    2 root      20   0       0      0      0 S  0.0  0.0   0:00.00 kthreadd                              
    3 root      20   0       0      0      0 S  0.0  0.0   0:00.04 ksoftirqd/0                           
    5 root       0 -20       0      0      0 S  0.0  0.0   0:00.00 kworker/0:0H                          
    7 root      rt   0       0      0      0 S  0.0  0.0   0:00.00 migration/0                           
    8 root      20   0       0      0      0 S  0.0  0.0   0:00.00 rcu_bh                                
    9 root      20   0       0      0      0 S  0.0  0.0   0:00.72 rcu_sched                             
   10 root      rt   0       0      0      0 S  0.0  0.0   0:00.03 watchdog/0                            
   12 root       0 -20       0      0      0 S  0.0  0.0   0:00.00 khelper                               
   13 root      20   0       0      0      0 S  0.0  0.0   0:00.00 kdevtmpfs                             
   14 root       0 -20       0      0      0 S  0.0  0.0   0:00.00 netns   
```

<a name="chapter-2"></a>
### 2. Kiểm tra CPU

#### a. lspcu

- Dùng để kiểm tra các thông số CPU trên Server.

```
$ lscpu
Architecture:          x86_64
CPU op-mode(s):        32-bit, 64-bit
Byte Order:            Little Endian 
CPU(s):                1 		# 1 core
On-line CPU(s) list:   0
Thread(s) per core:    1		# Mỗi luồng có 1 core
Core(s) per socket:    1		# Mỗi socket có 1 core
Socket(s):             1		# 1 CPU
NUMA node(s):          1
Vendor ID:             GenuineIntel	# ID nhà sản xuất
CPU family:            6
Model:                 69
Model name:            Intel(R) Core(TM) i5-4200U CPU @ 1.60GHz
Stepping:              1
CPU MHz:               2294.688  # Tốc độ đọc CPU
BogoMIPS:              4589.37
Hypervisor vendor:     KVM		 # Lớp ảo hóa trong Kernel-based Virtual Machine
Virtualization type:   full		 # Hỗ trợ ảo hóa hoàn toàn
L1d cache:             32K
L1i cache:             32K
L2 cache:              256K
L3 cache:              3072K
NUMA node0 CPU(s):     0
```

### b. /proc/cpuinfo

- Hiển thị thông tin CPU.

```
$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 69
model name      : Intel(R) Core(TM) i5-4200U CPU @ 1.60GHz
stepping        : 1
cpu MHz         : 2294.688
cache size      : 3072 KB
physical id     : 0
siblings        : 1
core id         : 0
cpu cores       : 1
apicid          : 0
initial apicid  : 0
fpu             : yes
fpu_exception   : yes
cpuid level     : 13
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx rdtscp lm constant_tsc rep_good nopl xtopology nonstop_tsc pni pclmulqdq monitor ssse3 cx16 sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx rdrand hypervisor lahf_lm abm
bogomips        : 4589.37
clflush size    : 64
cache_alignment : 64
address sizes   : 39 bits physical, 48 bits virtual
power management:
```

<a name="chapter-3"></a>
### 3. Kiểm tra các thiết bị PCI

- **lspci**

```
$ lspci
00:00.0 Host bridge: Intel Corporation 440FX - 82441FX PMC [Natoma] (rev 02)
00:01.0 ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton II]
00:01.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (rev 01)
00:02.0 VGA compatible controller: InnoTek Systemberatung GmbH VirtualBox Graphics Adapter
00:03.0 Ethernet controller: Intel Corporation 82540EM Gigabit Ethernet Controller (rev 02)
00:04.0 System peripheral: InnoTek Systemberatung GmbH VirtualBox Guest Service
00:05.0 Multimedia audio controller: Intel Corporation 82801AA AC'97 Audio Controller (rev 01)
00:06.0 USB controller: Apple Inc. KeyLargo/Intrepid USB
00:07.0 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 08)
00:0b.0 USB controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB2 EHCI Controller
00:0d.0 SATA controller: Intel Corporation 82801HM/HEM (ICH8M/ICH8M-E) SATA Controller [AHCI mode] (rev 02)
```

<a name="chapter-4"></a>
### 4. Kiểm tra bộ nhớ lưu trữ

#### a. free -m

- Hiển thị bộ nhớ RAM và Swap không sử dụng và đang sử dụng trong hệ thống.
- Option `-m` cho phép hiển thị bộ nhớ dạng megabytes.
```
$ free -m
              total        used        free      shared  buff/cache   available
Mem:            992         100         637           6         255         728
Swap:             0           0           0
```

#### b. /proc/meminfo

- Hiển thị thông tin bộ nhớ 

```
$ cat /proc/meminfo 
MemTotal:        1016476 kB
MemFree:          652668 kB
MemAvailable:     746208 kB
Buffers:           11600 kB
Cached:           205644 kB
SwapCached:            0 kB
Active:           125984 kB
Inactive:         173968 kB
Active(anon):      82948 kB
Inactive(anon):     6808 kB
Active(file):      43036 kB
Inactive(file):   167160 kB
Unevictable:           0 kB
Mlocked:               0 kB
SwapTotal:             0 kB
SwapFree:              0 kB
Dirty:                 0 kB
Writeback:             0 kB
AnonPages:         82756 kB
Mapped:            23336 kB
Shmem:              7068 kB
Slab:              44152 kB
SReclaimable:      22260 kB
SUnreclaim:        21892 kB
KernelStack:        1664 kB
PageTables:         3828 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:      508236 kB
Committed_AS:     320632 kB
VmallocTotal:   34359738367 kB
VmallocUsed:        4296 kB
VmallocChunk:   34359731068 kB
HardwareCorrupted:     0 kB
AnonHugePages:      6144 kB
HugePages_Total:       0
HugePages_Free:        0
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:       2048 kB
DirectMap4k:       55232 kB
DirectMap2M:      993280 kB
```

<a name="chapter-5"></a>
### 5. Kiểm tra thông tin trên đĩa

#### a. df

- Hiển thị thông tin của các filesystem được sử dụng trên đĩa.

```
$ df -h
Filesystem             Size  Used Avail Use% Mounted on
/dev/sda2               20G  1.1G   18G   6% /
devtmpfs               488M     0  488M   0% /dev
tmpfs                  497M     0  497M   0% /dev/shm
tmpfs                  497M  6.7M  490M   2% /run
tmpfs                  497M     0  497M   0% /sys/fs/cgroup
/dev/sda1              461M  100M  339M  23% /boot
/dev/mapper/lvm-data3  2.0G  6.0M  1.8G   1% /data3
/dev/mapper/lvm-data2  2.9G  9.0M  2.8G   1% /data2
tmpfs                  100M     0  100M   0% /run/user/0
/dev/md0               2.0G  6.0M  1.9G   1% /data
```

#### b. fdisk

- Hiển thị các phân vùng trên đĩa.

```
$ fdisk -l

Disk /dev/sda: 21.5 GB, 21474836480 bytes, 41943040 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk label type: dos
Disk identifier: 0x0001a71d

   Device Boot      Start         End      Blocks   Id  System
/dev/sda1   *        2048      976895      487424   83  Linux
/dev/sda2          976896    41943039    20483072   83  Linux
```

#### dd if=/dev/zero of=ddfile bs=8k count=250000

- Kiểm tra tốc độ đĩa cứng
```
$ dd if=/dev/zero of=ddfile bs=8k count=250000
250000+0 records in
250000+0 records out
2048000000 bytes (2.0 GB) copied, 4.5757 s, 448 MB/s
```

<a name="chapter-6"></a>
### 6. Kiểm tra thông tin card mạng

```
$ lspci | grep -Ei "network|ethernet"
00:03.0 Ethernet controller: Intel Corporation 82540EM Gigabit Ethernet Controller (rev 02)
```

<a name="chapter-7"></a>
### 7. Kiểm tra thông tin BIOS

```
$ dmidecode -t bios
# dmidecode 3.0
Scanning /dev/mem for entry point.
SMBIOS 2.5 present.

Handle 0x0000, DMI type 0, 20 bytes
BIOS Information
        Vendor: innotek GmbH
        Version: VirtualBox
        Release Date: 12/01/2006
        Address: 0xE0000
        Runtime Size: 128 kB
        ROM Size: 128 kB
        Characteristics:
                ISA is supported
                PCI is supported
                Boot from CD is supported
                Selectable boot is supported
                8042 keyboard services are supported (int 9h)
                CGA/mono video services are supported (int 10h)
                ACPI is supported
```

<a name="chapter-8"></a>
### 8. Kiểm tra thông tin Mainboard

```
$ dmidecode -t baseboard
# dmidecode 3.0
Scanning /dev/mem for entry point.
SMBIOS 2.5 present.

Handle 0x0008, DMI type 2, 15 bytes
Base Board Information
        Manufacturer: Oracle Corporation
        Product Name: VirtualBox
        Version: 1.2
        Serial Number: 0
        Asset Tag: Not Specified
        Features:
                Board is a hosting board
        Location In Chassis: Not Specified
        Chassis Handle: 0x0003
        Type: Motherboard
        Contained Object Handles: 0
```