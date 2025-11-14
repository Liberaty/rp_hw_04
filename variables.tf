###cloud vars
variable "yc_cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
  sensitive   = true
}

variable "yc_folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
  sensitive   = true
}

variable "yc_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "private_subnets" {
  description = "Private subnets configuration"
  type = map(object({
    zone       = string
    cidr_block = string
  }))
  default = {
    "private-a" = {
      zone       = "ru-central1-a"
      cidr_block = "192.168.10.0/24"
    }
    "private-b" = {
      zone       = "ru-central1-b"
      cidr_block = "192.168.20.0/24"
    }
    "private-d" = {
      zone       = "ru-central1-d"
      cidr_block = "192.168.30.0/24"
    }
  }
}

variable "public_subnets" {
  description = "Public subnets configuration"
  type = map(object({
    zone       = string
    cidr_block = string
  }))
  default = {
    "public-a" = {
      zone       = "ru-central1-a"
      cidr_block = "192.168.40.0/24"
    }
    "public-b" = {
      zone       = "ru-central1-b"
      cidr_block = "192.168.50.0/24"
    }
    "public-d" = {
      zone       = "ru-central1-d"
      cidr_block = "192.168.60.0/24"
    }
  }
}

variable "mysql_version" {
  description = "MySQL version"
  type        = string
  default     = "8.0"
}

variable "mysql_user" {
  description = "MySQL username"
  type        = string
  default     = "netology_user"
}

variable "mysql_password" {
  description = "MySQL password"
  type        = string
  sensitive   = true
}

variable "k8s_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.32"
}

variable "k8s_sa_name" {
  description = "Kubernetes service account name"
  type        = string
  default     = "k8s-service-account"
}

variable "k8s_node_min" {
  description = "Minimum number of nodes in node group"
  type        = number
  default     = 3
}

variable "k8s_node_max" {
  description = "Maximum number of nodes in node group"
  type        = number
  default     = 6
}
