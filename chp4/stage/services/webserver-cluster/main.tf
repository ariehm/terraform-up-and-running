
provider "aws" {
  region = "us-east-2"
}

module "webserver_cluster" {
  source = "../../../modules/services/webserver-cluster"

  cluster_name           = "h4tchtest-stage"
  db_remote_state_bucket = "h4tch-test-terraform-up-and-running-state"
  db_remote_state_key    = "stage/data-stores/mysql/terraform.tfstate"

  instance_type = "t2.micro"
  min_size      = 2
  max_size      = 2
}

terraform {
  backend "s3" {
    bucket = "h4tch-test-terraform-up-and-running-state"
    key    = "stage/services/webserver-cluster/terraform.tfstate"
    region = "us-east-2"

    dynamodb_table = "h4tch-test-terraform-up-and-running-locks"
    encrypt        = true
  }
}
