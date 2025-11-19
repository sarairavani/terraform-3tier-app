############################################################
# ALB Module Variables
############################################################

variable "env_name" {}
variable "vpc_id" {}
variable "public_subnet_ids" { type = list(string) }
variable "alb_sg_ids" { type = list(string) }

variable "internal" {
  type    = bool
  default = false
}

variable "listener_http_port" {
  type    = number
  default = 80
}

variable "listener_https_port" {
  type    = number
  default = 443
}

variable "enable_https" {
  type    = bool
  default = false
}

variable "redirect_http_to_https" {
  type    = bool
  default = true
}

variable "ssl_certificate_arn" {
  type    = string
  default = ""
}

variable "ssl_policy" {
  type    = string
  default = "ELBSecurityPolicy-2016-08"
}

variable "enable_access_logs" {
  type    = bool
  default = false
}

variable "alb_logs_bucket" {
  type    = string
  default = null
}

variable "common_tags" {
  type    = map(string)
  default = {}
}

variable "enable_maintenance" {
  type    = bool
  default = false
}

############################################################
# Target Group Settings
############################################################

variable "web_tg" {
  type = object({
    port                   = number
    protocol               = string
    target_type            = string
    stickiness_enabled     = bool
    stickiness_duration    = number
    health = object({
      path                = string
      matcher             = string
      interval            = number
      timeout             = number
      healthy_threshold   = number
      unhealthy_threshold = number
    })
  })
}

variable "app_tg" {
  type = object({
    port                   = number
    protocol               = string
    target_type            = string
    stickiness_enabled     = bool
    stickiness_duration    = number
    health = object({
      path                = string
      matcher             = string
      interval            = number
      timeout             = number
      healthy_threshold   = number
      unhealthy_threshold = number
    })
  })
}

