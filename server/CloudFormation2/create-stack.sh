#!/bin/bash 
set -eu
# VPCスタックテンプレートの検証
aws cloudformation validate-template --template-body file://"$(pwd)"/Stack/VPC.yml

# ELBスタックテンプレートの検証
aws cloudformation validate-template --template-body file://"$(pwd)"/Stack/ElasticLoadBalancing.yml

# RDSスタックテンプレートの検証
aws cloudformation validate-template --template-body file://"$(pwd)"/Stack/RDS.yml

# TaskDefnitionスタックテンプレートの検証
aws cloudformation validate-template --template-body file://"$(pwd)"/Stack/ElasticContainerService/TaskDefinition.yml

# Clusterスタックテンプレートの検証
aws cloudformation validate-template --template-body file://"$(pwd)"/Stack/ElasticContainerService/Cluster.yml

# Serviceスタックの検証
aws cloudformation validate-template --template-body file://"$(pwd)"/Stack/ElasticContainerService/Service.yml

# Route53スタックテンプレートの検証 TODO: Fargate IPの固定化
aws cloudformation validate-template --template-body file://"$(pwd)"/Stack/Route53.yml

# VPCスタックの作成
aws cloudformation create-stack --stack-name VPCStack --template-body file://"$(pwd)"/Stack/VPC.yml --profile fusic_dev
aws cloudformation wait stack-create-complete --stack-name VPCStack

# ELBスタックの作成
aws cloudformation create-stack --stack-name ELBStack --template-body file://"$(pwd)"/Stack/ElasticLoadBalancing.yml --profile fusic_dev
aws cloudformation wait stack-create-complete --stack-name ELBStack

# RDSスタックの作成
aws cloudformation create-stack --stack-name RDSStack --template-body file://"$(pwd)"/Stack/RDS.yml --profile fusic_dev
aws cloudformation wait stack-create-complete --stack-name RDSStack

# TaskDefnitionスタックの作成
# capabilitiesオプション参考: https://docs.aws.amazon.com/ja_jp/AWSCloudFormation/latest/UserGuide/using-iam-template.html#using-iam-capabilities
aws cloudformation create-stack --stack-name TaskDefinitionStack --template-body file://"$(pwd)"/Stack/ElasticContainerService/TaskDefinition.yml --capabilities CAPABILITY_NAMED_IAM --profile fusic_dev
aws cloudformation wait stack-create-complete --stack-name TaskDefinitionStack

# Clusterスタックの作成
aws cloudformation create-stack --stack-name ClusterStack --template-body file://"$(pwd)"/Stack/ElasticContainerService/Cluster.yml --profile fusic_dev
aws cloudformation wait stack-create-complete --stack-name ClusterStack

# Serviceスタックの作成
aws cloudformation create-stack --stack-name ServiceStack --template-body file://"$(pwd)"/Stack/ElasticContainerService/Service.yml --profile fusic_dev
aws cloudformation wait stack-create-complete --stack-name ServiceStack

# Route53スタックの作成 TODO: Fargate IPの固定化
# aws cloudformation create-stack --stack-name Route53Stack --template-body file://"$(pwd)"/Stack/Route53.yml --profile fusic_dev