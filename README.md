tutum/container-links
===========================

Encrypted links using ssh channel
---------------------------------

```
Host A (server side):
    docker run -d -P \
      -e TUTUM_PUBLIC_KEY=<"ssh-rsa [...]"> \
      --link <container>:<whatever_name> \
      tutum/container-links

Host B (client side):
    docker run -d \
      -e TUTUM_PRIVATE_KEY=<"RSA PRIVATE KEY [...]"> \
      -e TUTUM_PUBLIC_KEY=<"ssh-rsa [...]"> \
      -e SERVER_PORT_22_TCP_PORT=<PORT_OF_SERVER> \
      -e SERVER_PORT_22_TCP_ADDR=<IP_OF_HOST_A> \
      --expose <PORT_OF_SERVICE> \
      --name securelink \
      tutum/container-links

```

**Examples (wordpress && mysql)**

```
Host A:
    docker run -d -e MYSQL_PASS=admin --name mysql tutum/mysql:latest

    docker run -d -P \
      -e TUTUM_PUBLIC_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDBoUxftcclQOrFccphJ9UueEWKFB7oFblWnYAbZWQ6Suag3a/y/Za9enJj0t4afkaJX4F0L6YhYuinN0jh/JKpYirTUl9Z+2lFL6jxENPqlkQ6Awt0Eu8xNTU+7d4Gs5/Vd4Ir55FOMZKu1L202yMuUUrMSxMYV7iNf3fqtNnOD2LalAsbuHAvQGVgIDVaBaFUwDr/PuLGq6Ys7t/5BBlOOhBeQlOBFjyNrzSiTgu+njyJNyaVA/73C8lE4Pnkur5MW7azcfGMwEDoAx4+hpra/SMXWSQWCd0jMU7G+/yko5z8J0npKmQq9HHtCSWbF8+awLAGRBN8/aeWSAklTM9/ root@e8e284d8ce8f" \
      --link mysql:whatever \
      tutum/container-links

Host B:
    docker run -d \
      -e TUTUM_PRIVATE_KEY="-----BEGIN RSA PRIVATE KEY-----\nMIIEogIBAAKCAQEAwaFMX7XHJUDqxXHKYSfVLnhFihQe6BW5Vp2AG2VkOkrmoN2v\n8v2WvXpyY9LeGn5GiV+BdC+mIWLopzdI4fySqWIq01JfWftpRS+o8RDT6pZEOgML\ndBLvMTU1Pu3eBrOf1XeCK+eRTjGSrtS9tNsjLlFKzEsTGFe4jX936rTZzg9i2pQL\nG7hwL0BlYCA1WgWhVMA6/z7ixqumLO7f+QQZTjoQXkJTgRY8ja80ok4Lvp48iTcm\nlQP+9wvJROD55Lq+TFu2s3HxjMBA6AMePoaa2v0jF1kkFgndIzFOxvv8pKOc/CdJ\n6SpkKvRx7QklmxfPmsCwBkQTfP2nlkgJJUzPfwIDAQABAoIBAEA+9alYFiCdPoiO\nrfi4j7pge6pJ7MtS0fEURzpP1QambYl4pPW6AHcUFrpacAlYVq0j/D8BxFyVhd5d\nsJgTBtKe2NjPHwYrLg2ft61syPOwMikRc45q7eRk5CriH+YXWXQpuA47QnIwbpwF\nyIAmqbCnlmrcihRsnraMUcyVfyMoUfJRJJUD93IUOk5QqNPa8wqh18v5nHUcTWfs\nroX5+kg0/0LL0I15Dvh9yWBJ9hfH2AXKlevzH0q8Tlwe8/MzEDyztdUa4Q36e08e\nMQo+LhRJAaOqE6sYuMTAe6KtfCCItP5z060ujwdcEYHLBnp78590Hdcofq1ACRdG\n7IDYmPkCgYEA5aXzB+LZY5XMsSE+X5nClKNGbFBomygGIJUtekWOTJSDZWFxU09i\nmyodvK2QMOuwHgKM8outfWMl6Au5m2PtMlIacsj1Rlb1JG6Ao7E7OnMZH/9sjUlu\nyZua1dsagn073QYwhm+7+LbIrpWdaflBPB3GfGSzum7JPpfrFgbouFsCgYEA19lL\nWs9hXnGLw2EMHAdZTSqJfteB4BS+GPBSRLGtMxaD8fHd5lBo5zH+6Qh4CZaweqQQ\n8rPp7zI2Omi8YH2u1o+nFQbo9AzdYRdjm8gP0GgvGZtiAdv29vmXw0bTC8WQNPII\nridWMFTmtItwTC9FlK8q/x7/06AVy/nOjFg9zq0CgYBz57bqkwbvKSr/d2zYqW04\nwdOIVWkGbkPxa/lhDfwNEKPkpjKhPp7g+3e4w8zTtBDWhKkIvZCZiVIXdNt/3wZX\ncHLi3iRVFQxzD8ajV48yJ+dVbAAoqxhcbsnOB+CwXW66ViZlo702gWJ2IxMo6mGP\nauPD4ruHa+TsT5aaLnCEowKBgHh2FZ7tg7qwhb6ZR6fQ1h7BsZBvd1T2Xo0OeetK\neY28cBCz2hIyKAl3Fns5NbysM3uOWsMIc3MBw8/fKdpz6gJmk2mhvJqPH3GTGw0S\nnvjBXB/fXtgIyZBWBUN/IEM+k9doiD2hSHGawFJcS2TJMPzksYtF4qJZgjCfDo22\npW/VAoGAC0xpH13KWLKSbtMdgH/MkKq579Mh1tX58nuEbHbIYQOZdGU3qNAbogaz\nwJKADRB6QqIFh8QRlxRyONiakL1lnnUrb9YbsdW5MilC864M1KdvZ3ohKSgb/t0h\n9gc+riSPLgVPpNpc5xlh1HDlpZ5q7Jbv5YAVevcCIvCzOWuBDvY=\n-----END RSA PRIVATE KEY-----" \
      -e TUTUM_PUBLIC_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDBoUxftcclQOrFccphJ9UueEWKFB7oFblWnYAbZWQ6Suag3a/y/Za9enJj0t4afkaJX4F0L6YhYuinN0jh/JKpYirTUl9Z+2lFL6jxENPqlkQ6Awt0Eu8xNTU+7d4Gs5/Vd4Ir55FOMZKu1L202yMuUUrMSxMYV7iNf3fqtNnOD2LalAsbuHAvQGVgIDVaBaFUwDr/PuLGq6Ys7t/5BBlOOhBeQlOBFjyNrzSiTgu+njyJNyaVA/73C8lE4Pnkur5MW7azcfGMwEDoAx4+hpra/SMXWSQWCd0jMU7G+/yko5z8J0npKmQq9HHtCSWbF8+awLAGRBN8/aeWSAklTM9/ root@e8e284d8ce8f" \
      -e SERVER_PORT_22_TCP_PORT=49153 \
      -e SERVER_PORT_22_TCP_ADDR=107.170.48.59 \
      --expose 3306 \
      --name securelink \
      tutum/container-links

    docker run -d --link securelink:DB  -e DB_PASS=admin -p 80:80 tutum/wordpress-stackable:latest
```

Plain links using socat
-----------------------

```
Host A (server side):
    docker run -d -P \
      --link mysql:whatever \
      tutum/container-links

Host B (client side):
    docker run -d \
      -e SERVER_PORT_22_TCP_ADDR=<IP_OF_HOST_A> \
      -e SERVER_PORT_22_TCP_PORT=<PORT_OF_SERVER> \
      -e LINKS_LISTENING_PORT=<PORT_OF_SERVICE> \
      --expose <PORT_OF_SERVICE> \
      --name plainlink \
      tutum/container-links
```

**Examples (wordpress && mysql)**

```
Host A:
    docker run -d --name mysql -e MYSQL_PASS=admin tutum/mysql

    docker run -d -P \
      --link mysql:whatever \
      tutum/container-links

Host B:
    docker run -d \
      -e SERVER_PORT_22_TCP_ADDR=192.168.2.14 \
      -e SERVER_PORT_22_TCP_PORT=49160 \
      -e LINKS_LISTENING_PORT=3306 \
      --expose 3306 \
      --name plainlink \
      tutum/container-links

    docker run -d --link plainlink:db -e DB_PASS=admin -p 802:80 tutum/wordpress-stackable
```
