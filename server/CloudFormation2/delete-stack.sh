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
