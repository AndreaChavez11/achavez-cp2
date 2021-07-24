variable "ip_master" {
  type = string
  description = "Ip asignada al nodo master"
  default = "10.0.1.10" 
}

variable "ip_nfs" {
  type = string
  description = "Ip asignada al nfs"
  default = "10.0.1.13"
}

variable "ip_worker1" {
  type = string
  description = "Ip asignada al worker1"
  default = "10.0.1.11"
}

variable "ip_worker2" {
  type = string
  description = "Ip asignada al worker1"
  default = "10.0.1.12"
}

variable "sizecpu2" {
  type = string
  description = "Tamano maquina 2 cpu"
  default = "Standard_D2_v3"
}

variable "sizecpu1" {
  type = string
  description = "Tamano maquina 2 cpu"
  default = "Standard_D1_v2"
}

