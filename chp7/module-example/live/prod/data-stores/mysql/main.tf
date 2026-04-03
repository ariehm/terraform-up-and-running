
provider "aws" {
  region = "us-east-2"
  alias  = "primary"
}

provider "aws" {
  region = "us-west-2"
  alias  = "secondary"
}

module "mysql_primary" {
  providers = {
    aws = aws.primary
  }

  source = "../../../../modules/data-stores/mysql"

  db_name     = "prod_db"
  db_username = var.db_username
  db_password = var.db_password

  # Must be enabled to support replication!
  backup_retention_period = 1
}

module "mysql_replica" {
  providers = {
    aws = aws.secondary
  }

  source = "../../../../modules/data-stores/mysql"

  # Make this replica of primary
  replicate_source_db = module.mysql_primary.arn
}
