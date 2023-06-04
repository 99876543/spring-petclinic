variable "green_instance_count" {
  description = "Number of green instances"
  type        = number
  default     = 1
 }
 variable "enable_green_env" {
  description = "Enable green environment"
  type        = bool
  default     = false
}
variable "aws_lb_listeners" {
  type = list(object({
    port              = number
    protocol          = string
    target_group_arn  = string
  }))
  description = "AWS Load Balancer Listeners"
}
variable "https_listeners" {
  type = list(object({
    certificate_arn = string
    ssl_policy      = string
  }))
  default = []
}


