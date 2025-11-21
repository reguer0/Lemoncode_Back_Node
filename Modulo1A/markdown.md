# 📄 Modelo de Datos -- Portal de E-Learning

**Documentación del modelado**

## 1. Introducción

El objetivo de este modelado es diseñar una base de datos eficiente para
un portal de e-learning orientado al mundo de la programación. El
sistema debe gestionar cursos, vídeos, artículos, autores y categorías,
asegurando un buen rendimiento en lectura sin generar una base de datos
innecesariamente compleja o pesada.

## 2. Objetivos del modelado

-   Evitar duplicidad de información.\
-   Mantener un diseño claro, normalizado y fácil de escalar con el
    tiempo.\
-   Reducir el tamaño de la base de datos almacenando únicamente los
    identificadores de contenido externo (videos en S3 y artículos en
    CMS).\
-   Facilitar consultas eficientes en las páginas más visitadas: cursos,
    vídeos y homepage.

## 3. Tablas Generadas y Razón de su Existencia

### 🟩 1. `autores`

Contiene la información básica de los autores.\
Biografía almacenada mediante GUID externo para reducir tamaño.\
**Razón:** evitar duplicados y reducir peso.

### 🟦 2. `tematicas`

Categorías principales del portal.\
**Razón:** evita duplicar categorías en cada vídeo.

### 🟨 3. `cursos`

Información principal del curso con GUID a contenido externo.\
**Razón:** mantener ligera la BD.

### 🟫 4. `cursoAutor` (N:M)

Relaciona cursos con varios autores.\
**Razón:** evita repetir información de autores.

### 🟧 5. `videos`

Vídeos asociados a un curso, con autor y categoría.\
**Razón:** diseño sencillo y eficiente para lecturas rápidas.

### 🟥 6. `articulos`

Artículos asociados a un curso mediante GUID a CMS.\
**Razón:** delegar contenido pesado fuera de la BD.

## 4. Justificación del diseño

### ✔ Evitar duplicados

-   Autores únicos.\
-   Categorías únicas.\
-   Relaciones N:M para evitar repetir datos.

### ✔ Reducir tamaño de la BD

-   Contenido externo almacenado fuera (S3, CMS).\
-   Solo se guarda lo necesario.

### ✔ Modelo simple pero escalable

-   Evita tablas innecesarias.\
-   Preparado para miles de cursos sin complicaciones.

### ✔ Optimizado para lectura

-   La home, páginas de curso y vídeo requieren pocas consultas.

## 5. Conclusión

El modelo es ligero, eficiente, sin duplicidades y escalable.\
Ideal para un portal de e-learning con gran carga de lectura.
