#!/usr/bin/env bash

cd $(dirname $0)

for FILE in package/docker/* 
do
   IMAGE=$(basename $FILE)
   
   cp $FILE ./Dockerfile

   echo "
   
   # Build image $IMAGE 
   
   "

   sudo docker build . | tee /tmp/docker.tmp
   ID=$(grep "Successfully built" /tmp/docker.tmp | awk '{print $3}') 

   if [ -z "$ID" ]
   then
      echo "Something went wrong and no ID was found after building image"
      exit 1
   fi

   mkdir -p "../build/package/installationTest/"

   echo "
   
   # Run installation tests in $IMAGE 
   
   "
   sudo docker run -i -t -v /vagrant:/data:rw $ID \
	   /data/test/package/installationTest.bats | tee "../build/package/installationTest/$IMAGE" 

   rm ./Dockerfile

done

