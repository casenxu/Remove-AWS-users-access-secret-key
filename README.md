# Remove-AWS-users-access-secret-key
this repo generate an AWS Lambda function that remove all the AWS IAM users access and secret keys

## Why you want to do it:

1. You want force your AWS IAM users to regenerate their access and secret keys
2. This can be the first step for a key rotation POLICY
3. You know or suspect that one of your key is compromised and you don't know which one.

## What the terraform apply will generate
1. It creates a Lambda role and associate it with the function
2. It creates 2 policies for the role, one to store the logs in Cloudwatch and the other one to delete the IAM users keys
3. It associate the default IAM policy to have IAM read only access.
4. A Lambda function that perform the deletion

## Prerequisite
1. Terraform is already installed and configured in your laptop or the environment where you run the code
2. Git is installed so you can get the repo from github
3. Choose a region , I use the Virginia region us-east-1
4. You know where is your amazon credentials files mine is in this path /Users/giuseppe/.aws/credentials (if you are using a role in an EC2 machine comment the variable in the vars.tf file)
5. Choose a prefix that will be applied to the whole resources
6. You know which is your AWS IAM User so you can exclude from the list, mine is giuseppeborgese (don't worry you can easily change later)


## How to build it
It is enough these list of instruction

  git clone https://github.com/giuseppeborgese/Remove-AWS-users-access-secret-key
  cd Remove-AWS-users-access-secret-key
  terraform init
  terraform apply --var region=us-east-1 --var cred-file=/Users/giuseppe/.aws/credentials --var prefix=peppeTest --var myexclusionlist=giuseppeborgese

## How to clean your environment
If you are happy of your test and you want clean it , it is enough

  cd Remove-AWS-users-access-secret-key
  terraform destroy --force  
