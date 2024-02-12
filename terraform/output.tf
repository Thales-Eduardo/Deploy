output "vm_ip" {
  description = "ip da maquina virtual para usar no ssh"
  value       = aws_instance.vm.public_ip
}

output "eip_public_ip" {
  description = "ip fixo do elastic ip"
  value       = aws_eip.ip_elastico.public_ip
}
