variable vpc_id {
    description = "VPC ID"
}

variable db_identifier {
    type        = string
    description = "Database server identifier. Must be unique"
}

variable db_name {
    type        = string
    description = "Database of main database"
}

variable engine {
    type        = string
    description = "Database engine to use"
}

variable engine_version {
    type        = string
    description = "Database engine version"
}

variable instance_type {
    type        = string
    default     = "db.t3.micro"
    description = "Instance type"
}

variable subnet_ids {
    type        = list(string)
    description = "List of subnet Ids. Must select more than 1 that is assigned to different AZ"
}

variable allocated_storage {
    type        = number
    default     = 50
    description = "GB of data to be allocated. Cannot scale down."
    validation {
        condition = var.allocated_storage >= 50
        error_message = "Cannot be less than 50"
    }
}


variable "ssm_namespace" {
    type = string
    description = "Will create ssm parameter names /{namespace}/db/{db_identifier}/{field name}"
}

