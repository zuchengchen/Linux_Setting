# papp_cloud

[:book: papp_cloud使用手册](docs/README.md)

---

## 概述

  papp_cloud 是一个命令行工具，具备ssh，scp，rsync, sftp的基础功能, 支持IPv4,IPv6两种协议。

## 功能

- ssh
- scp
- rsync
- sftp

## 克隆项目

```bash
git@git.paratera.net:wanghui/papp_cloud.git
```

## 编译打包

```bash
$ make tarball
```

## 安装配置

**安装需求**

- 操作系统： linux/macOSX

**安装方式**

解压安装包:

```bash
tar xf papp_cloud-release.zip
```

进入papp_cloud-release安装目录，执行install.sh完成安装

```
cd papp_cloud-release
./install.sh install
```

## 报告问题
请发送文件到 <wanghui@paratera.com> 或者在 [papp_cloud GitLab Issue](https://git.paratera.net/wanghui/papp_cloud/issues)上提交问题
