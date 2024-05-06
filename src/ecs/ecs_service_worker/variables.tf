variable "name" {
    type = string
}

variable "vpc_id" {
    type = string
}

variable "subnet_ids" {
    type = list(string)
}

variable "cluster_id" {
    type = string
}

variable "image" {
    type = string
}

variable "task_cpu" {
    type = number
}

variable "task_memory" {
    type = number
}

variable "container_port" {
    type        = number
    description = "Port of the app exposed by container. Not the same as final port of service"
}

variable "environment" {
    type = list(object({
        name  = string
        value = string
    }))
    default = []
}

variable "secrets" {
    type = list(object({
        name  = string
        valueFrom = string
    }))
    default     = []
    description = "valueFrom is ARN of SSM parameter"
}

variable "task_role_arn" {
    type        = string
    description = "Role to assume to call other AWS services within the container"
}

variable "task_count" {
    type        = number
    description = "Number of task instances"
    default     = 1
}



variable "fargate" {
    type = bool
}