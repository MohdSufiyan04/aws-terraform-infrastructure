# These are the actual VALUES for dev environment
# Small and cheap — this is just for testing

environment   = "dev"
vpc_cidr      = "10.0.0.0/16"
subnet_cidr   = "10.0.1.0/24"
az            = "us-east-1a"
instance_type = "t2.micro"       # free tier — no cost
ami_id        = "ami-0c02fb55956c7d316"  # Amazon Linux 2 in us-east-1
app_name      = "spring-boot"
key_name      = "dev-key"        # we will create this next