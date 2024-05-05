# Docker Doxygen

| software | location               | version |
|----------|------------------------|---------|
| Doxygen  | /usr/local/bin/doxygen | 1.10.0  |
| GraphViz | /usr/bin/dot           | 2.40.1  |


# How to Use

## Build with specific version of Doxygen

The dockerfile downloads from the [doxygen github release page](https://github.com/doxygen/doxygen/releases),
so please check there for releases other than 1.10.0.

In order to build with the 1.9.8 release of doxygen run the sample code below

```sh
docker build --build-arg DOXYGEN_VERSION=1.9.8 .
```

## use volume mount & Configuration File

Configuration file is under $(pwd). Filename is "Doxygen"  

```sh
docker run --rm -v $(pwd)/Doxygen:/tmp/Doxygen tsgkadot/docker-doxygen doxygen /tmp/Doxygen
```


## use with gitlab-ci

Configuration file is under $(pwd). Filename is "Doxygen"  

Repository has some resources(source and Doxygen files).
And doxygen(build) and publish(gitlab pages).

`.gitlab-ci.yml` sample is below.

```yml
image: omegarelay/doxygen:1.10.0
pages:
  stage: deploy
  script:
  - doxygen Doxyfile > /dev/nul
  - mv build/html public
  artifacts:
    paths:
    - public
  only:
  - tags
  - triggers
  - web
  tags:
  - docker
```

# Other

you can use `dot(graphbiz)`. 

Doxygen file sample is below.

```ini
# If you set the HAVE_DOT tag to YES then doxygen will assume the dot tool is
# available from the path. This tool is part of Graphviz (see:
# http://www.graphviz.org/), a graph visualization toolkit from AT&T and Lucent
# Bell Labs. The other options in this section have no effect if this option is
# set to NO
# The default value is: NO.

HAVE_DOT               = YES

# The DOT_PATH tag can be used to specify the path where the dot tool can be
# found. If left blank, it is assumed the dot tool can be found in the path.
# This tag requires that the tag HAVE_DOT is set to YES.

DOT_PATH               = /usr/bin/dot
```
