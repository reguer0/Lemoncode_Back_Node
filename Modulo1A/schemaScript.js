db.createCollection("videos", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      title: "videos",
      required: ["idVide"],
      properties: {
        "idVide": { bsonType: "objectId" },
      },
    },
  },
});

db.createCollection("tematicas", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      title: "tematicas",
      required: ["idTematica"],
      properties: {
        "idTematica": { bsonType: "objectId" },
        "nombreCategoria": { bsonType: "string" },
      },
    },
  },
});

db.createCollection("autores", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      title: "autores",
      required: ["idAutor"],
      properties: {
        "idAutor": { bsonType: "objectId" },
        "nombre": { bsonType: "string" },
      },
    },
  },
});

db.createCollection("cursoAutor", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      title: "cursoAutor",
      required: ["idCurso_FK"],
      properties: {
        "idCurso_FK": { bsonType: "string" },
        "idAutor_FK": { bsonType: "string" },
      },
    },
  },
});

db.createCollection("Curso", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      title: "Curso",
      required: ["idCurso"],
      properties: {
        "idCurso": { bsonType: "objectId" },
        "fechaPublicacion": { bsonType: "date" },
        "nombreCurso": { bsonType: "string" },
      },
    },
  },
});

db.createCollection("articulos", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      title: "articulos",
      required: ["idArticulos"],
      properties: {
        "idArticulos": { bsonType: "objectId" },
        "nombreArticulo": { bsonType: "string" },
      },
    },
  },
});