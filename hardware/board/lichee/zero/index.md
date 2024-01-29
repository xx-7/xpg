
```bash

docker build -t v3szero -f ./v3s-zero/Dockerfile .

docker run -v $PWD/:/project -ti v3szero /bin/bash

arm-linux-gnueabihf-gcc -v

mkdir /project/dist/

```






