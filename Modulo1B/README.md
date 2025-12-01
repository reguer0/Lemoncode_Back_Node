use("localizaciones");
db.listingsAndReviews.find()


//Saca en una consulta cuantos alojamientos hay en España.

///db.listingsAndReviews.countDocuments({
//  "address.country": "Spain"
//})


/**
 * Lista los 10 primeros alojamientos de España:
Ordenados por precio de forma ascendente.
Sólo muestra: nombre, precio, camas y la localidad (address.market).
 */

db.listingsAndReviews.find(
    {
        "address.country": "Spain"
    },
    { "address.market": 1,name: 1,price:1 ,beds:1, _id: 0 }

).sort({price:1}).limit(10); 


/**
 * Queremos viajar cómodos, somos 4 personas y queremos:
4 camas.
Dos cuartos de baño o más.
Sólo muestra: nombre, precio, camas y baños.
 */

db.listingsAndReviews.find(
    {  
        $and: [
            {beds: { $eq: 4 }},
            { bathrooms: { $gte: 2}},
        ]
    },
    { name: 1, price:1, beds: 1, bathrooms: 1, _id: 0 }
);


Aunque estamos de viaje no queremos estar desconectados, así que necesitamos que el alojamiento también tenga conexión wifi. A los requisitos anteriores, hay que añadir que el alojamiento tenga wifi.
Sólo muestra: nombre, precio, camas, baños y servicios (amenities).

db.listingsAndReviews.find(
    {  
        $and: [
            {beds: { $eq: 4 }},
            { bathrooms: { $gte: 2}},
            { amenities: { $all: ["Wifi"] } },
        ]
    },
    { name: 1, price:1, beds: 1, bathrooms: 1,amenities:1, _id: 0 }
);

Y bueno, un amigo trae a su perro, así que tenemos que buscar alojamientos que permitan mascota (Pets allowed).
Sólo muestra: nombre, precio, camas, baños y servicios (amenities).

db.listingsAndReviews.find(
    {  
        $and: [
            {beds: { $eq: 4 }},
            { bathrooms: { $gte: 2}},
            { amenities: { $all: ["Wifi","Pets allowed"] } },
        ]
    },
    { name: 1, price:1, beds: 1, bathrooms: 1,amenities:1, _id: 0 }
);

Estamos entre ir a Barcelona o a Portugal, los dos destinos nos valen. Pero queremos que el precio nos salga baratito (50 $), y que tenga buen rating de reviews (campo review_scores.review_scores_rating igual o superior a 88).
Sólo muestra: nombre, precio, camas, baños, rating, localidad y país.

db.listingsAndReviews.find(
    {  
        $and: [
            {beds: { $eq: 4 }},
            { bathrooms: { $gte: 2}},
            { price: { $lte: 50}},
            { amenities: { $all: ["Wifi","Pets allowed"] } },
            {
                $or: [
                    
                        { "address.street": { $all: ["Barcelona"] } },
                        { "address.country": { $all: ["Portugal"] } },
                    ]
            },
        ]
    },
 
    { 
        name: 1, 
        price:1,
        beds: 1,
        bathrooms: 1,
        amenities:1,
        "address.street":1, 
        "address.country" : 1, 
        _id: 0 
    }
);

También queremos que el huésped sea un superhost (host.host_is_superhost) y que no tengamos que pagar depósito de seguridad (security_deposit).
Sólo muestra: nombre, precio, camas, baños, rating, si el huésped es superhost, depósito de seguridad, localidad y país.

db.listingsAndReviews.find(
    {  
        $and: [
            {beds: { $eq: 4 }},
            { bathrooms: { $gte: 2}},
            { price: { $lte: 50}},
            { "host.host_is_superhost": { $eq: false}},
            { "security_deposit": { $eq: false}},
            { amenities: { $all: ["Wifi","Pets allowed"] } },
            {
                $or: [
                    
                        { "address.street": { $all: ["Barcelona"] } },
                        { "address.country": { $all: ["Portugal"] } },
                    ]
            },
        ]
    },
 
    { 
        name: 1, 
        price:1,
        beds: 1,
        bathrooms: 1,
        amenities:1,
        "host.host_is_superhost": 1,
        "address.street":1, 
        "address.country" : 1, 
        "security_deposit": 1,
        _id: 0 
    }
);


Agregaciones
Queremos mostrar los alojamientos que hay en España, con los siguientes campos:
Nombre.
Localidad (no queremos mostrar un objeto, sólo el string con la localidad).
Precio

db.listingsAndReviews.aggregate([
{ $match: { "address.country": "Spain" } },
   { 
    $project:  { 
        name: 1, 
        price:1,       
        "address.street":1, 
        "address.country" : 1, 
        _id: 0 
    }
}

]);

Queremos saber cuantos alojamientos hay disponibles por pais.

db.listingsAndReviews.aggregate([
  {
    $group: {
      _id: "$address.country",
      totalAlojamientos: { $sum: 1 }
    }
  },
  {
    $project: {
      _id: 0,
      pais: "$_id",
      totalAlojamientos: 1
    }
  }
]);



Opcional
Queremos saber el precio medio de alquiler de airbnb en España.

db.listingsAndReviews.aggregate([
{ $match: { "address.country": "Spain" } },
   {
    $group: {
      _id: null,
      precioMedio: { $avg: "$price" }
    }
  },
  

]);

¿Y si quisieramos hacer como el anterior, pero sacarlo por paises?
db.listingsAndReviews.aggregate([
   {
    $group: {
      _id: "$address.country",
      precioMedio: { $avg: "$price" }
    }
  },  

]);


Repite los mismos pasos para calcular el precio medio de alquiler, pero agrupando también por numero de habitaciones.


db.listingsAndReviews.aggregate([
  {
    $group: {
      _id: {
        pais: "$address.country",
        habitaciones: "$bedrooms"
      },
      precioMedio: { $avg: "$price" }
    }
  },

]);