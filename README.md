# 📚 Chatbot Asistente Escolar

Un asistente conversacional inteligente desarrollado con **Rasa 3.4.18** y **Docker**, diseñado específicamente para ayudar a estudiantes a gestionar sus actividades académicas, incluyendo recordatorios de trabajos prácticos, parciales y fechas importantes.

## ✨ Características

- 💬 Interfaz conversacional natural
- 📅 Gestión de recordatorios académicos
- 📝 Seguimiento de trabajos prácticos y parciales
- 🗓️ Alertas de fechas importantes
- 🐳 Completamente dockerizado para fácil despliegue
- 💾 Persistencia opcional de datos con PostgreSQL

## 🚀 Requisitos Previos

Antes de comenzar, asegúrate de tener instalado:

- [Docker](https://www.docker.com/get-started) (versión 20.10 o superior)
- [Docker Compose](https://docs.docker.com/compose/install/) (versión 1.29 o superior)

## ⚙️ Instalación y Configuración

### 1. Clonar el Repositorio

```bash
git clone https://github.com/tuusuario/chatbot-asistente-escolar.git
cd chatbot-asistente-escolar
```

### 2. Limpiar Datos Anteriores (Si Aplica)

Si ya tienes una instalación previa, limpia los modelos y datos anteriores:

```bash
rm -rf models/*
rm -rf data/events.db
```

### 3. Entrenar el Modelo

Entrena el modelo de Rasa con tus datos:

```bash
docker compose run --rm rasa train
```

> ⏱️ **Nota:** Este proceso puede tomar algunos minutos dependiendo del tamaño de tus datos de entrenamiento.

Este comando generará un nuevo modelo en la carpeta `models/`.

### 4. Levantar los Servicios

Inicia todos los servicios necesarios:

```bash
docker compose up
```

Esto iniciará los siguientes servicios:
- **Rasa Server** → Motor principal de diálogo (puerto 5005)
- **Rasa Actions** → Servidor de acciones personalizadas (puerto 5055)
- **PostgreSQL** → Base de datos para persistencia (opcional, puerto 5432)

### 5. Probar el Bot

#### Prueba vía API REST

Una vez que los servicios estén corriendo, puedes probar el bot enviando solicitudes HTTP:

```bash
curl -X POST http://localhost:5005/webhooks/rest/webhook \
  -H "Content-Type: application/json" \
  -d '{"sender": "test_user", "message": "Hola"}'
```

## 🧰 Comandos Útiles

### Monitoreo y Logs

Ver logs en tiempo real:

```bash
docker compose logs -f rasa
```

Ver logs de acciones:

```bash
docker compose logs -f rasa-actions
```

### Gestión de Servicios

Parar todos los servicios:

```bash
docker compose down
```

Parar servicios y eliminar volúmenes:

```bash
docker compose down -v
```

### Limpieza Completa

Para eliminar todo (contenedores, volúmenes, modelos y datos):

```bash
docker compose down -v
rm -rf models/*
rm -rf data/events.db
```

### Re-entrenar el Modelo

Para re-entrenar después de cambios en los datos:

```bash
docker compose run --rm rasa train --force
```

## 📁 Estructura del Proyecto

```
chatbot-asistente-escolar/
├── data/                    # Datos de entrenamiento
│   ├── nlu.yml             # Ejemplos de intenciones
│   ├── rules.yml           # Reglas de conversación
│   └── stories.yml         # Historias de entrenamiento
├── actions/                # Acciones personalizadas
│   └── actions.py          # Código de acciones
├── models/                 # Modelos entrenados
├── config.yml              # Configuración de Rasa
├── domain.yml              # Definición del dominio
├── credentials.yml         # Configuración de canales
├── endpoints.yml           # Configuración de endpoints
└── docker-compose.yml      # Configuración de Docker
```

## 🔧 Configuración Avanzada

### Integración con Telegram

Para conectar tu bot con Telegram:

1. Crea un bot en Telegram usando [@BotFather](https://t.me/botfather)
2. Obtén tu token de bot
3. Configura `credentials.yml`:

```yaml
telegram:
  access_token: "TU_TOKEN_DE_BOT"
  verify: "TU_NOMBRE_DE_BOT"
  webhook_url: "https://tu-dominio.com/webhooks/telegram/webhook"
```


## 🐛 Solución de Problemas

### El bot no responde correctamente
- Verifica que el modelo esté entrenado: `ls models/`
- Revisa los logs: `docker compose logs rasa`
- Re-entrena el modelo: `docker compose run --rm rasa train --force`

### Error de conexión a la base de datos
- Asegúrate de que PostgreSQL esté corriendo: `docker compose ps`
- Verifica la configuración en `endpoints.yml`

### Problemas de puertos
- Verifica que los puertos 5005 y 5055 estén disponibles
- Modifica los puertos en `docker-compose.yml` si es necesario


## 📌 Notas Técnicas

- **Versión de Python:** 3.8.10
- **Versión de Rasa:** 3.4.18
- **Ambiente:** Docker containers
- **Persistencia:** PostgreSQL (opcional)

> 💡 **Tip:** No es necesario instalar Rasa localmente, todo el desarrollo y ejecución se maneja através de contenedores Docker.
