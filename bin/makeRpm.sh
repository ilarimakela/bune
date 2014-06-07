#!/usr/bin/env bash

TAG='bune/rpmbuilder'

cd $(dirname $0)

cat > ./Dockerfile <<EOF
FROM centos:latest

# Extend yum cache times to 24 hours 
RUN echo "metadata_expire=86400" >> /etc/yum.conf
RUN echo "mirrorlist_expire=86400" >> /etc/yum.conf

RUN yum -y install rpmdevtools yum-utils
RUN rpmdev-setuptree

EOF

echo "
       
      # Build image $IMAGE 
       
"

sudo docker build . | tee /tmp/docker.tmp
rm -f ./Dockerfile

ID=$(grep "Successfully built" /tmp/docker.tmp | awk '{print $3}') 

if [ -z "$ID" ]
then
   echo "Something went wrong and no ID was found after building image"
   exit 1
fi

echo "

       # Create RPM in $IMAGE 

"
sudo docker run -i -t -v /vagrant:/data:rw $ID \
    rpmbuild -bb /data/etc/rpm.spec

