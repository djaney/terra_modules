variable "vpc_id" {
  type = string
}
variable "cluster_name" {
  type = string
}

variable "asg_scaling" {
  type = object({
    min = number
    max = number
    target = number
  })
  description = "Autoscaling configuration for ASG"
}

variable "subnet_ids" {
  type = list(string)
  description = "Subnet to launch instances"
}

variable "target_utilization" {
  type = number
  description = "a number from 1 to 100. Target percent of utilization before scaling out"
  validation {
    condition = var.target_utilization > 0 && var.target_utilization <= 100
    error_message = "Value must be 1 to 100"
  }
}

variable "instance_type" {
  type = string
  default = "t3.small"
}

variable "managed_termination_protection" {
  type = bool
  default = false
  description = "If true, instances are aware of container status and protect them from termination"
}