# FocusMark Home

FocusMark is a modern micro-service driven architecture built using AWS serverless technologies. This repository represents the central hub for working with the platform and all of the various repositories that make up the code-base.

# Getting started

The get started you can clone this repository, set a few environment variables and then deploy the product into your own AWS account. It is important to note that the `focusmark` product name is used by the owner of this repository and so you will need to choose a different name when deploying into your account in order to avoid failed deployments due to global naming conflicts in AWS on some resources, such as S3 buckets.

The following environment variables must be set before you can deploy all of the repositories.

|Key|Possible Values|
|----|----|
|deployed_environment| This can be anything. It is typically dev, test, prod etc. I use my last name while doing feature development so I don't break a working dev environment|
|focusmark_productname|This can be anything other than `focusmark`. Name it whatever you want, such as `mytaskservice`|
|target_domain|This needs to be a domain in GoDaddy. If you own a domain in another registrar then the deployment will fail. I cover non-godaddy domains in the docs within the [aws-infrastructure](https://github.com/FocusMark/aws-infrastructure) repository.|
|target_api_url|This needs to be the API url at GoDaddy for making Domain changes. At the moment that would be `https://api.godaddy.com/v1/domains/${DOMAIN_NAME_HERE}/records` with your domain name substituted in the URL|
|target_api_key|This is the API Key generated at the GoDaddy developer site for your account|
|target_api_secret|This is the API secret generated at the GoDaddy develoepr site for your account|

Once the environment variables above are set you can run the `deploy.sh` script found in this repository. Note that deployment is only supported from within a Linux environment at this time.

> NOTE: The GIT CLI and the AWS CLI are required for deployment.