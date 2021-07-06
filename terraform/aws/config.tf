terraform {
  backend "s3" {
    bucket = "my-tf-data-ohr"
    key = "dev/terraform.tfstate"
    profile = "koki_tf-config"
  }
}