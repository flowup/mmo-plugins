#!/bin/sh

for service in "$@"
do
    echo "Generating swagger definition for service $service"
    cd /source/$service/protobuf
    mkdir /tmp/$service
    protoc -I/usr/local/include -I. -I/source -I/googleapis -I${GOPATH}/src --swagger_out=logtostderr=true:/tmp/$service proto.proto
done

echo "Merging swagger files"
node /scripts/merger.js $@
json2yaml /tmp/swagger.json > /source/swagger.yaml