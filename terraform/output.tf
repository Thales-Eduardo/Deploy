output "vm_ip" {
  description = "ip da maquina virtual para usar no ssh"
  value       = aws_instance.vm.public_ip
}

