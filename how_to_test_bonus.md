## Redis

Install Redis-cli on the host

`sudo apt-get install redis-tools`

Maket http request
redis-cli -h 127.0.0.1 -p 6379 ping

Respond must be : PONG

redis-cli -h 127.0.0.1 -p 6379 set testkey "Hello, Redis!"
redis-cli -h 127.0.0.1 -p 6379 get testkey



OR



redis-commander:
  container_name: redis-commander
  image: rediscommander/redis-commander:latest
  environment:
    - REDIS_HOSTS=local:redis:6379
  ports:
    - 8081:8081
  networks:
    - inception_network