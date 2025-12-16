
/**
 * Ejercicio 1
    Un texto en formato CSV tiene el nombre de los campos en la primera fila 
    y los datos en el resto, separados por comas. Crea un parseador que reciba un string 
    en formato CSV y devuelva una colección de objetos. Utiliza destructuring, 
    rest y spread operator donde creas conveniente.
 */

const data = `id,name,surname,gender,email,picture
15519533,Raul,Flores,male,raul.flores@example.com,https://randomuser.me/api/portraits/men/42.jpg
82739790,Alvaro,Alvarez,male,alvaro.alvarez@example.com,https://randomuser.me/api/portraits/men/48.jpg
37206344,Adrian,Pastor,male,adrian.pastor@example.com,https://randomuser.me/api/portraits/men/86.jpg
58054375,Fatima,Guerrero,female,fatima.guerrero@example.com,https://randomuser.me/api/portraits/women/74.jpg
35133706,Raul,Ruiz,male,raul.ruiz@example.com,https://randomuser.me/api/portraits/men/78.jpg
79300902,Nerea,Santos,female,nerea.santos@example.com,https://randomuser.me/api/portraits/women/61.jpg
89802965,Andres,Sanchez,male,andres.sanchez@example.com,https://randomuser.me/api/portraits/men/34.jpg
62431141,Lorenzo,Gomez,male,lorenzo.gomez@example.com,https://randomuser.me/api/portraits/men/81.jpg
05298880,Marco,Campos,male,marco.campos@example.com,https://randomuser.me/api/portraits/men/67.jpg
61539018,Marco,Calvo,male,marco.calvo@example.com,https://randomuser.me/api/portraits/men/86.jpg`;




function parseCSV(data) {
  const lines = data.split('\n')  
  const [headers, ...csvLines] = lines;
  const headersArray = headers.split(',');
  
  const parsedCSV = csvLines.map(line => {
    const lineData = line.split(',');
    const parsedOBJ = {};    
    headersArray.forEach((header, index) => {
      parsedOBJ[header] = lineData[index];
    });    
    return parsedOBJ;
  });
  
  console.log(parsedCSV);
}

parseCSV(data);


