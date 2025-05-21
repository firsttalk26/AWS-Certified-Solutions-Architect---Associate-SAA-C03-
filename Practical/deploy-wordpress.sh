#!/bin/bash

set -e

PROFILE="simplilearn"
KEY_NAME="demo-ssh-key"
KEY_FILE="${KEY_NAME}.pem"
STACK_DIR="wordpress-dir/dev"

echo "🚀 Creating Network Stack..."
#aws cloudformation create-stack \
#  --stack-name networkStack \
#  --template-body file://${STACK_DIR}/networkStack.yaml \
#  --profile ${PROFILE} \
#  --capabilities CAPABILITY_NAMED_IAM

echo "⏳ Waiting for Network Stack to complete..."
aws cloudformation wait stack-create-complete \
  --stack-name networkStack \
  --profile ${PROFILE}
echo "✅ Network Stack created."

# Create Key Pair
if [ ! -f "${KEY_FILE}" ]; then
  echo "🔑 Creating SSH key pair..."
  aws ec2 create-key-pair \
    --key-name ${KEY_NAME} \
    --key-type rsa \
    --key-format pem \
    --profile ${PROFILE} \
    --query "KeyMaterial" \
    --output text > ${KEY_FILE}
  chmod 400 ${KEY_FILE}
  echo "✅ Key pair created and saved to ${KEY_FILE}"
else
  echo "⚠️ Key pair ${KEY_FILE} already exists. Skipping creation."
fi

echo "🚀 Creating MySQL Stack..."
aws cloudformation create-stack \
  --stack-name mysqlStack \
  --template-body file://${STACK_DIR}/mysqlStack.yaml \
  --profile ${PROFILE} \
  --capabilities CAPABILITY_NAMED_IAM

echo "⏳ Waiting for MySQL Stack to complete..."
aws cloudformation wait stack-create-complete \
  --stack-name mysqlStack \
  --profile ${PROFILE}
echo "✅ MySQL Stack created."

# Extract the MySQLPrivateIP output value from mysqlStack
MYSQL_PRIVATE_IP=$(aws cloudformation describe-stacks \
  --stack-name mysqlStack \
  --query "Stacks[0].Outputs[?OutputKey=='MySQLPrivateIP'].OutputValue" \
  --output text \
  --profile ${PROFILE})

echo "🔧 MySQL Private IP extracted: ${MYSQL_PRIVATE_IP}"

echo "🚀 Creating WordPress Stack with MySQLPrivateIP=${MYSQL_PRIVATE_IP}..."
aws cloudformation create-stack \
  --stack-name wpStack \
  --template-body file://${STACK_DIR}/wpStack.yaml \
  --profile ${PROFILE} \
  --capabilities CAPABILITY_NAMED_IAM \
  --parameters ParameterKey=MySQLPrivateIP,ParameterValue=${MYSQL_PRIVATE_IP}

echo "⏳ Waiting for WordPress Stack to complete..."
aws cloudformation wait stack-create-complete \
  --stack-name wpStack \
  --profile ${PROFILE}
echo "✅ WordPress Stack created."

echo "🎉 All stacks deployed successfully."

wordpress_endpoint=$(aws cloudformation describe-stacks \
  --stack-name wpStack \
  --query "Stacks[0].Outputs[?OutputKey=='WordPressURL'].OutputValue" \
  --output text \
  --profile ${PROFILE})

echo "WordpressURL=${wordpress_endpoint}"

