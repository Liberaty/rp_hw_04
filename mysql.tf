resource "yandex_mdb_mysql_cluster" "mysql" {
  name                = "netology-mysql-cluster"
  environment         = "PRESTABLE"
  network_id          = yandex_vpc_network.network.id
  version             = var.mysql_version
  deletion_protection = true

  resources {
    resource_preset_id = "b2.medium"
    disk_type_id      = "network-ssd"
    disk_size         = 20
  }

  backup_window_start {
    hours   = 23
    minutes = 59
  }

  maintenance_window {
    type = "ANYTIME"
  }

  dynamic "host" {
    for_each = var.private_subnets
    content {
      zone      = host.value.zone
      subnet_id = yandex_vpc_subnet.private[host.key].id
    }
  }
}

resource "yandex_mdb_mysql_database" "db" {
  cluster_id = yandex_mdb_mysql_cluster.mysql.id
  name       = "netology_db"
}

resource "yandex_mdb_mysql_user" "user" {
  cluster_id = yandex_mdb_mysql_cluster.mysql.id
  name       = var.mysql_user
  password   = var.mysql_password

  permission {
    database_name = yandex_mdb_mysql_database.db.name
    roles        = ["ALL"]
  }
}