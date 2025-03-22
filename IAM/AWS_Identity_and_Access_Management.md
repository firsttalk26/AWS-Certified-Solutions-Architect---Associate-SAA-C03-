# AWS Identity and Access Management

[https://docs.aws.amazon.com/IAM/latest/UserGuide/introduction.html](https://docs.aws.amazon.com/IAM/latest/UserGuide/introduction.html)

AWS IAM is used to authenticate (signed in) and authorize (has permissions) users, API, and Applications to use resources.

## Identities

Use IAM to set up other identities in addition to your root user, such as administrators, analysts, and developers, and grant them access to the resources they need to succeed in their tasks.

## Access management

**Authentication** is provided by matching the sign-in credentials to a principal (an IAM user, federated user, IAM role, or application) trusted by the AWS account. 

A request is made to grant the principal access to resources. Access is granted in response to an **authorization** request if the user has been given permission to the resource. 

Authorization requests can be made by principals within your AWS account or from another AWS account that you trust.

Once authorized, the principal can take action or perform operations on resources in your AWS account. For example, the principal could launch a new Amazon Elastic Compute Cloud instance, modify IAM group membership, or delete Amazon Simple Storage Service buckets.

## Service cost information

**AWS Identity and Access Management (IAM)**, **AWS IAM Identity Center** and **AWS Security Token Service (AWS STS)** are features of your AWS account offered at **no additional charge**. You are charged only when you access other AWS services using your IAM users or AWS STS temporary security credentials.

**IAM Access Analyzer** external access analysis is offered at no additional charge. However, **you will incur charges for unused access analysis and customer policy checks**. 

For a complete list of charges and prices for IAM Access Analyzer, see [IAM Access Analyzer pricing](https://aws.amazon.com/iam/access-analyzer/pricing).

# Why should I use IAM?

## Shared access to your AWS account

You can grant other people permission to administer and use resources in your AWS account without having to share your password or access key.

## Granular permissions

You can grant different permissions to different people for different resources.

## Secure access to AWS resources for applications that run on Amazon EC2

You can use IAM features to securely provide credentials for applications that run on EC2 instances. These credentials provide permissions for your application to access other AWS resources.

## Multi-factor authentication (MFA)

You can add two-factor authentication to your account and to individual users for extra security. 

If you already use a FIDO security key with other services, and it has an AWS supported configuration, you can use WebAuthn for MFA security. For more information, see [Supported configurations for using passkeys and security keys](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_mfa_fido_supported_configurations)

## Identity federation

You can allow users who already have passwords elsewhere.

—for example, in your corporate network or with an internet identity provider—to access your AWS account. These users are granted temporary credentials that comply with IAM best practice recommendations. Using identity federation enhances the security of your AWS account.

## Identity information for assurance

If you use [AWS CloudTrail](https://aws.amazon.com/cloudtrail/), you receive log records that include information about those who made requests for resources in your account. That information is based on IAM identities.

## PCI DSS Compliance

IAM supports the processing, storage, and transmission of credit card data by a merchant or service provider, and has been validated as being compliant with Payment Card Industry (PCI) Data Security Standard (DSS). For more information about PCI DSS, including how to request a copy of the AWS PCI Compliance Package, see [PCI DSS Level 1](https://aws.amazon.com/compliance/pci-dss-level-1-faqs/).

# When do I use IAM?

### When you are performing different job functions

You can use IAM to create users for different teams and assign roles according to teams which authorizes you to access specific services and allows you to do specific actions

### When you are authorized to access AWS resources

### When you sign in as an IAM user

### When you assume an IAM role

An [*IAM role*](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles.html) is an identity within your AWS account that has specific permissions. 

**It is similar to an IAM user, but is not associated with a specific person.** 

To temporarily assume an IAM role in the AWS Management Console, you can [switch from a user to an IAM role (console)](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_switch-role-console.html). 

You can assume a role by calling an AWS CLI or AWS API operation or by using a custom URL. For more information about methods for using roles, see [Methods to assume a role](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_manage-assume.html) in the *IAM User Guide*.

IAM roles with temporary credentials are useful in the following situations:

* **Federated user access –** To assign permissions to a federated identity, you create a role and define permissions for the role.   
  When a federated identity authenticates, the identity is associated with the role and is granted the permissions that are defined by the role. For information about roles for federation, see [Create a role for a third-party identity provider (federation)](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_create_for-idp.html) in the *IAM User Guide*.   
  If you use IAM Identity Center, you configure a permission set. To control what your identities can access after they authenticate, IAM Identity Center correlates the permission set to a role in IAM. For information about permissions sets, see [Permission sets](https://docs.aws.amazon.com/singlesignon/latest/userguide/permissionsetsconcept.html) in the *AWS IAM Identity Center User Guide*.  
* **Temporary IAM user permissions –** An IAM user or role can assume an IAM role to temporarily take on different permissions for a specific task.  
* **Cross-account access –** You can use an ***IAM role to allow someone*** (a trusted principal) in a different account to access resources in your account.   
  Roles are the primary way to grant cross-account access. However, with some AWS services, you can attach a policy directly to a resource (instead of using a role as a proxy). To learn the difference between roles and resource-based policies for cross-account access, see [Cross account resource access in IAM](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies-cross-account-resource-access.html) in the *IAM User Guide*.  
* **Cross-service access –** Some AWS services use features in other AWS services. For example, when you make a call in a service, it's common for that service to run applications in Amazon EC2 or store objects in Amazon S3. **A service might do this using the calling principal's permissions, using a service role, or using a service-linked role**.  
  * **Forward access sessions (FAS)** – When you use an IAM user or role to perform actions in AWS, **you are considered a principal**. When you use some services, you might perform an action that then initiates another action in a different service.   
    FAS uses the permissions of the principal calling an AWS service, combined with the requesting AWS service to make requests to downstream services.  
    FAS requests are only made when a service receives a request that requires interactions with other AWS services or resources to complete.   
    **In this case, you must have permissions to perform both actions.** For policy details when making FAS requests, see [**Forward access sessions**](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_forward_access_sessions.html)**.**  
  * **Service role –** A service role is an [IAM role](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles.html) that a service assumes to perform actions on your behalf. An IAM administrator can create, modify, and delete a service role from within IAM. For more information, see [Create a role to delegate permissions to an AWS service](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_create_for-service.html) in the *IAM User Guide*.  
  * **Service-linked role –** A service-linked role is a type of service role that is linked to an AWS service. The service can assume the role to perform an action on your behalf. Service-linked roles appear in your AWS account and are owned by the service. **An IAM administrator can view, but not edit the permissions for service-linked roles**.  
* **Applications running on Amazon EC2 –** You can use an IAM role to manage temporary credentials for applications that are running on an EC2 instance and making AWS CLI or AWS API requests. This is preferable to storing access keys within the EC2 instance. To assign an AWS role to an EC2 instance and make it available to all of its applications, you create an instance profile that is attached to the instance. An instance profile contains the role and enables programs that are running on the EC2 instance to get temporary credentials. For more information, see [Use an IAM role to grant permissions to applications running on Amazon EC2 instances](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_switch-role-ec2.html) in the *IAM User Guide*.

### When you create policies and permissions

Policies can be created and attached to principals (users, groups of users, roles assumed by users, and resources).

You can use these policies with an IAM role:

* **Trust policy –** Defines which [principal](https://docs.aws.amazon.com/glossary/latest/reference/glos-chap.html?icmpid=docs_homepage_addtlrcs#principal) can assume the role, and under which conditions. **A trust policy is a specific type of resource-based policy for IAM roles.** A role can have only one trust policy.  
* **Identity-based policies (inline and managed) –** These policies define the permissions that the user of the role can perform (or is denied from performing), and on which resources.

# How do I manage IAM?

## Use the AWS Management Console

AWS recommends configuring users with temporary credentials as a security [best practice](https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html). 

IAM users that have assumed a role, federated users, and users in IAM Identity Center **have temporary credentials**, **while the IAM user and root user have long-term credentials**. 

The sign-in experience is different for the different types of AWS Management Console users.

* IAM users and the root user sign-in from the main AWS sign-in URL (https://signin.aws.amazon.com).  
* IAM Identity Center users sign in using a specific AWS access portal that's unique to their organization. Once they sign in they can choose which account or application to access. If they choose to access an account, they choose which permission set they want to use for the management session.  
* **Federated users managed in an external identity provider** linked to an AWS account sign-in using a custom enterprise access portal. The AWS resources available to federated users are dependent upon the policies selected by their organization.

## AWS Command Line Tools

### AWS Command Line Interface (CLI) and Software Development Kits (SDKs)

IAM Identity Center and IAM users use different methods to authenticate their credentials when they authenticate through the CLI or the application interfaces (APIs) in the associated SDKs.

Credentials and configuration settings are located in multiple places, 

* System or user environment variables  
* Local AWS configuration files  
* Explicitly declared on the command line as a parameter.   
  Certain locations take precedence over others.

***Both IAM Identity Center and IAM provide access keys that can be used with the CLI or SDK***. 

***IAM Identity Center access keys are temporary credentials that can be automatically refreshed and are recommended over the long-term access keys associated with IAM users.***

You can configure programmatic access to resources in different ways, depending on the environment and the access available to you.

* Recommended options for authenticating local code with AWS service are IAM Identity Center and IAM Roles Anywhere  
* Recommended options for authenticating code running within an AWS environment are to use IAM roles or use IAM Identity Center credentials.

AWS recommend using IAM Identity Center credentials that automatically refresh when automating access to your AWS resources. I

f you have configured users and permission sets in IAM Identity Center you use the ***aws configure sso command to use a command-line wizard*** that will help you identify the credentials available to you and store them in a profile. 

For more information about configuring your profile, see [Configure your profile with the aws configure sso wizard](https://docs.aws.amazon.com/cli/latest/userguide/sso-configure-profile-token.html#sso-configure-profile-token-auto-sso) in the *AWS Command Line Interface User Guide for Version 2*.

## Use the AWS SDKs

AWS provides SDKs (software development kits) that consist of libraries and sample code for various programming languages and platforms (Java, Python, Ruby, .NET, iOS, Android, etc.). The SDKs provide a convenient way to create programmatic access to IAM and AWS. For example, the SDKs take care of tasks such as cryptographically signing requests, managing errors, and retrying requests automatically. For information about the AWS SDKs, including how to download and install them, see the [Tools for Amazon Web Services](https://aws.amazon.com/tools/) page.

## Use the IAM Query API

You can access IAM and AWS programmatically by using the IAM Query API, which lets you issue HTTPS requests directly to the service. When you use the Query API, you must include code to digitally sign requests using your credentials. For more information, see [Calling the IAM API using HTTP query requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/programming.html) and the [IAM API Reference](https://docs.aws.amazon.com/IAM/latest/APIReference/).

