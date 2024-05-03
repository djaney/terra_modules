variable "vpc_id" {
    type = string
}

variable "name" {
    type = string
}

variable "public_subnet_ids" {
    type = list(string)
}

variable "ingress_ports" {
    type = list(number)
}

variable "http" {
    type = object({
        port = number
    })
    description = "Listen to http"
    default     = {
        port = -1
    }
}

variable "https" {
    type = object({
        port            = number
        certificate_arn = string
        ssl_policy      = string
    })
    description = "Listen to https"
    default     = {
        port            = -1
        certificate_arn = ""
        ssl_policy      = "ELBSecurityPolicy-2016-08"
    }
}
