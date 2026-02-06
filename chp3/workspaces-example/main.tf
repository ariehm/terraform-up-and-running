
# This doesn't really show off what was happening.
#
# This section of chp3 had us cd into here, and run "terraform apply".
# Then:
#   $ terraform workspace list
# ... showed a single default workspace.
#
# Then:
#   $ terraform workspace new example1
#   $ terraform apply
# ...
#   $ terraform workspace new example2
#   $ terraform apply
#
# .. All this resulted in the exact same thing getting deployed 3 times in 3
# sorta-separate workspaces.  But while this can be handy for testing something
# it's not good for really separating stuff, for all sorts of reasons.

resource "aws_instance" "example" {
  ami           = "ami-0fb653ca2d3203ac1"
  instance_type = "t2.micro"
  region        = "us-east-2"
}

terraform {
  backend "s3" {
    bucket = "h4tch-test-terraform-up-and-running-state"
    key    = "workspaces-example/terraform.tfstate"
    region = "us-east-2"

    dynamodb_table = "h4tch-test-terraform-up-and-running-locks"
    encrypt        = true
  }
}

