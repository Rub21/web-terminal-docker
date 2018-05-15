# Web Terminal Docker

Accessing to the terminal through web using [wetty](https://github.com/krishnasrinivas/wetty).  


### Build 

```
docker build --build-arg PASS=1234 -t web-terminal .

```

### Run

```
docker run -p 3000:3000 -t web-terminal

```


### Access


Open: https://0.0.0.0:3000 or https://localhost:3000

![image](https://user-images.githubusercontent.com/1152236/40078591-a6bdef1a-584a-11e8-82bb-79f8e2e4e312.png)

