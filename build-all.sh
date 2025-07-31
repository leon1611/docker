#!/bin/bash

echo "🐳 CONSTRUYENDO TODAS LAS IMÁGENES DOCKER - X-NOSE"
echo "================================================="
echo ""

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Función para imprimir mensajes
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Función para construir imagen
build_service() {
    local service_name=$1
    local dockerfile_path=$2
    
    print_status "Construyendo $service_name..."
    
    if docker build -t "xnose-$service_name:latest" "$dockerfile_path"; then
        print_success "$service_name construido exitosamente"
    else
        print_error "Error construyendo $service_name"
        return 1
    fi
    
    echo ""
}

# Función principal
main() {
    print_status "Iniciando construcción de todas las imágenes..."
    echo ""
    
    # Lista de servicios a construir
    services=(
        "gateway-service:./gateway-service"
        "auth-service:./auth-service"
        "owner-service:./owner-service"
        "pet-service:./pet-service"
        "alert-service:./alert-service"
        "ai-service:./ai-service"
        "frontend:./frontend"
    )
    
    # Construir cada servicio
    for service in "${services[@]}"; do
        IFS=':' read -r service_name dockerfile_path <<< "$service"
        build_service "$service_name" "$dockerfile_path"
    done
    
    print_success "¡Todas las imágenes construidas!"
    echo ""
    
    # Mostrar imágenes construidas
    print_status "Imágenes disponibles:"
    docker images | grep "xnose-"
    echo ""
    
    print_status "Para ejecutar un servicio:"
    echo "docker run -p 8080:8080 xnose-gateway-service:latest"
    echo "docker run -p 8081:8081 xnose-auth-service:latest"
    echo "docker run -p 8082:8082 xnose-owner-service:latest"
    echo "docker run -p 8083:8083 xnose-pet-service:latest"
    echo "docker run -p 8084:8084 xnose-alert-service:latest"
    echo "docker run -p 8000:8000 xnose-ai-service:latest"
    echo "docker run -p 19000:19000 xnose-frontend:latest"
}

# Ejecutar función principal
main 