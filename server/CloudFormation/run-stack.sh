#!/bin/bash 
set -eu
# Serviceスタックの削除
aws cloudformation delete-stack --stack-name ServiceStack
aws cloudformation wait stack-delete-complete --stack-name ServiceStack

# VPCスタックの削除
aws cloudformation delete-stack --stack-name VPCStack
aws cloudformation wait stack-delete-complete --stack-name VPCStack

# TaskDefnitionスタックの削除
aws cloudformation delete-stack --stack-name TaskDefinitionStack
aws cloudformation wait stack-delete-complete --stack-name TaskDefinitionStack

# Clusterスタックの削除
aws cloudformation delete-stack --stack-name ClusterStack
aws cloudformation wait stack-delete-complete --stack-name ClusterStack

# Route53スタックの削除 TODO: Fargate IPの固定化
# aws cloudformation delete-stack --stack-name Route53Stack
# aws cloudformation wait stack-delete-complete --stack-name Route53Stack

# VPCスタックテンプレートの検証
aws cloudformation validate-template --template-body file://"$(pwd)"/VPC.yml

# TaskDefnitionスタックテンプレートの検証
aws cloudformation validate-template --template-body file://"$(pwd)"/ElasticContainerService/TaskDefinition.yml

# Clusterスタックテンプレートの検証
aws cloudformation validate-template --template-body file://"$(pwd)"/ElasticContainerService/Cluster.yml

# Serviceスタックの検証
aws cloudformation validate-template --template-body file://"$(pwd)"/ElasticContainerService/Service.yml

# Route53スタックテンプレートの検証 TODO: Fargate IPの固定化
# aws cloudformation validate-template --template-body file://"$(pwd)"/Route53.yml

# VPCスタックの作成
aws cloudformation create-stack --stack-name VPCStack --template-body file://"$(pwd)"/VPC.yml
aws cloudformation wait stack-create-complete --stack-name VPCStack

# TaskDefnitionスタックの作成
# capabilitiesオプション参考: https://docs.aws.amazon.com/ja_jp/AWSCloudFormation/latest/UserGuide/using-iam-template.html#using-iam-capabilities
aws cloudformation create-stack --stack-name TaskDefinitionStack --template-body file://"$(pwd)"/ElasticContainerService/TaskDefinition.yml --capabilities CAPABILITY_NAMED_IAM
aws cloudformation wait stack-create-complete --stack-name TaskDefinitionStack

# Clusterスタックの作成
aws cloudformation create-stack --stack-name ClusterStack --template-body file://"$(pwd)"/ElasticContainerService/Cluster.yml
aws cloudformation wait stack-create-complete --stack-name ClusterStack

# Serviceスタックの作成
aws cloudformation create-stack --stack-name ServiceStack --template-body file://"$(pwd)"/ElasticContainerService/Service.yml
aws cloudformation wait stack-create-complete --stack-name ServiceStack

# Route53スタックの作成 TODO: Fargate IPの固定化
# aws cloudformation create-stack --stack-name Route53Stack --template-body file://"$(pwd)"/Route53.yml