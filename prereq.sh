#!/bin/bash

export VAULT_ADDR="http://127.0.0.1:8200"
export VAULT_TOKEN="s.hpjeGrOvFGIgcJWSF2Mv73vp"


# enable gcp secret engine 
vault login $VAULT_TOKEN
vault secrets enable -path=database kv-v2

# create a password policy 
tee example_pw_policy.hcl <<EOF
length=10

rule "charset" {
  charset = "abcdefghijklmnopqrstuvwxyz"
  min-chars = 1
}

rule "charset" {
  charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  min-chars = 1
}

rule "charset" {
  charset = "0123456789"
  min-chars = 1
}

rule "charset" {
  charset = "!@#$%^&*"
  min-chars = 1
}
EOF

# upload the pw policy 
vault write sys/policies/password/db_root policy=@example_pw_policy.hcl