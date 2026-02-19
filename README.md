# Bash Provisioning Lab

Mini-lab de automatización en Bash para aprender y practicar tareas típicas de administración de servidores Linux.

## 📝 Descripción

Este script simula un entorno de **provisionamiento básico**:

- Comprueba que se ejecute como **root**.
- Crea un **usuario** si no existe.
- Instala y habilita **nginx**.
- Verifica que el servicio esté activo.
- Registra todas las acciones en un **log con fecha y hora**.

Es un mini-proyecto pensado para practicar **automatización, scripting y buenas prácticas** antes de trabajar con entornos reales (Proxmox, Ansible, Terraform, etc.).

## 🚀 Uso
sudo ./provision.sh <nombre_usuario>
