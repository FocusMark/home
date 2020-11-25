# FocusMark Home

FocusMark is a modern micro-service driven architecture built using AWS serverless technologies. This repository represents the central hub for working with the platform and all of the various repositories that make up the code-base.

The get started you can clone this repository, set a few environment variables and then deploy the product into your own AWS account. It is important to note that the `focusmark` product name is used by the owner of this repository and so you will need to choose a different name when deploying into your account in order to avoid failed deployments due to global naming conflicts in AWS on some resources, such as S3 buckets.

> Note that this process will deploy all of the repositories that contain FocusMark platform services. It will not deploy anything related to DNS with Route 53. There are repositories that can be deployed within the /FocusMark organization but they are opinionated and have dependencies, such as a Domain at GoDaddy. For this reason the Home repository deploys everything using the default AWS URLs that are generated.

# Deploy

## Requirements

- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv1.html)
- [SAM CLI](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install.html)

## Optional
- [cfn-lint](https://github.com/aws-cloudformation/cfn-python-lint)

## Environment Variables
In order to run the deployment script you must have your environment set up with a few environment variables. The following table outlines the environment variables required with example values.

| Key                  | Value Type | Description | Examples                                           |
|----------------------|------------|-------------|----------------------------------------------------|
| deployed_environment | string     | The name of the environment you are deploying into | dev or prod |
| focusmark_productname | string | The name of the product. You _must_ use the name of a Domain that you own. | SuperTodo |

In Linux or macOS environments you can set this in your `.bash_profile` file.

```
export deployed_environment=dev
export focusmark_productname=supertodo

PATH=$PATH:$HOME/.local/bin:$HOME/bin
```

once your `.bash_profile` is set you can refresh the environment

```
$ source ~/.bash_profile
```

The `deployed_environment` and `focusmark_productname` environment variables will be used in all of the names of the resources provisioned during deployment. Using the `prod` environment and `supertodo` as the product name for example, the IAM Role created to grant API Gateway access to CloudWatch will be created as `supertodo-prod-role-apigatewayCloudwatchIntegration`.

## Deployment

In order to deploy the infrastructure you just need to execute the bash script included in the root directory from a terminal:

```
$ sh deploy.sh
```

Once deployment is completed you will have all of the AWS Resources deployed for use.

This repository will deploy the following repositories, in order.

- [aws-infrastructure](https://github.com/focusmark/aws-infrastructure)
- [aws-authentication](https://github.com/focusmark/aws-authentication)
- [api-project](https://github.com/focusmark/api-project)
- [api-task](https://github.com/focusmark/api-task)

Each of these repositories have documentation that details the deployment and infrastructure deployed.

# DNS

If you want to deploy DNS with this platform then you will need to follow one of two processes.

### GoDaddy

If you own a domain at GoDaddy then you can deploy the [aws-hostedzone-godaddy](https://github.com/focusmark/aws-hostedzone-godaddy) repository. This will deploy a Hsoted Zone and set your GoDaddy domain nameservers to use the Route 53 Hosted Zone nameservers. This will export a Hosted Zone Id via the CloudFormation `${ProductName}-route53-dotAppZone` export.

### Custom domain

If you use a registrar other than GoDaddy then you will need to create a Hosted Zone via CloudFormation at a minimum. Setting nameservers can be done automatically via CloudFormation, scripting or manually if desired. The Hosted Zone must be deployed via CloudFormation with an export of `${ProductName}-route53-dotAppZone` that provides the Hosted Zone Id as the value. This is critical for the remainder of the DNS CloudFormation Stacks to discover the Hosted Zone and use it when deploying certificates and sub-domains.

-----

Once you have a Hosted Zone created from one of the two steps above then you are ready to deploy the remainder. You can do so by cloning the [aws-dns](https://github.com/focusmark/aws-dns) repository and deploying it. This will build certificates, API Gateway Domain configuration and build `api` and `auth` sub-domains. The `api` subdomain will have the `api-project` and `api-task` API Gateway services placed behind it.