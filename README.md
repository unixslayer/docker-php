Yet another docker images for PHP
===

Supported versions:
---

Every version that has [Security updates support](http://php.net/supported-versions.php).

- PHP:7.1-fpm
- PHP:7.1-cli
- PHP:7.2-fpm
- PHP:7.2-cli
- ...more to come

Build, Benchmark & Push
---

Images are build based on general [Dockerfile]('./Dockerfile'). Build can be done by calling [build.sh]('./build.sh') file:

`./build.sh`

Benchmark tool allows you to test performance of images you have created. Images can be tested by calling [build.sh]('./build.sh') file:

`./bench.sh`

You can always test each image separately:

`docker run --rm -it -v $(pwd)/bench:/var/www/html unixslayer/php:7.1-fpm php bench.php`
