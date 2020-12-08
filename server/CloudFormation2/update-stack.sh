#!/bin/bash 
set -eu
# VPCスタックテンプレートの検証
aws cloudformation validate-template --template-body file://"$(pwd)"/Stack/VPC.yml

# TaskDefnitionスタックテンプレートの検証
aws cloudformation validate-template --template-body file://"$(pwd)"/Stack/ElasticContainerService/TaskDefinition.yml

# Clusterスタックテンプレートの検証
aws cloudformation validate-template --template-body file://"$(pwd)"/Stack/ElasticContainerService/Cluster.yml

# Serviceスタックの検証
aws cloudformation validate-template --template-body file://"$(pwd)"/Stack/ElasticContainerService/Service.yml

# Route53スタックテンプレートの検証 TODO: Fargate IPの固定化
# aws cloudformation validate-template --template-body file://"$(pwd)"/Route53.yml

# VPCスタックの作成
aws cloudformation update-stack --stack-name VPCStack --template-body file://"$(pwd)"/Stack/VPC.yml
aws cloudformation wait stack-update-complete --stack-name VPCStack

# TaskDefnitionスタックの作成
# capabilitiesオプション参考: https://docs.aws.amazon.com/ja_jp/AWSCloudFormation/latest/UserGuide/using-iam-template.html#using-iam-capabilities
aws cloudformation update-stack --stack-name TaskDefinitionStack --template-body file://"$(pwd)"/Stack/ElasticContainerService/TaskDefinition.yml --capabilities CAPABILITY_NAMED_IAM
aws cloudformation wait stack-update-complete --stack-name TaskDefinitionStack

# Clusterスタックの作成
aws cloudformation update-stack --stack-name ClusterStack --template-body file://"$(pwd)"/Stack/ElasticContainerService/Cluster.yml
aws cloudformation wait stack-update-complete --stack-name ClusterStack

# Serviceスタックの作成
aws cloudformation update-stack --stack-name ServiceStack --template-body file://"$(pwd)"/Stack/ElasticContainerService/Service.yml
aws cloudformation wait stack-update-complete --stack-name ServiceStack

# Route53スタックの作成 TODO: Fargate IPの固定化
# aws cloudformation update-stack --stack-name Route53Stack --template-body file://"$(pwd)"/Stack/Route53.yml
