resource "aws_s3_bucket" "bucket_site" {
    bucket = format("%s-demo-tfstates", var.project_name)
    acl    = "private"
    force_destroy = true
}