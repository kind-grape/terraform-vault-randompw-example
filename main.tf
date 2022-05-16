data "vault_generic_secret" "generate_db_pw" {
    count = var.init_deploy ? 1 : 0
    path = "sys/policies/password/db_root/generate"
}

locals {
    generated_pw = var.init_deploy ? data.vault_generic_secret.generate_db_pw[0].data.password : null
}

resource "vault_generic_secret" "write_pw2vault" {
  count = var.init_deploy ? 1 : 0
  path = "database/${var.db_type}/${var.db_env}/${var.db_customer_code}/${var.db_instance_name}"

  data_json = jsonencode(
    {
        "password":  local.generated_pw,
    }
  )
}

# read kv secret rds master cred 
data "vault_generic_secret" "get_db_cred" {
    path = "database/${var.db_type}/${var.db_env}/${var.db_customer_code}/${var.db_instance_name}"
    depends_on = [
      vault_generic_secret.write_pw2vault
    ]
}

### to use the data in the subsequent db build module 
/*
module "postgressql_enterprise_module {
  source = .... 
  ... 
  postgres_database_password = data.vault_generic_secret.get_db_cred.data.password
}"
*/