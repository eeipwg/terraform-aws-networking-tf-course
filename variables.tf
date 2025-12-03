# 1st iteration excerise 37 where we just have the string for cidr block
# variable "vpc_cidr" {
#   type = string 

#   validation {
#     condition = can(cidrnetmask(var.vpc_cidr))
#     error_message = "The vpc_cidr must contain a valid CIDR block"
#   }

# }

# below introduced in first part of excerise 38
# variable "vpc_name" {
#   type = string
# }

# below introduced in second part of excerise 38
variable "vpc_config" {
  type = object({
    cidr_block = string
    name       = string
  })

  validation {
    condition     = can(cidrnetmask(var.vpc_config.cidr_block))
    error_message = "The cidr_block config option must contain a valid CIDR block"
  }



}

# below introduced in excerise 39
variable "subnet_config" {
  type = map(object({
    cidr_block = string
    az         = string
    # introduced in excerise 41
    public = optional(bool, false)
  }))

  validation {
    condition = alltrue([
      for config in values(var.subnet_config) : can(cidrnetmask(config.cidr_block))
    ])
    error_message = "The cidr_block config option must contain a valid CIDR block"
  }
}