variable "instance_name" {
  type = string
  default = "instance_jenkins_server_antonio"
  description = "Instance name"
}

variable "region" {
  type = string
  description = "AWS region"
  default = "eu-west-3"
}

variable "instance_type" {
  type = string
  description = "Instance type"
  default = "t2.large"
}

variable "key_name" {
  type = string
  default = "tp_dev_ynov"
}

