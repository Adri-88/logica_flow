# Script para sincronizar el repositorio local con el remoto de GitHub
# Uso: ejecutar en PowerShell desde la raíz del repo después de instalar Git

# Configura nombre y correo si no están configurados (modificar según corresponda)
# git config --global user.name "Tu Nombre"
# git config --global user.email "tu@correo.com"

# Inicializar repo (solo si no existe .git)
if (-not (Test-Path .git)) {
    git init
}

# Asegurar rama principal llamada main
git branch -M main

# Añadir remoto (si ya existe, actualizar URL)
$remoteUrl = 'https://github.com/Adri-88/logica_flow.git'
$existing = git remote get-url origin 2>$null
if ($LASTEXITCODE -eq 0) {
    git remote set-url origin $remoteUrl
} else {
    git remote add origin $remoteUrl
}

# Añadir y commitear cambios
git add -A
if (git diff --cached --quiet) {
    Write-Output "No hay cambios por commitear."
} else {
    git commit -m "Initial commit"
}

# Push al remoto
git push -u origin main

Write-Output "Script terminado. Si el push falló, autentica con GitHub (token o credenciales)."