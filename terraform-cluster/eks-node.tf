resource "aws_eks_node_group" "node_group" {
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = "nodeg-${var.projectName}"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids = [
    aws_subnet.deivi-motors-subnet-public1.id,
    aws_subnet.deivi-motors-subnet-public2.id
  ]
  disk_size      = 50
  instance_types = [var.instance_type]


  scaling_config {
    desired_size = 3
    max_size     = 6 # 2 Deivi-Motors / 1 Webhook
    min_size     = 1
  }

  # Em caso de atualização ele fará a atualização de no maximo 1 node,
  # assim se tivermos temos no mínimo 2 por exemplo um sempre estará funcionando enquanto o outro atualiza
  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_eks_cluster.cluster
  ]
}