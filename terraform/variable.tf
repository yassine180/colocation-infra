variable "vpc-cidr" {
  default     = "10.10.0.0/16"
  description = "VPC CIDR Block"
  type        = string
}

variable "public-subnet-cidr" {
  default     = "10.10.10.0/24"
  description = "Public Subnet CIDR Block"
  type        = string
}

variable "private-subnet-1-cidr" {
  default     = "10.10.20.0/24"
  description = "Private Subnet 1 CIDR Block"
  type        = string
}

variable "private-subnet-2-cidr" {
  default     = "10.10.21.0/24"
  description = "Private Subnet 2 CIDR Block"
  type        = string
}

variable "private-subnet-3-cidr" {
  default     = "10.10.22.0/24"
  description = "Private Subnet 3 CIDR Block"
  type        = string
}

variable "ssh-location" {
  default     = "0.0.0.0/0"
  description = "IP Address Allowd to SSH Into jenkins Host"
  type        = string
}
