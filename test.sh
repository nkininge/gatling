#!/bin/bash
export IMAGE_NAME="registry.eng.hortonworks.com/hortonworks"
export SANDBOX_IMAGE_REPO="docker-sandbox.infra.cloudera.com"
export OKD_IMAGE_REPO="docker-test.okd-us-west.kc-dev.cloudera.com"
export IMAGE_ARR=(base-centos7:0.1.0.0-82 base-amazonlinux2:0.1.0.0-92 base-ubuntu14:0.1.0.0-92 base-sles12sp1:0.1.0.0-103 base-debian9.3:0.1.0.0-92)
for (( i = 0; i < 5; i++ ))
do
 echo "Pulling image "$IMAGE_NAME"/"${IMAGE_ARR[i]}" on local"
 docker pull "$IMAGE_NAME"/"${IMAGE_ARR[i]}"
 docker tag "$IMAGE_NAME"/"${IMAGE_ARR[i]}" "$SANDBOX_IMAGE_REPO"/"${IMAGE_ARR[i]}"
 docker tag "$IMAGE_NAME"/"${IMAGE_ARR[i]}" "$OKD_IMAGE_REPO"/"${IMAGE_ARR[i]}"
done
