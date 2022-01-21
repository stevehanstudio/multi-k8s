docker build -t stevehanphoto/multi-client:latest -t stevehanphoto/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t stevehanphoto/multi-server:latest -t stevehanphoto/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t stevehanphoto/multi-worker:latest -t stevehanphoto/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push stevehanphoto/multi-client:latest
docker push stevehanphoto/multi-server:latest
docker push stevehanphoto/multi-worker:latest

docker push stevehanphoto/multi-client:$SHA
docker push stevehanphoto/multi-server:$SHA
docker push stevehanphoto/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=stevehanphoto/multi-server:$SHA
kubectl set image deployments/client-deployment client=stevehanphoto/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=stevehanphoto/multi-worker:$SHA

