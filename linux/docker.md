# install

## Arch

```bash

sudo pacman -Syu docker

# 免root
sudo gpasswd -a ${USER} docker

sudo systemctl restart docker

# debug 启动
sudo dockerd --debug

# 更新完内核要重启才能加载overlay驱动

# 测试容器
docker run hello-world

sudo mkdir /etc/docker
sudo nano /etc/docker/daemon.json

{
	"registry-mirrors": ["https://mirror.baidubce.com"],
    "storage-driver": "overlay2"
}

# 会显示mirrors信息
docker info

docker version

# 先拉取再 docker build 会直接用
docker pull debian


sudo du -h --max-depth=1 /var/lib/docker
# 删除镜像,容器
rm -rf /var/lib/docker

# service文件目录
cat /usr/lib/systemd/system/docker.service


# 有些版本dockerd 参数是/run/docker.sock, docker 默认是 /var/run/docker.sock
# 配置docker.conf也无效, 就在 docker.service 修改或加上下面参数
# -H unix:///var/run/docker.sock
sudo nano /usr/lib/systemd/system/docker.service

# 修改完 service -> reload
sudo systemctl daemon-reload


```

## debian 

```bash
sudo apt install apt-transport-https ca-certificates curl gnupg2 software-properties-common

# 添加证书
sudo mkdir -p /usr/share/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor --yes -o /usr/share/keyrings/docker-archive-keyring.gpg
sudo chmod a+r /usr/share/keyrings/docker-archive-keyring.gpg

# 添加源
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs)  stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update

sudo apt install docker-ce docker-ce-cli containerd.io

# 添加docker组 重新登录才生效
sudo usermod -aG docker $USER

```

# use

```bash

# build 镜像
# -t 给镜像加一个Tag
# ImageName 给镜像起的名称
# TagName 给镜像的Tag名
# Dir Dockerfile所在目录
docker build  -t ImageName:TagName dir

# 镜像列表
docker images

# 运行列表
docker ps

# 显示所有容器
docker ps --all

# 删除容器
docker rm ContainerId

# 删除镜像 删镜像前, 关联的容器要全删除
docker rmi ImageName

# 查看网络设置
docker network inspect br0

# 重新配置网络
docker network prune
docker network create --subnet=192.168.8.1/24 --gateway=192.168.8.1 br0

# run
docker run [OPTIONS] IMAGE [COMMAND] [ARG...]

# 运行bash exit退出bash
docker run --name=TEST -ti ImageName:TagName /bin/bash

# 后台运行 -v 映射目录 -p端口
docker run -tid -p 3308:3306 -v $LOCAL:$HOST /PROGAME

# https://docs.docker.com/engine/reference/commandline/run/
# OPTIONS
--add-host		Add a custom host-to-IP mapping (host:ip)
--attach , -a		Attach to STDIN, STDOUT or STDERR
--blkio-weight		Block IO (relative weight), between 10 and 1000, or 0 to disable (default 0)
--blkio-weight-device		Block IO weight (relative device weight)
--cap-add		Add Linux capabilities
--cap-drop		Drop Linux capabilities
--cgroup-parent		Optional parent cgroup for the container
--cgroupns		API 1.41+Cgroup namespace to use (host|private) ‘host’: Run the container in the Docker host’s cgroup namespace ‘private’:
--cidfile		Write the container ID to the file
--cpu-count		CPU count (Windows only)
--cpu-percent		CPU percent (Windows only)
--cpu-period		Limit CPU CFS (Completely Fair Scheduler) period
--cpu-quota		Limit CPU CFS (Completely Fair Scheduler) quota
--cpu-rt-period		Limit CPU real-time period in microseconds
--cpu-rt-runtime		Limit CPU real-time runtime in microseconds
--cpu-shares , -c		CPU shares (relative weight)
--cpus		Number of CPUs
--cpuset-cpus		CPUs in which to allow execution (0-3, 0,1)
--cpuset-mems		MEMs in which to allow execution (0-3, 0,1)
--detach , -d		Run container in background and print container ID
--detach-keys		Override the key sequence for detaching a container
--device		Add a host device to the container
--device-cgroup-rule		Add a rule to the cgroup allowed devices list
--device-read-bps		Limit read rate (bytes per second) from a device
--device-read-iops		Limit read rate (IO per second) from a device
--device-write-bps		Limit write rate (bytes per second) to a device
--device-write-iops		Limit write rate (IO per second) to a device
--disable-content-trust	true	Skip image verification
--dns		Set custom DNS servers
--dns-option		Set DNS options
--dns-search		Set custom DNS search domains
--domainname		Container NIS domain name
--entrypoint		Overwrite the default ENTRYPOINT of the image
--env , -e		Set environment variables
--env-file		Read in a file of environment variables
--expose		Expose a port or a range of ports
--gpus		API 1.40+ GPU devices to add to the container (‘all’ to pass all GPUs)
--group-add		Add additional groups to join
--health-cmd		Command to run to check health
--health-interval		Time between running the check (ms|s|m|h) (default 0s)
--health-retries		Consecutive failures needed to report unhealthy
--health-start-period		Start period for the container to initialize before starting health-retries countdown (ms|s|m|h) (default 0s)
--health-timeout		Maximum time to allow one check to run (ms|s|m|h) (default 0s)
--help		Print usage
--hostname , -h		Container host name
--init		Run an init inside the container that forwards signals and reaps processes
--interactive , -i		Keep STDIN open even if not attached
--io-maxbandwidth		Maximum IO bandwidth limit for the system drive (Windows only)
--io-maxiops		Maximum IOps limit for the system drive (Windows only)
--ip		IPv4 address (e.g., 172.30.100.104)
--ip6		IPv6 address (e.g., 2001:db8::33)
--ipc		IPC mode to use
--isolation		Container isolation technology
--kernel-memory		Kernel memory limit
--label , -l		Set meta data on a container
--label-file		Read in a line delimited file of labels
--link		Add link to another container
--link-local-ip		Container IPv4/IPv6 link-local addresses
--log-driver		Logging driver for the container
--log-opt		Log driver options
--mac-address		Container MAC address (e.g., 92:d0:c6:0a:29:33)
--memory , -m		Memory limit
--memory-reservation		Memory soft limit
--memory-swap		Swap limit equal to memory plus swap: ‘-1’ to enable unlimited swap
--memory-swappiness	-1	Tune container memory swappiness (0 to 100)
--mount		Attach a filesystem mount to the container
--name		Assign a name to the container
--network		Connect a container to a network
--network-alias		Add network-scoped alias for the container
--no-healthcheck		Disable any container-specified HEALTHCHECK
--oom-kill-disable		Disable OOM Killer
--oom-score-adj		Tune host’s OOM preferences (-1000 to 1000)
--pid		PID namespace to use
--pids-limit		Tune container pids limit (set -1 for unlimited)
--platform		Set platform if server is multi-platform capable
--privileged		Give extended privileges to this container
--publish , -p		Publish a container’s port(s) to the host
--publish-all , -P		Publish all exposed ports to random ports
--pull	missing	Pull image before running (always, missing, never)
--quiet , -q		Suppress the pull output
--read-only		Mount the container’s root filesystem as read only
--restart	no	Restart policy to apply when a container exits
--rm		Automatically remove the container when it exits
--runtime		Runtime to use for this container
--security-opt		Security Options
--shm-size		Size of /dev/shm
--sig-proxy	true	Proxy received signals to the process
--stop-signal		Signal to stop the container
--stop-timeout		Timeout (in seconds) to stop a container
--storage-opt		Storage driver options for the container
--sysctl		Sysctl options
--tmpfs		Mount a tmpfs directory
--tty , -t		Allocate a pseudo-TTY
--ulimit		Ulimit options
--user , -u		Username or UID (format: <name|uid>[:<group|gid>])
--userns		User namespace to use
--uts		UTS namespace to use
--volume , -v		Bind mount a volume
--volume-driver		Optional volume driver for the container
--volumes-from		Mount volumes from the specified container(s)
--workdir , -w		Working directory inside the container



```

# Proxy

```bash
# Docker 代理分三种

# 1.dockerd 代理, 当pull这些用的就是dockerd代理

# dockerd 代理 配置完重启才生效
sudo systemctl daemon-reload
sudo systemctl restart docker

sudo mkdir -p /etc/systemd/system/docker.service.d
sudo nano /etc/systemd/system/docker.service.d/proxy.conf
[Service]
Environment="HTTP_PROXY=http://proxy.example.com:8080/"
Environment="HTTPS_PROXY=http://proxy.example.com:8080/"
Environment="NO_PROXY=localhost,127.0.0.1"

# 2. 容器代理, 容器运行期间使用
nano ~/.docker/config.json

{
 "proxies":
 {
   "default":
   {
     "httpProxy": "http://proxy.example.com:8080",
     "httpsProxy": "http://proxy.example.com:8080",
     "noProxy": "localhost,127.0.0.1,.example.com"
   }
 }
}

# 3. build 命令行代理 build时候用

docker build . \
    --build-arg "HTTP_PROXY=http://proxy.example.com:8080/" \
    --build-arg "HTTPS_PROXY=http://proxy.example.com:8080/" \
    --build-arg "NO_PROXY=localhost,127.0.0.1,.example.com" \


```