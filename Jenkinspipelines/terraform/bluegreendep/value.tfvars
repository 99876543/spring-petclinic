enable_green_env = true
green_instance_count = 3 
https_listeners = [
  {
    certificate_arn = "arn:aws:elasticloadbalancing:us-east-1:425634926888:targetgroup/newt2/4f8176aeeff824c9"
    ssl_policy      = "TLSv1.2"
  },
  {
    certificate_arn = "arn:aws:elasticloadbalancing:us-east-1:425634926888:targetgroup/newt2/4f8176aeeff824c9" 
    ssl_policy      = "TLSv1.2"
  }
]
aws_lb_listeners = [
  {
    port              = 80
    protocol          = "HTTP"
    target_group_arn  = "arn:aws:elasticloadbalancing:us-east-1:425634926888:targetgroup/newt2/4f8176aeeff824c9"
  },
  {
    port              = 443
    protocol          = "HTTPS"
    target_group_arn  = "arn:aws:elasticloadbalancing:us-east-1:425634926888:targetgroup/newt2/4f8176aeeff824c9"
  }

]
