
#!/bin/bash

APP_NAME="job-posting-service"
APP_PORT=3000
K8S_NAMESPACE=default
IMAGE_NAME="job-posting-service"

# Step 1: Use Minikube's Docker daemon
eval $(minikube docker-env)

echo "✅ Building Docker image..."
docker build -t $IMAGE_NAME .

# Step 2: Create K8s YAMLs
echo "✅ Generating Kubernetes manifests..."

cat <<EOF > configmap.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: ${APP_NAME}-config
data:
  NODE_ENV: production
  PORT: "${APP_PORT}"
EOF

cat <<EOF > deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ${APP_NAME}-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: ${APP_NAME}
  template:
    metadata:
      labels:
        app: ${APP_NAME}
    spec:
      containers:
        - name: ${APP_NAME}-container
          image: ${IMAGE_NAME}
          ports:
            - containerPort: ${APP_PORT}
          envFrom:
            - configMapRef:
                name: ${APP_NAME}-config
EOF

cat <<EOF > service.yaml
apiVersion: v1
kind: Service
metadata:
  name: ${APP_NAME}
spec:
  selector:
    app: ${APP_NAME}
  ports:
    - protocol: TCP
      port: 80
      targetPort: ${APP_PORT}
  type: ClusterIP
EOF

cat <<EOF > ingress.yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: ${APP_NAME}-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
    - host: job.sarathraj.local
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: ${APP_NAME}
                port:
                  number: 80
EOF

# Step 3: Apply manifests
echo "✅ Applying Kubernetes manifests..."
kubectl apply -f configmap.yaml
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl apply -f ingress.yaml

# Step 4: Update /etc/hosts
MINIKUBE_IP=$(minikube ip)
HOST_ENTRY="$MINIKUBE_IP job.sarathraj.local"
echo "✅ Add this to your /etc/hosts file (run with sudo):"
echo "$HOST_ENTRY"

# Optional: Open in browser
echo "✅ Once added to /etc/hosts, visit: http://job.sarathraj.local"
