variable "region" {
  #default = "eu-central-1" # Frankfurt
  #default = "us-east-2" # Ohio
  #default = "us-west-2" #Oregon
  #default = "ap-southeast-2"
  #default = "us-east-2"
  #default = "eu-west-1"
  default = "us-east-1"
  description = "the region where you want deploy the solution"
}

variable "cred-file" {
  #default = "C:/Users/borgese/.aws/credentials"  # Windows machine
  #default = "/home/vagrant/.aws/credentials"     # Linux Vagrant Box
  default = "/Users/giuseppe/.aws/credentials"    # Apple OS X
}

variable "profile" {
  default = "default"
}

variable "prefix" {
    default = "PeppeTest"
    description = "The prefix used to build the elements"
}

variable "myexclusionlist" {
  default = "giuseppeborgese"
  description = "the list of users to exclude like iamuser1 iamuser2"
}
