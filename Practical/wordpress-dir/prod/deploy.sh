#!/bin/bash

set -e

# ===== Constants =====
readonly PROFILE="simplilearn"
readonly REGION="us-east-1"
readonly KEY_NAME="demo-ssh-key"
readonly KEY_FILE="../../${KEY_NAME}.pem"
readonly STACK_DIR="./"
readonly MASTER_STACK_NAME="masterStackProd"
readonly S3_BUCKET="cloud-formation-stack-demo"

# ===== Ensure Key File Directory Exists =====
mkdir -p "$(dirname "${KEY_FILE}")"


# ===== Check & Create S3 Bucket =====
echo "🔍 Checking if S3 bucket ${S3_BUCKET} exists..."
if aws s3api head-bucket \
  --bucket "${S3_BUCKET}" \
  --profile "${PROFILE}" 2>/dev/null; then
  echo "⚠️ Bucket ${S3_BUCKET} already exists. Skipping creation."
else
  echo "📦 Creating S3 bucket..."
  aws s3api create-bucket \
    --bucket "${S3_BUCKET}" \
    --region "${REGION}" \
    --profile "${PROFILE}"
fi


# ===== Apply Public Access Block to S3 Bucket =====
echo "🔒 Blocking public access on S3 bucket..."
aws s3api put-public-access-block \
  --bucket "${S3_BUCKET}" \
  --profile "${PROFILE}" \
  --region "${REGION}" \
  --public-access-block-configuration \
    BlockPublicAcls=true \
    IgnorePublicAcls=true \
    BlockPublicPolicy=true \
    RestrictPublicBuckets=true



# Upload all child stacks to S3
echo "📦 Uploading child stack templates to S3 bucket: ${S3_BUCKET}"

aws s3 cp  ../prod  "s3://${S3_BUCKET}/${filename}" \
    --profile ${PROFILE} \
    --region ${REGION}
echo "✅ All templates uploaded to S3."

# Update masterStack.yaml to use S3 URLs in nested stacks if needed
# For example: TemplateURL: https://s3.amazonaws.com/cloud-formation-stack-demo/networkStack.yaml

echo "🚀 Creating Master Stack ${MASTER_STACK_NAME} with nested stacks via S3 URLs..."

aws cloudformation create-stack \
  --stack-name ${MASTER_STACK_NAME} \
  --template-body file://${STACK_DIR}/masterStack.yaml \
  --capabilities CAPABILITY_NAMED_IAM \
  --region ${REGION} \
  --profile ${PROFILE} \
  --parameters ParameterKey=TemplateBucketName,ParameterValue=${S3_BUCKET}




# ===== Check & Create Key Pair if Not Exists =====
echo "🔍 Checking for existing SSH key pair..."
list_key_pair=$(aws ec2 describe-key-pairs \
  --key-names "${KEY_NAME}" \
  --query 'KeyPairs[*].KeyName' \
  --output text \
  --profile "${PROFILE}" \
  --region "${REGION}" 2>/dev/null || true)

if [ -z "$list_key_pair" ]; then
  echo "🔑 Creating SSH key pair..."
  aws ec2 create-key-pair \
    --key-name "${KEY_NAME}" \
    --key-type rsa \
    --key-format pem \
    --query "KeyMaterial" \
    --output text \
    --profile "${PROFILE}" \
    --region "${REGION}" > "${KEY_FILE}"
  chmod 400 "${KEY_FILE}"
  echo "✅ Key pair created and saved to ${KEY_FILE}"
else
  echo "⚠️ Key pair ${KEY_NAME} already exists. Skipping creation."
fi

# ===== Check & Create CloudFormation Master Stack =====
echo "🔍 Checking if stack ${MASTER_STACK_NAME} already exists..."
if aws cloudformation describe-stacks \
  --stack-name "${MASTER_STACK_NAME}" \
  --region "${REGION}" \
  --profile "${PROFILE}" > /dev/null 2>&1; then
  echo "⚠️ Stack ${MASTER_STACK_NAME} already exists. Skipping creation."
else
  echo "🚀 Creating Master Stack ${MASTER_STACK_NAME} ...."
  aws cloudformation create-stack \
    --stack-name "${MASTER_STACK_NAME}" \
    --template-body "file://${STACK_DIR}/masterStack.yaml" \
    --capabilities CAPABILITY_NAMED_IAM \
    --region "${REGION}" \
    --profile "${PROFILE}"

  echo "⏳ Waiting for Master Stack ${MASTER_STACK_NAME} to complete..."
  aws cloudformation wait stack-create-complete \
    --stack-name "${MASTER_STACK_NAME}" \
    --profile "${PROFILE}" \
    --region "${REGION}"
  echo "✅ ${MASTER_STACK_NAME} Stack created."
fi



echo "✅ All done."
