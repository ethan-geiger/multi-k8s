docker build -t ejgeiger/multi-client:latest -t ejgeiger/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ejgeiger/multi-server:latest -t ejgeiger/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ejgeiger/multi-worker:latest -t ejgeiger/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ejgeiger/multi-client:latest
docker push ejgeiger/multi-server:latest
docker push ejgeiger/multi-worker:latest

docker push ejgeiger/multi-client:$SHA
docker push ejgeiger/multi-server:$SHA
docker push ejgeiger/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ejgeiger/multi-server:$SHA
kubectl set image deployments/client-deployment client=ejgeiger/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ejgeiger/multi-worker:$SHA
