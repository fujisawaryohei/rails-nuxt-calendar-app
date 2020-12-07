#!/bin/bash 
set -eu
aws cloudformation validate-template --template-body file://"$(pwd)"/VPC.yml
aws cloudformation validate-template --template-body file://"$(pwd)"/ElasticLoadBalancing.yml
aws cloudformation validate-template --template-body file://"$(pwd)"/Route53.yml
aws cloudformation create-stack --stack-name VPCStack --template-body file://"$(pwd)"/VPC.yml
aws cloudformation wait stack-create-complete --stack-name VPCStack
aws cloudformation create-stack --stack-name ELBStack --template-body file://"$(pwd)"/ElasticLoadBalancing.yml
aws cloudformation wait stack-create-complete --stack-name ELBStack
aws cloudformation create-stack --stack-name Route53Stack --template-body file://"$(pwd)"/Route53.yml