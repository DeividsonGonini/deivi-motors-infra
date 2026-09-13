# Deivi-Motors-infra

Infraestrutura do projeto de processamento de vídeos na AWS, com provisionamento em Terraform e deploy dos serviços no EKS via manifests Kubernetes.

## Estrutura

- `s3-backend/`: recurso S3 utilizado para guardar os terraform.tfstate no projeto.
- `terraform-cluster/`: infraestrutura base na AWS, como VPC, subnets, EKS, ALB Controller, Cognito e Secrets Manager.
- `k8s/`: manifestos do kubernets, service account, external secrets, ingress-alb, namespace e integrações com secret manager da AWS.

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
- `namespace.yaml`, `ingress-alb.yaml` e `externalsecret.yaml` estão comentados no `kustomization.yaml` para o fluxo de deploy via GitAction, **descomente** para deploy local.
- O `Secret Manager` demora para ser excluído totalmente da AWS, sempre que for fazer um novo deploy completo, a sugestão é alterar o nome.