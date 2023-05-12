# Publish the application
dotnet publish -c Release --framework net7.0 

# Build container
docker build -t throughput-test-image -f Dockerfile .

# Single run locally
docker run -it --rm throughput-test-image -C "Endpoint=sb://sb-eldert-pg-performance-test-1-partition.servicebus.windows.net/;SharedAccessKeyName=RootManageSharedAccessKey;SharedAccessKey=puJ7+PBuMd7MGCP7dH9f8ED5kkTixmyqW+ASbAGa/sE=" -S queue-defaults

# Switch Azure subscription to Azure Messaging PM Playground
az account set --subscription "Azure Messaging PM Playground"

# Login to ACR
az acr login --name acreldertpgperformancetest 

# Tag image for upload to ACR
docker tag throughput-test-image acreldertpgperformancetest.azurecr.io/throughput-test-image:dev    

# Push image to ACR
docker push acreldertpgperformancetest.azurecr.io/throughput-test-image:dev

# Show container in ACR
az acr repository list --name acreldertpgperformancetest --output table