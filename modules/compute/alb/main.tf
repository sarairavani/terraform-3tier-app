############################################################
# Application Load Balancer (ALB) - 3-Tier Architecture
# Description:
# Fully dynamic ALB module with:
# - HTTP/HTTPS listeners
# - Automatic redirect HTTP→HTTPS
# - Web + App target groups
# - Health checks, stickiness
# - Optional access logs
# - Optional maintenance mode
############################################################

resource "aws_lb" "this" {
  name               = "${var.environment_name}-alb"
  internal           = var.internal
  load_balancer_type = "application"
  security_groups    = var.alb_security_group_ids
  subnets            = var.public_subnet_ids

  # ALB Access Logs (Optional)
  dynamic "access_logs" {
    for_each = var.enable_access_logs ? [1] : []
    content {
      bucket  = var.alb_logs_bucket
      prefix  = "${var.environment_name}/alb"
      enabled = true
    }
  }

  tags = merge(var.common_tags, { Name = "${var.environment_name}-alb" })
}

############################################################
# Target Group - Web Tier (Frontend)
############################################################

resource "aws_lb_target_group" "web" {
  name        = "${var.environment_name}-web-tg"
  port        = var.web_tg.port
  protocol    = var.web_tg.protocol
  vpc_id      = var.vpc_id
  target_type = var.web_tg.target_type

  stickiness {
    enabled         = var.web_tg.stickiness_enabled
    type            = "lb_cookie"
    cookie_duration = var.web_tg.stickiness_duration
  }

  health_check {
    path                = var.web_tg.health.path
    matcher             = var.web_tg.health.matcher
    interval            = var.web_tg.health.interval
    timeout             = var.web_tg.health.timeout
    healthy_threshold   = var.web_tg.health.healthy_threshold
    unhealthy_threshold = var.web_tg.health.unhealthy_threshold
  }

  tags = merge(var.common_tags, { Name = "${var.environment_name}-web-tg" })
}

############################################################
# Target Group - App Tier (Backend)
############################################################

resource "aws_lb_target_group" "app" {
  name        = "${var.environment_name}-app-tg"
  port        = var.app_tg.port
  protocol    = var.app_tg.protocol
  vpc_id      = var.vpc_id
  target_type = var.app_tg.target_type

  stickiness {
    enabled         = var.app_tg.stickiness_enabled
    type            = "lb_cookie"
    cookie_duration = var.app_tg.stickiness_duration
  }

  health_check {
    path                = var.app_tg.health.path
    matcher             = var.app_tg.health.matcher
    interval            = var.app_tg.health.interval
    timeout             = var.app_tg.health.timeout
    healthy_threshold   = var.app_tg.health.healthy_threshold
    unhealthy_threshold = var.app_tg.health.unhealthy_threshold
  }

  tags = merge(var.common_tags, { Name = "${var.environment_name}-app-tg" })
}

############################################################
# HTTP Listener (Port 80)
############################################################

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = var.listener_http_port
  protocol          = "HTTP"

  dynamic "default_action" {
    for_each = (var.redirect_http_to_https && var.enable_https) ? [1] : []
    content {
      type = "redirect"
      redirect {
        protocol    = "HTTPS"
        port        = tostring(var.listener_https_port)
        status_code = "HTTP_301"
      }
    }
  }

  # If redirect is disabled → forward traffic directly
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }
}

############################################################
# HTTPS Listener (Port 443)
############################################################

resource "aws_lb_listener" "https" {
  for_each          = var.enable_https ? { "https" = 1 } : {}
  load_balancer_arn = aws_lb.this.arn
  port              = var.listener_https_port
  protocol          = "HTTPS"
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.ssl_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }
}

############################################################
# Listener Rule: /api/* → App Target Group
############################################################

resource "aws_lb_listener_rule" "api_path" {
  listener_arn = var.enable_https ? aws_lb_listener.https["https"].arn : aws_lb_listener.http.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }

  condition {
    path_pattern {
      values = ["/api/*", "/app/*"]
    }
  }
}

############################################################
# Maintenance Mode
############################################################

resource "aws_lb_listener_rule" "maintenance" {
  count        = var.enable_maintenance ? 1 : 0
  listener_arn = var.enable_https ? aws_lb_listener.https["https"].arn : aws_lb_listener.http.arn
  priority     = 10

  action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "Service under maintenance"
      status_code  = "503"
    }
  }

  condition {
    path_pattern {
      values = ["/maintenance*"]
    }
  }
}

