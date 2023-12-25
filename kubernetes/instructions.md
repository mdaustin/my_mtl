Kubernetes Setup Instructions for My-MTL
This guide will walk you through the steps to deploy your application and its database on Kubernetes using Docker Desktop.

Prerequisites
Docker Desktop with Kubernetes enabled.
kubectl command-line tool installed.
Structure
Your Kubernetes configuration files are located in the kubernetes folder at the root of the application. The files are:

deployment.yaml: Kubernetes deployment for the application.
service.yaml: Kubernetes service for accessing the application.
db-deployment.yaml: Kubernetes deployment for the database.
db-service.yaml: Kubernetes service for accessing the database.
Deployment Steps

1. Start Docker Desktop
   Ensure Docker Desktop is running and Kubernetes is enabled:

Open Docker Desktop.
Go to Settings/Preferences and ensure Kubernetes is checked. 2. Navigate to the Kubernetes Configuration Directory
Open a terminal and navigate to the kubernetes directory in your application's root:

cd path/to/your/app/kubernetes
Replace path/to/your/app with the actual path to your application.

3. Deploy the Database
   Apply the database deployment and service:

kubectl apply -f db-deployment.yaml
kubectl apply -f db-service.yaml
This will create the necessary pods, deployments, and services for your database.

4. Deploy the Application
   Apply the application deployment and service:

kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
This will create the necessary pods, deployments, and services for your application.

5. Verify the Deployments
   Check that the deployments are running:

kubectl get deployments
You should see both your application and database listed.

6. Verify the Services
   Ensure the services are correctly set up:

kubectl get services
You should see services for both your application and database.

7. Access the Application
   For applications exposed via NodePort, find the NodePort assigned to your service and access your application at http://localhost:<NodePort>.
   For LoadBalancer type (Docker Desktop), you can generally access your application directly at http://localhost.
8. Monitoring and Logs
   To monitor your application and view logs, use the following kubectl commands:

View logs: kubectl logs <pod-name>
Describe pods: kubectl describe pod <pod-name> 9. Cleanup
To delete the deployed resources:

kubectl delete -f deployment.yaml
kubectl delete -f service.yaml
kubectl delete -f db-deployment.yaml
kubectl delete -f db-service.yaml

Additional Resources
Kubernetes Documentation
Docker Desktop Kubernetes
