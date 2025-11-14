resource "yandex_kms_symmetric_key" "k8s_secrets" {
  name              = "k8s-secrets-key"
  description       = "Key for encrypting Kubernetes secrets"
  default_algorithm = "AES_256"
  rotation_period   = "8760h"
}