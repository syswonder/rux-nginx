# How to run nginx on ruxos

## commands

### download OS code

If you have not downloaded RuxOS, please download it first. The commands next are all in directory `ruxos/`

```shell
git clone https://github.com/syswonder/ruxos.git
cd ruxos
```

### download app code

To run nginx on RuxOS, you should download this repo to its apps directory

```
git clone https://github.com/syswonder/rux-nginx.git ./apps/c/nginx
```

### run nginx

The commands below is to run nginx with different features.  These examples run in aarch64 with musl, if you want to run in x86_64, just replace `ARCH=aarch64` with `ARCH=x86_64`, and if you do not want to run with musl , just delete `MUSL=y`.

use v9p and musl in aarch64：

```shell
make A=apps/c/nginx/ LOG=info NET=y BLK=y FEATURES=virtio-9p V9P=y V9P_PATH=./apps/c/nginx/html/ ARCH=aarch64 SMP=4 MUSL=y run
```

not use v9p，but use musl in aarch64：

```shell
make A=apps/c/nginx/ LOG=info NET=y BLK=y ARCH=aarch64 SMP=4 MUSL=y run
```

If you change running option or source code , remember to clean the compile files before running.

```shell
make clean_c A=apps/c/nginx
```

### run example

You can just use command next to run our example

```bash
bash ./apps/c/nginx/example_run.sh
```

## ruxgo

If you want to use [ruxgo](https://github.com/syswonder/ruxgo.git) to run nginx, remember to run `apps/c/nginx/create_nginx_img.sh` first to make sure disk.img is right, or you can build your own disk.img

You can copy `ruxgo/apps/nginx/ruxos/config_linux.toml`  to nginx directory and run ruxgo

## HTTPS

If you want to use https in nginx web server, you should use branch `with_ssl` 

```shell
rm -rf ./apps/c/nginx
git clone https://github.com/syswonder/rux-nginx.git -b with_ssl ./apps/c/nginx
```

Notice that the certificates are privately generated and security is not guaranteed. You should replace `https.crt` and `https.key` with your own safe certificates if you have.

# nginx conf

You can change next files to change nginx conf:

`/nginx/conf/nginx.conf`

`/nginx/conf/mime.types`

After change you should copy them to disk.img (you can run `apps/c/nginx/create_nginx_img.sh` to do that)