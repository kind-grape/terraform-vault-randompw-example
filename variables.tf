variable "vault_address" {
  type        = string
  default = "http://127.0.0.1:8200"
}

variable "vault_token" {
  type        = string
}

variable "vault_namespace" {
  type        = string
  default = "root"
}

variable "db_type" {

}

variable "db_env" {
    
}

variable "db_customer_code" {
    
}

variable "db_instance_name" {
    
}

### flag for initial deployment ###
variable "init_deploy" {
    type = bool
    default = true
}