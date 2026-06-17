# 📱 DOCUMENTACIÓN DE APIs PARA APLICACIÓN MÓVIL
# Sistema de Control de Asistencia y Planillas
# ================================================================

## 🔐 BASE URL
```
https://34.68.203.103/
```

## 📋 AUTENTICACIÓN
Todas las APIs (excepto login) requieren token de autenticación en el header:
```
Authorization: Token {token_aqui}
```

---

## 1️⃣ AUTENTICACIÓN Y **USUARIOS**

### 1.1 LOGIN
**Endpoint:** `POST /api/auth/login/`

**Request:**
```json
{
  "email": "supervisor@ejemplo.com",
  "password": "password123"
}
```

**Response (200 OK):**
```json
{
  "token": "9944b09199c62bcf9418ad846dd0e4bbdfc6ee4b",
  "user": {
    "id": 1,
    "email": "supervisor@ejemplo.com",
    "nombre": "Juan",
    "apellido": "Pérez",
    "nombre_completo": "Juan Pérez",
    "rol": "supervisor",
    "activo": true,
    "telefono": "89451234",
    "cedula": "001-140589-0012K"
  }
}
```

**Errores:**
- `400 Bad Request` - Credenciales incorrectas
- `401 Unauthorized` - Usuario inactivo

---

### 1.2 LOGOUT
**Endpoint:** `POST /api/auth/logout/`

**Headers:**
```
Authorization: Token {token}
```

**Response (200 OK):**
```json
{
  "message": "Sesión cerrada exitosamente"
}
```

---

### 1.3 OBTENER PERFIL ACTUAL
**Endpoint:** `GET /api/auth/me/`

**Headers:**
```
Authorization: Token {token}
```

**Response (200 OK):**
```json
{
  "id": 1,
  "email": "supervisor@ejemplo.com",
  "nombre": "Juan",
  "apellido": "Pérez",
  "nombre_completo": "Juan Pérez",
  "rol": "supervisor",
  "activo": true,
  "telefono": "89451234",
  "cedula": "001-140589-0012K",
  "foto": "/media/usuarios/foto.jpg"
}
```

---

### 1.4 CAMBIAR CONTRASEÑA
**Endpoint:** `POST /api/auth/cambiar-password/`

**Headers:**
```
Authorization: Token {token}
```

**Request:**
```json
{
  "old_password": "password123",
  "new_password": "nuevopassword456"
}
```

**Response (200 OK):**
```json
{
  "message": "Contraseña actualizada exitosamente"
}
```

---

## 2️⃣ PROYECTOS

### 2.1 LISTAR PROYECTOS ACTIVOS
**Endpoint:** `GET /api/proyectos/`

**Headers:**
```
Authorization: Token {token}
```

**Query Params:**
```
?activo=true
```

**Response (200 OK):**
```json
[
  {
    "id": 1,
    "nombre": "Torre Norte",
    "codigo": "TN-2025-001",
    "ubicacion": "Managua, Nicaragua",
    "latitud": 12.1364,
    "longitud": -86.2514,
    "radio_geocerca": 100,
    "estado": "en_proceso",
    "activo": true,
    "fecha_inicio": "2025-01-15",
    "fecha_fin": "2025-12-31",
    "supervisor": {
      "id": 2,
      "nombre_completo": "María López"
    }
  }
]
```

---

### 2.2 OBTENER DETALLES DE PROYECTO
**Endpoint:** `GET /api/proyectos/{id}/`

**Headers:**
```
Authorization: Token {token}
```

**Response (200 OK):**
```json
{
  "id": 1,
  "nombre": "Torre Norte",
  "codigo": "TN-2025-001",
  "descripcion": "Construcción de torre residencial",
  "ubicacion": "Managua, Nicaragua",
  "latitud": 12.1364,
  "longitud": -86.2514,
  "radio_geocerca": 100,
  "estado": "en_proceso",
  "activo": true,
  "fecha_inicio": "2025-01-15",
  "fecha_fin": "2025-12-31",
  "hora_entrada_esperada": "07:00",
  "hora_salida_esperada": "17:00",
  "dias_laborales": ["lunes", "martes", "miercoles", "jueves", "viernes", "sabado"],
  "supervisor": {
    "id": 2,
    "nombre_completo": "María López",
    "telefono": "89457890"
  },
  "personal_asignado": 25,
  "contratistas_asignados": 3
}
```

---

## 3️⃣ TRABAJADORES

### 3.1 BUSCAR TRABAJADOR POR CÉDULA
**Endpoint:** `GET /api/trabajadores/por-cedula/{cedula}/`

**Headers:**
```
Authorization: Token {token}
```

**Ejemplo:**
```
GET /api/trabajadores/por-cedula/001-140589-0012K/
```

**Response (200 OK):**
```json
{
  "id": 15,
  "numero_cedula": "001-140589-0012K",
  "nombre": "Carlos",
  "apellido": "Martínez",
  "nombre_completo": "Carlos Martínez",
  "telefono": "89451234",
  "estado": "activo",
  "cargo": "Albañil",
  "area": "Construcción",
  "salario_base": 8000.00,
  "foto_cedula": "/media/trabajadores/cedula_15.jpg",
  "proyecto_actual": {
    "id": 1,
    "nombre": "Torre Norte"
  }
}
```

**Errores:**
- `404 Not Found` - Trabajador no encontrado

---

### 3.2 VALIDAR IDENTIFICACIÓN (QR o Cédula)
**Endpoint:** `POST /api/trabajadores/validar-identificacion/`

**Headers:**
```
Authorization: Token {token}
```

**Request:**
```json
{
  "codigo": "001-140589-0012K"
}
```
ó
```json
{
  "codigo": "0362284301��������..."
}
```

**Response (200 OK):**
```json
{
  "valido": true,
  "tipo_codigo": "CEDULA_FISICA",
  "trabajador": {
    "id": 15,
    "numero_cedula": "001-140589-0012K",
    "nombre": "Carlos",
    "apellido": "Martínez",
    "nombre_completo": "Carlos Martínez",
    "telefono": "89451234",
    "estado": "activo",
    "cargo": "Albañil",
    "proyecto_actual": {
      "id": 1,
      "nombre": "Torre Norte"
    }
  },
  "datos_extraidos": {
    "apellidos": "MARTINEZ",
    "nombres": "CARLOS ANTONIO",
    "cedula": "001-140589-0012K",
    "sexo": "M",
    "fecha_nacimiento": "14/05/1989"
  }
}
```

**Errores:**
- `404 Not Found` - Trabajador no encontrado
- `400 Bad Request` - Código inválido

---

### 3.3 LISTAR TRABAJADORES ACTIVOS
**Endpoint:** `GET /api/trabajadores/activos/`

**Headers:**
```
Authorization: Token {token}
```

**Response (200 OK):**
```json
[
  {
    "id": 15,
    "numero_cedula": "001-140589-0012K",
    "nombre_completo": "Carlos Martínez",
    "cargo": "Albañil",
    "estado": "activo"
  },
  {
    "id": 16,
    "numero_cedula": "001-250890-0015P",
    "nombre_completo": "Ana García",
    "cargo": "Oficial",
    "estado": "activo"
  }
]
```

---

## 4️⃣ ASISTENCIAS (REGISTRO DE ENTRADA/SALIDA)

### 4.1 MARCAR ENTRADA (CHECK-IN)
**Endpoint:** `POST /api/asistencias/check-in/`

**Headers:**
```
Authorization: Token {token}
```

**Request:**
```json
{
  "trabajador_cedula": "001-140589-0012K",
  "proyecto_id": 1,
  "latitud": 12.1365,
  "longitud": -86.2515,
  "foto_entrada": "base64_encoded_image_string",
  "notas": "Llegada puntual"
}
```

**Response (200 OK):**
```json
{
  "id": 125,
  "trabajador": {
    "id": 15,
    "nombre_completo": "Carlos Martínez"
  },
  "proyecto": {
    "id": 1,
    "nombre": "Torre Norte"
  },
  "fecha": "2025-01-15",
  "hora_entrada": "07:05:30",
  "latitud_entrada": 12.1365,
  "longitud_entrada": -86.2515,
  "estado": "abierto",
  "dentro_geocerca": true,
  "validado": false,
  "mensaje": "Entrada registrada exitosamente"
}
```

**Errores:**
- `400 Bad Request` - Ya tiene asistencia hoy
- `404 Not Found` - Trabajador o proyecto no encontrado
- `403 Forbidden` - Fuera de geocerca (se registra pero se marca)

---

### 4.2 MARCAR SALIDA (CHECK-OUT)
**Endpoint:** `POST /api/asistencias/check-out/`

**Headers:**
```
Authorization: Token {token}
```

**Request:**
```json
{
  "asistencia_id": 125,
  "latitud": 12.1366,
  "longitud": -86.2516,
  "foto_salida": "base64_encoded_image_string",
  "notas": "Trabajo completado"
}
```

**Response (200 OK):**
```json
{
  "id": 125,
  "trabajador": {
    "id": 15,
    "nombre_completo": "Carlos Martínez"
  },
  "proyecto": {
    "id": 1,
    "nombre": "Torre Norte"
  },
  "fecha": "2025-01-15",
  "hora_entrada": "07:05:30",
  "hora_salida": "17:10:25",
  "horas_normales": 10.0,
  "horas_extras": 0.0,
  "estado": "cerrado",
  "dentro_geocerca_salida": true,
  "validado": false,
  "mensaje": "Salida registrada exitosamente"
}
```

**Errores:**
- `400 Bad Request` - Asistencia no encontrada o ya cerrada
- `403 Forbidden` - Fuera de geocerca en salida

---

### 4.3 LISTAR ASISTENCIAS
**Endpoint:** `GET /api/asistencias/`

**Headers:**
```
Authorization: Token {token}
```

**Query Params:**
```
?fecha=2025-01-15
&proyecto=1
&trabajador=15
&estado=abierto
```

**Response (200 OK):**
```json
[
  {
    "id": 125,
    "trabajador": {
      "id": 15,
      "nombre_completo": "Carlos Martínez",
      "cargo": "Albañil"
    },
    "proyecto": {
      "id": 1,
      "nombre": "Torre Norte"
    },
    "fecha": "2025-01-15",
    "hora_entrada": "07:05:30",
    "hora_salida": "17:10:25",
    "horas_normales": 10.0,
    "horas_extras": 0.0,
    "estado": "cerrado",
    "validado": false,
    "dentro_geocerca": true
  }
]
```

---

### 4.4 SINCRONIZAR ASISTENCIAS (Modo Offline)
**Endpoint:** `POST /api/asistencias/sincronizar/`

**Headers:**
```
Authorization: Token {token}
```

**Request:**
```json
{
  "asistencias": [
    {
      "trabajador_cedula": "001-140589-0012K",
      "proyecto_id": 1,
      "fecha": "2025-01-15",
      "hora_entrada": "07:05:30",
      "latitud_entrada": 12.1365,
      "longitud_entrada": -86.2515,
      "tipo": "entrada"
    },
    {
      "trabajador_cedula": "002-112589-0012K",
      "proyecto_id": 1,
      "fecha": "2025-01-15",
      "hora_entrada": "07:05:30",
      "latitud_entrada": 12.1365,
      "longitud_entrada": -86.2515,
      "tipo": "entrada"
    },
    {
      "asistencia_temp_id": 1,
      "hora_salida": "17:10:25",
      "latitud_salida": 12.1366,
      "longitud_salida": -86.2516,
      "tipo": "salida"
    }
  ]
}
```

**Response (200 OK):**
```json
{
  "sincronizadas": 2,
  "errores": 0,
  "resultados": [
    {
      "temp_id": null,
      "asistencia_id": 125,
      "estado": "exitoso",
      "mensaje": "Entrada registrada"
    },
    {
      "temp_id": 1,
      "asistencia_id": 125,
      "estado": "exitoso",
      "mensaje": "Salida registrada"
    }
  ]
}
```

---

## 5️⃣ VALIDACIÓN DE ASISTENCIAS (SUPERVISOR)

### 5.1 LISTAR ASISTENCIAS PENDIENTES DE VALIDAR
**Endpoint:** `GET /api/asistencias/?validado=false&proyecto={proyecto_id}`

**Headers:**
```
Authorization: Token {token}
```

**Response:** (Igual que 4.3)

---

### 5.2 VALIDAR ASISTENCIA
**Endpoint:** `POST /api/asistencias/{id}/validar/`

**Headers:**
```
Authorization: Token {token}
```

**Request:**
```json
{
  "horas_normales": 10.0,
  "horas_extras": 1.5,
  "notas_validacion": "Aprobado, llegó temprano"
}
```

**Response (200 OK):**
```json
{
  "id": 125,
  "validado": true,
  "validado_por": {
    "id": 2,
    "nombre_completo": "María López"
  },
  "fecha_validacion": "2025-01-15T18:30:00Z",
  "horas_normales": 10.0,
  "horas_extras": 1.5,
  "mensaje": "Asistencia validada exitosamente"
}
```

---

## 6️⃣ CONFIGURACIÓN Y DATOS MAESTROS

### 6.1 OBTENER TIPO DE CAMBIO ACTUAL
**Endpoint:** `GET /api/tipo-cambio/actual/`

**Headers:**
```
Authorization: Token {token}
```

**Response (200 OK):**
```json
{
  "fecha": "2025-01-15",
  "valor": 36.60,
  "moneda": "USD"
}
```

---

## 📊 CÓDIGOS DE ESTADO HTTP

| Código | Significado |
|--------|-------------|
| 200 | OK - Solicitud exitosa |
| 201 | Created - Recurso creado |
| 400 | Bad Request - Datos inválidos |
| 401 | Unauthorized - No autenticado |
| 403 | Forbidden - No autorizado |
| 404 | Not Found - Recurso no encontrado |
| 500 | Internal Server Error - Error del servidor |

---

## 🔄 FLUJO COMPLETO DE LA APP MÓVIL

```
1. LOGIN
   POST /api/auth/login/
   → Guardar token

2. OBTENER PROYECTOS ASIGNADOS
   GET /api/proyectos/?activo=true
   → Seleccionar proyecto

3. ESCANEAR CÉDULA
   POST /api/trabajadores/validar-identificacion/
   → Obtener datos del trabajador

4. VALIDAR GEOCERCA
   (Calcular distancia en app)
   
5. MARCAR ENTRADA
   POST /api/asistencias/check-in/
   → Guardar asistencia_id

6. MARCAR SALIDA
   POST /api/asistencias/check-out/
   → Cerrar turno

7. MODO OFFLINE (opcional)
   → Guardar en SQLite local
   → Sincronizar cuando haya internet:
   POST /api/asistencias/sincronizar/
```

---

## 🔐 SEGURIDAD

1. **Token de Autenticación:**
   - Incluir en header `Authorization: Token {token}`
   - Renovar si expira (re-login)

2. **HTTPS:**
   - Todas las peticiones deben usar HTTPS

3. **Geocerca:**
   - Validar en servidor Y en cliente
   - Alertar si está fuera pero permitir registro

4. **Fotos:**
   - Enviar en base64
   - Tamaño máximo: 5MB por foto

---

## 📱 EJEMPLO COMPLETO EN LA APP

```dart
// 1. Login
final response = await http.post(
  Uri.parse('$baseUrl/api/auth/login/'),
  headers: {'Content-Type': 'application/json'},
  body: jsonEncode({
    'email': email,
    'password': password,
  }),
);

final data = jsonDecode(response.body);
final token = data['token'];

// 2. Check-in
final checkInResponse = await http.post(
  Uri.parse('$baseUrl/api/asistencias/check-in/'),
  headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Token $token',
  },
  body: jsonEncode({
    'trabajador_cedula': cedula,
    'proyecto_id': proyectoId,
    'latitud': latitud,
    'longitud': longitud,
    'foto_entrada': fotoBase64,
  }),
);
```