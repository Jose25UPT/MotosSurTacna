# Instrucciones de Despliegue - MotosSurTacna

## En el VPS (IP: 138.197.218.131)

### 1. Actualizar código
```bash
git pull origin main
```

### 2. Levantar servicios de base de datos y backend
```bash
docker-compose up -d db backend
```

### 3. Esperar que PostgreSQL esté listo
```bash
# Verificar logs hasta ver "database system is ready"
docker-compose logs db
```

### 4. Cargar datos en la base de datos
```bash
# Este comando YA FUNCIONÓ antes
docker exec -i postgres_tienda_motos psql -U postgres -d tienda_motos < bd/tienda_motos.sql
```

### 5. Levantar el frontend
```bash
docker-compose up -d frontend
```

### 6. Verificar que todo funcione
```bash
# Ver estado de contenedores
docker-compose ps

# Probar API backend
curl http://138.197.218.131:8000/motos

# Probar frontend
# Abrir en navegador: http://138.197.218.131:3000
```

## URLs del proyecto
- **Frontend**: http://138.197.218.131:3000
- **Backend API**: http://138.197.218.131:8000
- **API Motos**: http://138.197.218.131:8000/motos

## Solución de problemas comunes

### Si la BD no levanta:
```bash
docker-compose down
docker volume rm motossurtacna_db_data
docker-compose up -d db
```

### Si hay conflicto de puertos:
```bash
sudo netstat -tlnp | grep 5432
sudo pkill -f postgres
```

### Logs útiles:
```bash
docker-compose logs db
docker-compose logs backend  
docker-compose logs frontend
```