# EKS Deployment with Terraform

## Architecture

This project provisions an Amazon EKS (Elastic Kubernetes Service) cluster using Terraform, enabling the deployment of containerized applications in a managed Kubernetes environment. The architecture consists of:

- **VPC (Virtual Private Cloud)**: A dedicated network for the EKS cluster, with public and private subnets for secure communication.
- **EKS Cluster**: The central component that manages the Kubernetes control plane.
- **Node Groups**: EC2 instances that serve as worker nodes in the EKS cluster, where the containerized applications run.
- **IAM Roles and Policies**: Fine-grained access control for the EKS cluster and worker nodes, allowing them to interact with AWS services securely.
- **CloudWatch Monitoring**: Configuration for logging and monitoring the EKS cluster's performance and resource utilization, with alarm notifications sent via SNS (Simple Notification Service).
- **VPC Peering**: A route setup for connectivity between the EKS VPC and an on-premises environment, allowing seamless communication between services running in both locations.

## How to Deploy the Stack

1. **Prerequisites**:
   - An AWS account.
   - Terraform installed on your local machine.
   - AWS CLI configured with appropriate IAM permissions to create the necessary resources.

2. **Clone the Repository**:
   ```bash
   git clone https://github.com/yourusername/turion-space.git
   cd turion-space/eks-modules/eks
   ```

3. **Set Up Variables**:
   - Edit the `variables.tf` file to set your desired parameters, such as the cluster name, region, and node instance types.

4. **Push your Changes to github and trigger the CI/CD pipeline to deploy (init, plan, apply)**

5. **Access the EKS Cluster**:
   After the deployment completes, configure your `kubectl` context to point to the new EKS cluster:
   ```bash
   aws eks --region <region> update-kubeconfig --name <cluster_name>
   ```

## Design Decisions

1. **IAM Roles and Policies**: 
   - IAM roles are defined for the EKS cluster, worker nodes, and additional services (e.g., CloudWatch, EBS) to adhere to the principle of least privilege.
   - Policies are attached to roles based on the required actions for each component, ensuring they have only the permissions needed for their operation.

2. **Monitoring and Alerts**:
   - Integrated CloudWatch for logging and metrics to monitor the health of the EKS cluster and its workloads. Alarms are configured for CPU utilization to proactively manage resource allocation.

3. **VPC Peering**:
   - Implemented a VPC peering connection to allow secure communication between the EKS cluster and an on-premises environment, facilitating hybrid cloud deployments.

## Set up Monitoring for EKS Cluster with Grafana and Prometheus

Monitoring your EKS cluster is crucial for maintaining performance and availability. This outlines the steps to set up Prometheus for monitoring and Grafana for visualization.

1. **Namespace for Prometheus**
```bash
kubectl create namespace prometheus
```
2. **Prometheus Helm chart Repository**
```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
```
3. **Deploy Prometheus via Helm**
```bash
helm upgrade -i prometheus prometheus-community/prometheus --namespace prometheus --set alertmanager.persistence.storageClass="gp2" --set server.persistentVolume.storageClass="gp2"
```
4. **Setup EBS CSI Driver (IAM OIDC identity provider)**
```bash
eksctl utils associate-iam-oidc-provider --cluster $cluster_name --approve
```
5. **IAM Role (EBS CSI Plugin)**
```bash
eksctl create iamserviceaccount \
    --name ebs-csi-controller-sa \
    --namespace kube-system \
    --cluster my-cluster \
    --role-name AmazonEKS_EBS_CSI_DriverRole \
    --role-only \
    --attach-policy-arn arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy \
    --approve
```
6. **Install EBS CSI driver**
```bash
eksctl create addon --name aws-ebs-csi-driver --cluster dev-eks-cluster--service-account-role-arn arn:aws:iam::111122223333:role/AmazonEKS_EBS_CSI_DriverRole --force
```
- Replace AWS account number with your actual your AWS account number.

7. **Update EBS CSI DRIVER if needed**
```bash
eksctl update addon --name aws-ebs-csi-driver --version v1.11.4-eksbuild.1 --cluster dev-eks-cluster --service-account-role-arn arn:aws:iam::111122223333:role/AmazonEKS_EBS_CSI_DriverRole --force
  ```
8. **Expose Prometheus via NodePort**

- Create Prometheus service YAML file
```bash
touch prometheus-service.yaml

vim prometheus-service.yaml
```
```yaml
apiVersion: v1
kind: Service
metadata:
  name: prometheus-nodeport
  namespace: prometheus
spec:
  selector:
    app: prometheus
  ports:
    - name: web
      port: 9090
      targetPort: 9090
      protocol: TCP
      nodePort: 30000  # You can choose any available port on your nodes
  type: NodePort
```
9. **Apply the service configuration**
```bash
kubectl apply -f prometheus-service.yaml
```

10. **Grafana Helm chart Repository**
```bash
helm repo add grafana https://grafana.github.io/helm-charts
```
11. **Namespace for Grafana**
```bash
kubectl create namespace grafana
```
12. **Create Grafana configuration file**
```bash 
touch grafana.yaml 

vim grafana.yaml
```
```yaml
datasources:
  datasources.yaml:
    apiVersion: 1
    datasources:
    - name: Prometheus
      type: prometheus
      url: http://prometheus-server.prometheus.svc.cluster.local
      access: proxy
      isDefault: true
```
13. **Deploy Grafana via Helm**
```bash
helm install grafana grafana/grafana \
    --namespace grafana \
    --set persistence.storageClassName="gp2" \
    --set persistence.enabled=true \
    --set adminPassword='EKS!sAWSome' \
    --values /home/ec2-user/grafana.yaml \
    --set service.type=NodePort
```

14. **Login to Grafana**
- Username: admin
- Password: The admin password you set during the Helm installation.

15. **Create new dashboard**
- Click "Create" → "Import" on the Grafana console.
- Import a pre-built Kubernetes dashboard:

On the "Find and Import Dashboards for Common Applications" section, input the dashboard ID 17119 and click "Load".

16. **Configure the data source:**
- Select Prometheus as the data source for the dashboard.
- Click "Import" to load the dashboard.

17. **View dashboard**


## Future Integration with On-Premises Environment

To integrate this setup with a real on-premises environment in the future:

1. **VPC Peering**:
   - Establish a VPC peering connection between the AWS VPC and the on-premises network to allow for seamless communication. Ensure routing is properly configured to direct traffic between the two environments.

2. **Network Security**:
   - Set up security groups and network ACLs to control inbound and outbound traffic to/from the on-premises environment, ensuring compliance with security policies.

3. **Service Discovery**:
   - Implement service discovery solutions (like AWS Cloud Map) to allow services running in EKS to find and connect to on-premises services easily.

4. **Data Management**:
   - Consider hybrid data management strategies, such as using AWS Direct Connect for secure and reliable data transfer between AWS and on-premises resources.

5. **Monitoring**:
   - Extend the existing CloudWatch setup to include on-premises resources, providing a unified view of the entire infrastructure's performance.

By following these guidelines, you can effectively manage and scale your EKS deployment while maintaining the flexibility to integrate with on-premises systems.
