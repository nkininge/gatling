
#!/bin/bash
main(){
    if [[ $# == 0 ]]; then
        echo "Need action argument"; exit 1
    fi
    if [ $6 -gt 5 ] || [ $6 -lt 1 ]; then
       echo "Concurrency value shoud be in range 1-5"; exit 1
    fi
    POSITIONAL=()
    while [[ $# -gt 0 ]]
    do
    key="$1"

    case $key in
        --docker_sandbox_pass)
        DOCKER_SANDBOX_PASS="$2"
        shift # past argument
        shift # past value
        ;;
        --docker_private_pass)
        DOCKER_PRIVATE_PASS="$2"
        shift # past argument
        shift # past value
        ;;
        --concurrency)
        CONCURRENCY="$2"
        shift # past argument
        shift # past value
        ;;
        --env)
        ENV="$2"
        shift # past argument
        ;;
        *)    # unknown option
        POSITIONAL+=("$1") # save it in an array for later
        shift # past argument
        ;;
    esac
    done
    set -- "${POSITIONAL[@]}"
    echo "Number of images pushed and pulled concurrently    = ${CONCURRENCY}"
    echo "Environment in which loadtest is done = ${ENV}"
    setenvvars $ENV
    get_image $CONCURRENCY
    loadtest_push "$DOCKER_SANDBOX_PASS" "$DOCKER_PRIVATE_PASS" "$CONCURRENCY"
    loadtest_pull "$DOCKER_SANDBOX_PASS" "$DOCKER_PRIVATE_PASS" "$CONCURRENCY"
}


setenvvars(){
ENV=$1
export IMAGE_NAME="registry.eng.hortonworks.com/hortonworks"
export SANDBOX_IMAGE_REPO="docker-sandbox.infra.cloudera.com"
export OKD_IMAGE_REPO="docker-test.okd-us-west.kc-$ENV.cloudera.com"
export TIMESTAMP=`date +%Y%m%d_%H%M%S`
}
export IMAGE_ARR=(base-centos7:0.1.0.0-82 base-amazonlinux2:0.1.0.0-92 base-ubuntu14:0.1.0.0-92 base-sles12sp1:0.1.0.0-103 base-debian9.3:0.1.0.0-92)
get_image()
{
conconcurrency=$1
for (( i = 0; i < "$conconcurrency"; i++ ))
do
 echo "Pulling image "$IMAGE_NAME"/"${IMAGE_ARR[i]}" on local"
 docker pull "$IMAGE_NAME"/"${IMAGE_ARR[i]}"
 docker tag "$IMAGE_NAME"/"${IMAGE_ARR[i]}" "$SANDBOX_IMAGE_REPO"/"$TIMESTAMP":"$i"
 docker tag "$IMAGE_NAME"/"${IMAGE_ARR[i]}" "$OKD_IMAGE_REPO"/"$TIMESTAMP":"$i"
done
}


loadtest_push(){
  docker_sandbox_pass=$1
  docker_private_pass=$2
  docker login $SANDBOX_IMAGE_REPO -u docker-sandbox-rw -p $1
  SECONDS=0
  rm -f loadtest_sandbox.txt loadtest_private.txt
  for t  in  $(docker images --format "{{.Repository}}:{{.Tag}}" | grep "$SANDBOX_IMAGE_REPO")
   do
    echo $t >> loadtest_sandbox.txt
    echo "Size of docker image $t is $(docker images $t --format "{{.Size}}: {{.Repository}}:{{.Tag}}")"       
    time docker push "$t" &
   done
   wait
  echo "Total time taken to push by $SANDBOX_IMAGE_REPO is $SECONDS seconds"
 SECONDS=0
  docker login $OKD_IMAGE_REPO -u docker-private-rw -p $2
  for t in $(docker images --format "{{.Repository}}:{{.Tag}}" | grep "$OKD_IMAGE_REPO")
   do
    echo $t >>loadtest_private.txt
    echo "Size of docker image $t is $(docker images $t --format "{{.Size}}: {{.Repository}}:{{.Tag}}")"
    time docker push "$t" &
   done
  wait
  
  echo "Total time taken to push by $OKD_IMAGE_REPO is $SECONDS seconds"
}

loadtest_pull(){
  echo "Deleting sandbox and docker-private images"
  cleanup
  
  docker login $SANDBOX_IMAGE_REPO -u docker-sandbox-rw -p $1
  echo "Pulling image from sandbox repository"
  SECONDS=0
  while IFS="" read -a  line; do
  time docker pull "$line" &
  done < loadtest_sandbox.txt
  wait
  echo  "Total time taken to pull by $SANDBOX_IMAGE_REPO is $SECONDS seconds"
 
  cleanup
  echo "Pulling image from docker-private repository"
  docker login $OKD_IMAGE_REPO -u docker-private-rw -p $2
  SECONDS=0
  while IFS="" read -a  line; do
  time docker pull "$line" &
  done < loadtest_private.txt
  wait
  echo "Total time taken to pull by $OKD_IMAGE_REPO is $SECONDS seconds"
}

cleanup(){
  docker images|awk '{print $3}'|xargs docker image rmi -f {}
  docker images|awk '{print $3}'|xargs docker image rmi -f {}
}
main "$@"
