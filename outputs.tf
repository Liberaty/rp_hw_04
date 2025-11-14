output "mysql_cluster_id" {
  value = yandex_mdb_mysql_cluster.mysql.id
}

output "mysql_hosts" {
  value = yandex_mdb_mysql_cluster.mysql.host.*.fqdn
}

output "database_name" {
  value = yandex_mdb_mysql_database.db.name
}

output "mysql_username" {
  value = var.mysql_user
}

output "k8s_cluster_id" {
  value = yandex_kubernetes_cluster.k8s.id
}

output "k8s_external_v4_endpoint" {
  value = yandex_kubernetes_cluster.k8s.master[0].external_v4_endpoint
}

output "phpmyadmin_lb_ip" {
  value = kubernetes_service.phpmyadmin.status.0.load_balancer.0.ingress.0.ip
}