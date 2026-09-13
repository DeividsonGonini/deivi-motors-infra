# deivi-motors-infra
# 1 - Criar  a Infraestrutura
Executar o Apply na raiz para criar a infraestrutura basica
Observação: ao recriar a infra, lembre-se de:
alterar o nome do secret
atualizar os seg


Sequencia:
1 - Criar a infra terraform para salvar os arquivos .tf da pasta s3-backend
2 - Criar a infra terraform com os recursos base da pasta terraform-cluster
3 - Criar a infra Kubernetes da pasta K8s
4 - Criar a infra terraform da pasta gateway (repositório do Gateway)
5 - Criar a infra do banco de dados(repositório do Gateway)
6 - Criar os services Kubernetes da pasta K8s (repositório do Service)


```bash
terraform apply --auto-approve
```

###  Atualiza o kubeconfig
Caso falhe siga o comando abaixo para Recriar o kubeconfig do cluster
```bash
aws eks update-kubeconfig \
--region us-east-1 \
--name eks-deivi-motors
```


# 3 - executar os manifestos da pasta /k8s
### 3.a - Aplicar os manifestos Kubernets
O comando abaixo ira executar o kustomization.yaml

```bash
kubectl apply -k .
```

###  Atualiza o kubeconfig
Caso falhe siga o comando abaixo para Recriar o kubeconfig do cluster
```bash
aws eks update-kubeconfig \
--region us-east-1 \
--name eks-deivi-motors
```

### 3.b - Conferir se a URL mudou
```bash
kubectl config view --minify | grep server
```

### 3.c - Testar conexão
```bash
kubectl get nodes
```


# 3 Consultas e validações

Ver services
```bash
kubectl get svc -n deivi-motors-k8s
```

Ver ingress
```bash
kubectl get ingress -n deivi-motors-k8s
```

Ver Pods
```bash
kubectl get pods -n deivi-motors-k8s
```

Log do Pod
```bash
kubectl logs deivi-motors-67d69b57b6-p9jkw -n deivi-motors-k8s
```

```bash
kubectl logs webhook-5cfb44d667-r9v7v  -n deivi-motors-k8s
```

Olhando os Deployments
```bash
kubectl get deployment -n deivi-motors-k8s
```

Logs do Deployment
```bash
kubectl describe deployment deivi-motors -n deivi-motors-k8s
```

Logs do Replica Set para conferir erro de infra do deployment
```bash
kubectl describe rs deivi-motors-65855d4489-6crj6 -n deivi-motors-k8s
```


Validar IRSA (role correta)
```bash
kubectl exec -it deivi-motors-service-xxxxx -n deivi-motors-k8s -- aws sts get-caller-identity
```


Descrever o deployment
```bash
 kubectl describe pod deivi-motors-65855d4489-6crj6 -n deivi-motors-k8s
```

Reiniciar o Deployment que gerou o pod via 'kubectl rollout restart'
```bash
kubectl rollout restart deployment deivi-motors -n deivi-motors-k8s
```


----------------------------

# Deletar a Infraestrutura
Executar o Apply na raiz para criar a infraestrutura basica
Sequencia Inversa da criação:
6 - Destruir os services Kubernetes da pasta K8s (repositório do Service)
5 - Destruir a infra do banco de dados(repositório do banco de dados)
4 - Destruir a infra terraform da pasta gateway (repositório do Gateway)
3 - Destruir a infra Kubernetes da pasta K8s
2 - Destruir a infra terraform com os recursos base da pasta terraform-cluster
1 - Destruir a infra terraform para salvar os arquivos .tf da pasta s3-backend

Sequencia:

### 1 - Destruir a infra terraform da pasta gateway
```bash
terraform destroy --auto-approve
```

### 2 - Destruir a infra Kubernetes da pasta K8s
Seguir a sequencia abaixo

Deletar a ingress-alb criada com Manifestos k8s
```bash
kubectl delete -f ingress-alb.yaml
```
Deletar a externalsecret criada com Manifestos k8s
```bash
kubectl delete -f externalsecret.yaml
```
Deletar a namespace criada com Manifestos k8s
```bash
kubectl delete -f namespace.yaml
```
Deleta a infra criada pelo kustomization com Manifestos
```bash
kubectl delete -k .
```

### 3 - Destruir a infra terraform da pasta terraform-cluster
```bash
terraform destroy --auto-approve
```

----------------------------

### Detalhes do externalSecret
```bash
kubectl describe externalsecret deivi-motors-db -n deivi-motors-k8s
```

# Recupera sessao Token AWS
Voce precisará para atualizar as credenciais localizadas em seu-usuario/.aws
```bash
aws sts get-session-token
```


# Obter Secrets Cluster
```bash
kubectl get secret deivi-motors-db-secret -n deivi-motors-k8s -o yaml
```

# Decodificar
```bash
echo "VALOR_BASE64" | base64 -d
```