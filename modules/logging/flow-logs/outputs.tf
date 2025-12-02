output "flow_log_id" {
  description = "IDs of created flow logs (combined)"
  value = concat(
    [for f in aws_flow_log.vpc : f.id],
    [for f in aws_flow_log.subnet : f.id],
    [for f in aws_flow_log.eni : f.id]
  )
}
