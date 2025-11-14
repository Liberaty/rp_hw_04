resource "yandex_vpc_network" "network" {
  name = "netology-network"
}

resource "yandex_vpc_subnet" "private" {
  for_each       = var.private_subnets
  name           = each.key
  zone           = each.value.zone
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = [each.value.cidr_block]
}

resource "yandex_vpc_subnet" "public" {
  for_each       = var.public_subnets
  name           = each.key
  zone           = each.value.zone
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = [each.value.cidr_block]
  route_table_id = yandex_vpc_route_table.public.id
}

resource "yandex_vpc_gateway" "nat_gateway" {
  name = "nat-gateway"
  shared_egress_gateway {}
}

resource "yandex_vpc_route_table" "public" {
  name       = "public-route-table"
  network_id = yandex_vpc_network.network.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id        = yandex_vpc_gateway.nat_gateway.id
  }
}