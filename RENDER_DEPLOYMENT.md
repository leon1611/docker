# 🚀 X-NOSE - Despliegue en Render

Esta guía explica cómo desplegar la aplicación X-NOSE en Render usando el archivo `render.yaml`.

## 📋 Tabla de Contenidos

- [Configuración](#configuración)
- [Servicios](#servicios)
- [Base de Datos](#base-de-datos)
- [Variables de Entorno](#variables-de-entorno)
- [Despliegue](#despliegue)
- [URLs de Producción](#urls-de-producción)
- [Monitoreo](#monitoreo)
- [Troubleshooting](#troubleshooting)

## ⚙️ Configuración

### Archivo `render.yaml`

El archivo `render.yaml` está configurado para desplegar automáticamente todos los servicios de X-NOSE en Render.

```yaml
# Configuración principal
databases:
  - name: xnose-postgres
    databaseName: xnose_db
    user: xnose_user
    plan: free

services:
  # 7 servicios web configurados
  # 1 base de datos PostgreSQL
```

## 🐳 Servicios

### Backend Services (Spring Boot/Kotlin)

| Servicio | Puerto | URL | Health Check |
|----------|--------|-----|--------------|
| **Gateway Service** | 8080 | `https://xnose-gateway.onrender.com` | `/actuator/health` |
| **Auth Service** | 8081 | `https://xnose-auth.onrender.com` | `/actuator/health` |
| **Owner Service** | 8082 | `https://xnose-owner.onrender.com` | `/actuator/health` |
| **Pet Service** | 8083 | `https://xnose-pet.onrender.com` | `/actuator/health` |
| **Alert Service** | 8084 | `https://xnose-alert.onrender.com` | `/actuator/health` |

### AI Service (Python/FastAPI)

| Servicio | Puerto | URL | Health Check |
|----------|--------|-----|--------------|
| **AI Service** | 8000 | `https://xnose-ai.onrender.com` | `/health` |

### Frontend (React Native/Expo)

| Servicio | Puerto | URL | Health Check |
|----------|--------|-----|--------------|
| **Frontend** | 19000 | `https://xnose-frontend.onrender.com` | `/` |

## 🗄️ Base de Datos

### PostgreSQL Configuration

```yaml
databases:
  - name: xnose-postgres
    databaseName: xnose_db
    user: xnose_user
    plan: free
```

**Características:**
- ✅ Base de datos PostgreSQL compartida
- ✅ Conexión automática para todos los servicios
- ✅ Plan gratuito de Render
- ✅ Backup automático

## 🔧 Variables de Entorno

### Variables Automáticas

Render configura automáticamente estas variables para cada servicio:

```bash
# Base de datos (configurado automáticamente)
DATABASE_URL=postgresql://user:pass@host:port/db
DATABASE_USERNAME=xnose_user
DATABASE_PASSWORD=auto_generated

# Perfil de Spring Boot
SPRING_PROFILES_ACTIVE=production

# Puertos específicos
SERVER_PORT=8080-8084 (según servicio)
PORT=8000 (AI Service)
PORT=19000 (Frontend)
```

### Variables Específicas por Servicio

#### Auth Service
```bash
JWT_SECRET=auto_generated_by_render
```

#### Frontend
```bash
NODE_ENV=production
REACT_APP_API_URL=https://xnose-gateway.onrender.com
REACT_APP_AI_SERVICE_URL=https://xnose-ai.onrender.com
```

## 🚀 Despliegue

### Paso 1: Preparar el Repositorio

1. Asegúrate de que el archivo `render.yaml` esté en la raíz del repositorio
2. Verifica que todos los Dockerfiles estén en sus respectivas carpetas:
   ```
   ├── gateway-service/Dockerfile
   ├── auth-service/Dockerfile
   ├── owner-service/Dockerfile
   ├── pet-service/Dockerfile
   ├── alert-service/Dockerfile
   ├── ai-service/Dockerfile
   └── frontend/Dockerfile
   ```

### Paso 2: Conectar a Render

1. Ve a [render.com](https://render.com)
2. Crea una nueva cuenta o inicia sesión
3. Haz clic en "New +" → "Blueprint"
4. Conecta tu repositorio de GitHub/GitLab
5. Render detectará automáticamente el `render.yaml`

### Paso 3: Configurar Despliegue

1. Render mostrará todos los servicios configurados
2. Revisa la configuración de cada servicio
3. Haz clic en "Apply" para iniciar el despliegue
4. Render construirá y desplegará todos los servicios automáticamente

### Paso 4: Verificar Despliegue

1. Monitorea el progreso en el dashboard de Render
2. Verifica que todos los health checks pasen
3. Prueba las URLs de cada servicio

## 🌐 URLs de Producción

Una vez desplegado, tendrás acceso a estas URLs:

### API Gateway
```
https://xnose-gateway.onrender.com
```

### Servicios Individuales
```
https://xnose-auth.onrender.com
https://xnose-owner.onrender.com
https://xnose-pet.onrender.com
https://xnose-alert.onrender.com
https://xnose-ai.onrender.com
```

### Frontend
```
https://xnose-frontend.onrender.com
```

## 📊 Monitoreo

### Health Checks

Cada servicio tiene configurado un health check:

- **Spring Boot Services**: `/actuator/health`
- **AI Service**: `/health`
- **Frontend**: `/`

### Logs

Accede a los logs desde el dashboard de Render:
1. Selecciona el servicio
2. Ve a la pestaña "Logs"
3. Monitorea errores y performance

### Métricas

Render proporciona métricas básicas:
- CPU usage
- Memory usage
- Response time
- Request count

## 🔍 Troubleshooting

### Problemas Comunes

#### 1. Build Fails
```bash
# Verificar Dockerfiles
docker build -t test ./gateway-service
```

#### 2. Health Check Fails
```bash
# Verificar endpoints
curl https://xnose-gateway.onrender.com/actuator/health
```

#### 3. Database Connection Issues
```bash
# Verificar variables de entorno en Render dashboard
DATABASE_URL
DATABASE_USERNAME
DATABASE_PASSWORD
```

#### 4. Service Communication
```bash
# Verificar URLs entre servicios
REACT_APP_API_URL=https://xnose-gateway.onrender.com
REACT_APP_AI_SERVICE_URL=https://xnose-ai.onrender.com
```

### Comandos Útiles

#### Verificar Estado de Servicios
```bash
# Health checks
curl -f https://xnose-gateway.onrender.com/actuator/health
curl -f https://xnose-ai.onrender.com/health
```

#### Verificar Base de Datos
```bash
# Desde cualquier servicio Spring Boot
curl https://xnose-gateway.onrender.com/actuator/health
# Debería mostrar estado de DB
```

## 📝 Notas Importantes

### Plan Gratuito de Render
- ⚠️ Los servicios se "duermen" después de 15 minutos de inactividad
- ⚠️ El primer request puede tardar 30-60 segundos en "despertar"
- ⚠️ Límite de 750 horas de ejecución por mes

### Escalabilidad
Para producción, considera:
- Actualizar a planes pagados
- Configurar auto-scaling
- Implementar CDN para el frontend
- Usar Redis para cache

### Seguridad
- ✅ Variables de entorno seguras
- ✅ JWT secret auto-generado
- ✅ HTTPS automático
- ✅ Base de datos aislada

## 🎯 Próximos Pasos

1. **Configurar dominio personalizado**
2. **Implementar CI/CD pipeline**
3. **Configurar monitoreo avanzado**
4. **Optimizar performance**
5. **Implementar backup strategy**

---

## 📞 Soporte

Si tienes problemas con el despliegue:

1. Revisa los logs en Render dashboard
2. Verifica la configuración del `render.yaml`
3. Consulta la [documentación de Render](https://render.com/docs)
4. Revisa los health checks de cada servicio

**¡X-NOSE está listo para producción en Render! 🚀** 