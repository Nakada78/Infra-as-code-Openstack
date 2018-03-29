provider "openstack" {
  domain_name = "Default"
  user_name   = "admin"
  tenant_name = "alt_demo"
  password    = "root"
  auth_url    = "http://172.16.180.250/identity/v3"
}

resource "openstack_compute_keypair_v2" "test-keypair" {
  name       = "test2"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDZgPbmntkka1vXhCZ8UY2Kk5/wM7cHpIOT6zhs3CWUVEQ6YQoH028JoB1XjlpHHvMbclPwWF3qtZ4Dg/f3F+ijv7cAx3N9FYqoD2BKRhz7vulHatbZLeKFRwwuoiDHBofNP07NTppkgLMFC8zOEW7RZ8ls+UX9vfXSJbni5jgTbEHvtrwqzoaTxhc58T1QhxQw6sHi/3ppkBKchoXaxSZNHU3ORU46EQi761m0Erb3R+3obmFXryi4QtylWFr2uKKWy2ng4AlBhfubxS5sX+/cJXGvW7N2xUsoviFOjc+oMfeRwvz+AHSl3U0zXV7l4m4gieIJsmC+I6XNSW4Z8NnZ ubuntu@ubuntu-ctl"
}


resource "openstack_networking_network_v2" "reseau-test2" {
  name           = "my-net"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "subnet-test2" {
  name       = "my-subnet"
  network_id = "${openstack_networking_network_v2.reseau-test2.id}"
  cidr       = "192.168.0.0/24"
  ip_version = 4
}

resource "openstack_networking_router_v2" "router_1" {
  name             = "my-router"
  external_gateway = "5acfb5ae-15ab-464a-90bc-83afcadb23df"
}

resource "openstack_networking_router_interface_v2" "router_interface_1" {
  router_id = "${openstack_networking_router_v2.router_1.id}"
  subnet_id = "${openstack_networking_subnet_v2.subnet-test2.id}"
}

resource "openstack_compute_secgroup_v2" "secgroup-test" {
  name        = "secgroup-test"
  description = "a security group"

  rule {
    from_port   = 22
    to_port     = 22
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }
}
