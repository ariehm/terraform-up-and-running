
# Chapter 7 Notes: PROVIDERS

Don't use this:
```tf
provider "aws" {
  region = "us-east-2"
}
```

... too much implicit magic, fine for getting started, but this better:

```tf
terraform {
  required_providers {
    <LOCAL_NAME> = {
      source = "<URL>"
      version = "<VERSION>"
    }
  }
}
```

NOTE: the URL could point at some custom thing, but you can put "hashicorp/aws"
and it'll download from the default "registry.terraform.io/hashicorp/aws" host.

Let's get concrete:

```tf
terraform {
  required_providers {
    aws = { // <- name here not in quotes has to match name in quotes below
      source = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" { // <- name here in quotes has to match
  region = "us-east-2"
}
```


## Multiple Copies of Same Provider

You can alias the providers:

```tf
provider "aws" {
  region = "us-east-2"
  alias = "region_1"
}

provider "aws" {
  region = "us-west-2"
  alias = "region_2"
}

data "aws_region" "region_1" {
  provider = aws.region_1
}

data "aws_region" "region_2" {
  provider = aws.region_2
}

output "region_1" {
  value = data.aws_region.region_1.name
  description = "name of first region"
}

output "region_2" {
  value = data.aws_region.region_2.name
  description = "name of second region"
}
```
