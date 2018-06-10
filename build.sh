git clone https://github.com/keboola/docker-custom-php ~/docker-custom-php
sudo docker build ~/docker-custom-php -t docker-custom-php

sudo docker build ./Dockerfile-network -t stresstest-network
