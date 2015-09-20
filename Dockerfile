FROM fedora:latest
MAINTAINER Arun Neelicattu <arun.neelicattu@gmail.com>

RUN dnf -y upgrade

# install base requirements
RUN dnf -y install golang git hg

# prepare gopath
ENV GOPATH /go
ENV PATH /go/bin:${PATH}
RUN mkdir -p ${GOPATH}

ENV PACKAGE github.com/CiscoCloud/marathon-consul
ENV VERSION 0.1
ENV GO_BUILD_TAGS netgo
ENV CGO_ENABLED 1

RUN go get ${PACKAGE}

WORKDIR ${GOPATH}/src/${PACKAGE}
RUN git checkout -b ${VERSION} ${VERSION}

ENV BINARY ./bin/marathon-consul
RUN mkdir bin
RUN go build \
        -tags "${GO_BUILD_TAGS}" \
        -ldflags "-s -w -X ${PACKAGE}/version.Version ${VERSION}" \
        -v -a \
        -installsuffix cgo \
        -o ${BINARY}

COPY ./loadbins /usr/bin/loadbins

ENV ROOTFS=./rootfs
ENV DEST ${ROOTFS}

RUN mkdir -p ${ROOTFS}/usr/bin/ ${ROOTFS}/etc/ssl/certs/
RUN loadbins ${BINARY}
RUN mv ${BINARY} ${ROOTFS}/usr/bin/$(basename ${BINARY})
COPY Dockerfile.final ./Dockerfile

CMD docker build -t alectolytic/marathon-consul ${PWD}
