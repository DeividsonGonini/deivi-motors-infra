# Deivi-Motors-infra

Infraestrutura do projeto de processamento de vídeos na AWS, com provisionamento em Terraform e deploy dos serviços no EKS via manifests Kubernetes.

## Estrutura

- `s3-backend/`: recursos S3 usados no projeto, incluindo bucket de processamento de vídeos.
- `terraform-cluster/`: infraestrutura base na AWS, como VPC, subnets, EKS, ALB Controller, External Secrets, Cognito, SQS, SES e Secrets Manager.
- `k8s/`: manifests dos serviços `deivi-motors` e `webhook`, além de service account, services e integrações com secrets.

## Ordem sugerida de execução

1. Aplicar o Terraform de `s3-backend/`.
2. Aplicar o Terraform de `terraform-cluster/`.
3. Atualizar o `kubeconfig` do cluster EKS.
4. Aplicar os manifests de `k8s/` com Kustomize.

## Comandos básicos

```bash
cd s3-backend
terraform apply

cd ../terraform-cluster
terraform apply

aws eks update-kubeconfig --region us-east-1 --name eks-deivi-motors

cd ../k8s
kubectl apply -k .
```

## Observações

- Os manifests apontam para imagens no ECR da região `us-east-1`.
- Os deployments consomem o secret `deivi-motors-db-secret` para credenciais do MongoDB.
- `namespace.yaml`, `ingress-alb.yaml` e `externalsecret.yaml` estão comentados no `kustomization.yaml` para alguns fluxos de deploy.
