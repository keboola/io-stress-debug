time sudo docker run --rm --volume=/tmp:/data alpine sh -c chown $(id -u) /data -R && chmod -R u+wrX /data