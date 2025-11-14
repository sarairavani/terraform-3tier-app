############################################################
# Launch Template Outputs
############################################################

output "launch_template_ids" {
  description = "Map of Launch Template IDs created for each tier"
  value = {
    for k, lt in aws_launch_template.this : k => lt.id
  }
}

output "launch_template_names" {
  description = "Map of Launch Template names created for each tier"
  value = {
    for k, lt in aws_launch_template.this : k => lt.name
  }
}

