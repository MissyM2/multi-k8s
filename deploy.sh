docker build -t missym2/multi-client:latest -t missym2/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t missym2/multi-server:latest -t missym2/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t missym2/multi-worker:latest -t missym2/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push missym2/multi-client:latest
docker push missym2/multi-server:latest
docker push missym2/multi-worker:latest

docker push missym2/multi-client:$SHA
docker push missym2/multi-server:$SHA
docker push missym2/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=missym2/multi-server:$SHA
kubectl set image deployments/client-deployment client=missym2/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=missym2/multi-worker:$SHA