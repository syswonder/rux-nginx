rm -f disk.img

git clone https://github.com/syswonder/syswonder-web.git
mkdir -p apps/c/nginx/html
cp -r syswonder-web/docs/* apps/c/nginx/html
rm -f -r syswonder-web

make A=apps/c/nginx/ LOG=info NET=y BLK=y ARCH=aarch64 SMP=4 MUSL=y run