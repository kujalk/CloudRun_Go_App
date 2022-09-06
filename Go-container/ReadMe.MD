## Steps for GCP Cloud Run

1. gcloud auth login

2. gcloud projects list

3. gcloud config set project adept-vigil-357801

4. gcloud builds submit --tag gcr.io/adept-vigil-357801/my-go-app .

## Steps for local build

1. go mod init web_server

2. docker build -t my-go-app .

3. docker run -e region="local" -p 8080:8080 -d my-go-app

## Additional Notes

To stop all running containers

- docker rm $(docker ps -a -q)

To remove all images

- docker rmi $(docker images -q) -f
