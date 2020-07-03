docker build -t lijialiang93/multi-client:latest -t lijialiang93/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t lijialiang93/multi-server:latest -t lijialiang93/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t lijialiang93/multi-worker:latest -t lijialiang93/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push lijialiang93/multi-client:latest
docker push lijialiang93/multi-server:latest
docker push lijialiang93/multi-worker:latest

docker push lijialiang93/multi-client:$SHA
docker push lijialiang93/multi-server:$SHA
docker push lijialiang93/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=lijialiang93/multi-server:$SHA
kubectl set image deployments/client-deployment client=lijialiang93/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=lijialiang93/multi-worker:$SHA
