# 🐳 X-NOSE - Dockerfiles

Esta carpeta contiene **SOLO** los Dockerfiles y archivos asociados para cada servicio de X-NOSE.

## 📁 Estructura

```
docker-only/
├── gateway-service/
│   ├── Dockerfile
│   └── .dockerignore
├── auth-service/
│   ├── Dockerfile
│   └── .dockerignore
├── owner-service/
│   ├── Dockerfile
│   └── .dockerignore
├── pet-service/
│   ├── Dockerfile
│   └── .dockerignore
├── alert-service/
│   ├── Dockerfile
│   └── .dockerignore
├── ai-service/
│   ├── Dockerfile
│   └── .dockerignore
└── frontend/
    ├── Dockerfile
    └── .dockerignore
```

## 🚀 Servicios

### **Backend Services (Spring Boot/Kotlin)**
- **Gateway Service** - Puerto 8080
- **Auth Service** - Puerto 8081
- **Owner Service** - Puerto 8082
- **Pet Service** - Puerto 8083
- **Alert Service** - Puerto 8084

### **AI Service (Python/FastAPI)**
- **AI Service** - Puerto 8000

### **Frontend (React Native/Expo)**
- **Frontend** - Puerto 19000

## 🔧 Tecnologías

- **Java**: OpenJDK 17
- **Maven**: Para servicios Spring Boot
- **Python**: 3.11 para AI Service
- **Node.js**: 18 para Frontend
- **TensorFlow**: Para reconocimiento biométrico
- **OpenCV**: Para procesamiento de imágenes

## 📝 Uso

Cada carpeta contiene:
- `Dockerfile` - Configuración de la imagen Docker
- `.dockerignore` - Archivos a excluir del build

## 🎯 Propósito

Estos Dockerfiles están optimizados para:
- **Producción** en Render
- **Builds rápidos** con cache
- **Imágenes ligeras**
- **Seguridad** con usuarios no-root 