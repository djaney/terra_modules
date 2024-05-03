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

variable "protocol" {
    type    = string
    default = "HTTP"
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
        value = string
    }))
    default     = []
    description = "Also creates environment variable but value is secrets manager or ssm parameter arn"
}

variable "load_balancer_arn" {
    type = string
}

variable "health_check" {
    type = object({
        path                = string
        healthy_threshold   = number
        unhealthy_threshold = number
        timeout             = number
        interval            = number
        matcher             = string
    })

    default = {
        path                = "/"
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 10
        interval            = 60
        matcher             = "401,200"
    }
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

variable "https" {
    type = object({
        listener_arn = string
        priority = number
    })
    default = {
        listener_arn = ""
        priority = -1
    }
    description = "HTTPS listener rule"
}

variable "http" {
    type = object({
        listener_arn = string
        priority = number
    })
    default = {
        listener_arn = ""
        priority = -1
    }
    description = "HTTP listener rule"
}

variable "fargate" {
    type = bool
}