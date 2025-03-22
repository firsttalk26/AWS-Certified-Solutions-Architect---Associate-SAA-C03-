## **Introduction to AWS Security**

[https://docs.aws.amazon.com/whitepapers/latest/introduction-aws-security/identity-and-access-control.html](https://docs.aws.amazon.com/whitepapers/latest/introduction-aws-security/identity-and-access-control.html)

# Infrastructure Security

AWS provides several security capabilities and services to increase privacy and control network access. These include:

* **Network firewalls built into Amazon VPC** let you create private networks and control access to your instances or applications. Customers can control encryption in transit with TLS across AWS services.  
* **Connectivity options that enable private, or dedicated, connections** from your office or on-premises environment.  
* **DDoS mitigation technologies** that apply at layer 3 or 4 as well as layer 7\. These can be applied as part of application and content delivery strategies.  
* **Automatic encryption of all traffic** on the AWS global and regional networks between AWS-secured facilities.

# Inventory and Configuration Management

AWS offers a range of tools to allow you to move fast, while still enabling you to ensure that your cloud resources comply with organizational standards and best practices. These include:

* **Deployment tools** to manage the creation and decommissioning of AWS resources according to organization standards.  
* **Inventory and configuration management tools** to identify AWS resources and then track and manage changes to those resources over time.  
* **Template definition and management tools** to create standard, preconfigured, hardened virtual machines for EC2 instances.

# 

# Data Encryption

* Data at rest encryption capabilities available in most AWS services, such as Amazon EBS, Amazon S3, Amazon RDS, Amazon Redshift, Amazon ElastiCache, AWS Lambda, and Amazon SageMaker AI  
* Flexible key management options, including **AWS Key Management Service**, that allow you to choose whether to have AWS manage the encryption keys or enable you to keep complete control over your own keys  
* Dedicated, hardware-based cryptographic key storage using **AWS CloudHSM**, allowing you to help satisfy your compliance requirements  
* Encrypted message queues for the transmission of sensitive data using **server-side encryption (SSE) for Amazon SQS**

# Identity and Access Control

AWS offers you capabilities to define, enforce, and manage user access policies across AWS services. These include:

* [**AWS Identity and Access Management (IAM)**](https://aws.amazon.com/iam) lets you define individual users with permissions across AWS resources AWS Multi-Factor Authentication for privileged accounts, including options for software- and hardware-based authenticators. **IAM can be used to grant your employees and applications [federated access](https://aws.amazon.com/identity/federation/) to the AWS Management Console and AWS service APIs**, using your existing identity systems, such as Microsoft Active Directory or other partner offering.  
* [**AWS Directory Service**](https://aws.amazon.com/directoryservice/) allows you to integrate and federate with corporate directories to reduce administrative overhead and improve end-user experience.  
* [**AWS IAM Identity Center (successor to AWS Single Sign-On)**](https://aws.amazon.com/iam/identity-center/) allows you to centrally manage workforce access to multiple AWS accounts and applications.

# Monitoring and Logging

AWS provides tools and features that enable you to see what’s happening in your AWS environment. These include:

* With [AWS CloudTrail](https://aws.amazon.com/cloudtrail), you can monitor **AWS deployments in the cloud by getting a history of AWS API calls for your account, including API calls made via the AWS Management Console, the AWS SDKs, the command line tools, and higher-level AWS services**. You can also identify which users and accounts called AWS APIs for services that support CloudTrail, the source IP address the calls were made from, and when the calls occurred.  
* [Amazon CloudWatch](https://aws.amazon.com/cloudwatch) provides a reliable, scalable, and flexible monitoring solution that you can start using within minutes. You no longer need to set up, manage, and scale your own monitoring systems and infrastructure.  
* [**Amazon GuardDuty**](https://aws.amazon.com/guardduty) **is a threat detection service** that continuously monitors for malicious activity and unauthorized behavior to protect your AWS accounts and workloads. **Amazon GuardDuty exposes notifications via Amazon CloudWatch so you can trigger an automated response or notify a human**.