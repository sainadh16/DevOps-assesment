
                        *******************
# Terraform template for RDS Database

This terraform template is to create a RDS MYSQL db instance, dynamodb-table, AWs_secrets_manager

                       ******************* prerequisites **************
# To run this  terraform template we need to have a terraform version "Terraform v0.13.5"

# If you are a mac user wer can install terrafom using 
                                                        ->>>>>>> brew install terraform command 

# make sure the brew is installed first for more details refer ->>>>>[1] 

# we need to insall aws-cli in our local for more details refer ->>>>>[2]
    after installing aws-cli there are few steps to follow
           1 condfiguring aws IAM access_key & secret_key in our local
           2 But before that we need to ake sure IAM user is created with required permissions in the aws account which we are going to work.
           command ->>>>> aws configure
              AWS Access Key ID [****************DIPI]: 
              AWS Secret Access Key [****************t0gr]: 
              Default region name [us-east-1]: 
              Default output format [None]: 


# store db credentials in AWS secrets manager and  secret can be retrieved in application. 
# sample python script is added to the modules directory as a reference to retrieve a secret from AWS secret manager.  
  
# using apply_immediately flag in Datbase configuration can result in a brief downtime as the server reboots. See the AWS Docs on RDS Maintenance refer ->>>>>>>>>[2] for more information.


                    ********** terraform commands to be used*************

                    # terraform init    (Initialize a Terraform working directory)
                    # terraform plan    (Generate and show an execution plan)
                    # terraform apply   (Builds or changes infrastructure)


# As mentioned we have two environments Development & production.
# Each environment is in a separate directories as the resource sizes will be changed from development to production.
       depending on our usage for example production can be chosen   db.m6g.xlarge with 4vCPUs 16GiB RAM.
                                          development can be chosen  db.m6.large   with 2vCPUs 8GiB RAM.      
# Module: which is common and we will refer that re-usable module in our environments configuration.
         
 #### using below module example:         
             module "RDS" {
                source            = "../modules/Rds/"
# The re-usable modules are helpful when we are spinning the new environment.
 steps to spinup a new environment 
              1 copy any development or production environment directory and rename it to example: stage 
              2 change the variables accordingly
              3 new environment is ready


*******Note: module is common and whatever the changes we want to make we can make changes in our development & production environments*****
View a code sample that illustrates how to retrieve the secret in your application.
  #### file name is aws_secrets.py #####



# Reference: 
[1] https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_UpgradeDBInstance.Maintenance.html
[2] https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-windows.html
[2] https://www.terraform.io/downloads.html