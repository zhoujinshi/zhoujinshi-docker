# Alpine Linux rootfs Builder

此构建器映像构建了一个Alpine Linux，rootfs.tar.xz供我们在构建基本Alpine Linux映像时使用。该mkimage-alpine.sh脚本完成所有繁重的工作。在配置图像期间，我们添加了apk-install便利脚本。

## 选项

构建器有多种选择：

* `-r <release>：要使用的发布标记（例如edge或v3.1）。
* `-m <mirror>：镜像URL基础。默认为http://nl.alpinelinux.org/alpine。
* `-s：输出rootfs.tar.xz到标准输出。
* `-c：将apk-install脚本添加到生成的rootfs中。
* `-e：将额外的edge/main和edge/testing引脚添加到存储库文件。
* `-d：通过删除空白root密码禁用su到root。
* `-E：不添加community到存储库文件（对于没有社区存储库的版本是必需的）。
* `-t <timezone>：设置时区。
* `-p <packages>：逗号分隔的包列表。默认是alpine-base。
* `-b：提取alpine-base没有依赖项的rootfs。对于-p仍然需要/etc/*-release和缩小的图像/etc/issue。
* `-a <architecture>：更改要下载的rootfs的体系结构。默认是x86_64