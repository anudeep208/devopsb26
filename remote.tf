terraform {
  backend "s3" {
    bucket = "anudeep121810"
    key    = "Terraformtfstate"
    region = "us-east-1"
  }
}