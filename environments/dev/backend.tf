terraform {
  backend "s3" {
    bucket         = "terraform-states-canada" # your S3 bucket for state
    key            = "dev/terraform.tfstate"   # path inside bucket
    region         = "ca-central-1"            # 🇨🇦 Canada region
    dynamodb_table = "terraform-locks"         # for state locking
    encrypt        = true
  }
}

