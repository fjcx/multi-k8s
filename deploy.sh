docker build -t fjoconnor/multi-client:latest -t fjoconnor/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t fjoconnor/multi-server:latest -t fjoconnor/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t fjoconnor/multi-worker:latest -t fjoconnor/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push fjoconnor/multi-client:latest
docker push fjoconnor/multi-server:latest
docker push fjoconnor/multi-worker:latest

docker push fjoconnor/multi-client:$SHA
docker push fjoconnor/multi-server:$SHA
docker push fjoconnor/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=fjoconnor/multi-server:$SHA
kubectl set image deployments/client-deployment client=fjoconnor/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=fjoconnor/multi-worker:$SHA