const { Given, When, Then } = require('@cucumber/cucumber');
const request = require('sync-request');
const assert = require('assert');

Given('que se recibe el registro de conductor con {string} y {string} y {string}', function (horaInicio, horaFin, patente) {

    let dateStringHoraInicio = horaInicio;
    const dateObjectHoraInicio = new Date(dateStringHoraInicio);

    let dateStringHoraFin = horaFin;
    const dateObjectHoraFin = new Date(dateStringHoraFin);

    this.registroConductor = {
        "horaInicio": dateObjectHoraInicio,
        "horaFin": dateObjectHoraFin,
        "patente": patente
    }

    let res = request('POST', encodeURI('http://if012estm.fi.mdn.unp.edu.ar:28003/registros-conductores/recibir'),
        {
            json: this.registroConductor
        }
    );

    //this.response = JSON.parse(res.getBody('utf8'));
    //console.log(this.response)
    //console.log(this.registroConductor)
});

When('se realiza el cruzamiento de registros', function () {
    
    let res = request('GET', encodeURI(`http://if012estm.fi.mdn.unp.edu.ar:28003/registros-infracciones/cruzamiento`),
    {
        headers: {
            'Content-Type': 'application/json',
        }
    });

    this.response = JSON.parse(res.getBody('utf8'));

    //console.log(this.response);
});

Then('no se genera ninguna infraccion', function () {
    
    let result = this.response.data; 
    
    if (result.length === 0) {
        return true;
    } else {
        return false;
    }
});

Given('que se recibe el registro de agente de transito con {string} y {float} y {float} y {string}', function (horaRegistro, latitud, longitud, patenteRegistroAgenteTransito) {
    
    let dateStringHoraRegistro = horaRegistro;
    let dateObjectHoraRegistro = new Date(dateStringHoraRegistro);

    this.registroAgenteTransito = {
        "horaRegistro": dateObjectHoraRegistro,
        "latitud": latitud,
        "longitud": longitud,
        "patente": patenteRegistroAgenteTransito
    }

    let res = request('POST', encodeURI('http://if012estm.fi.mdn.unp.edu.ar:28003/registros-agentes-transito/recibir'),
        {
            json: this.registroAgenteTransito
        }
    );
});

Then('se genera una infraccion para la patente {string}', function (patenteQueCometeInfraccion) {

    let data = this.response.data;

    patenteEncontrada = data.find(item => 
        item.registroAgenteTransito.patente === patenteQueCometeInfraccion
    );

    if (patenteEncontrada) {
        return true;
    } else {
        return false;
    }
});

Given('que se recibe el registro de conductor con hora inicio {string} y hora fin {string} y patente {string}', function (horaInicio, horaFin, patente) {
    
    let dateStringHoraInicio = horaInicio;
    const dateObjectHoraInicio = new Date(dateStringHoraInicio);

    let dateStringHoraFin = horaFin;
    const dateObjectHoraFin = new Date(dateStringHoraFin);

    this.registroConductor = {
        "horaInicio": dateObjectHoraInicio,
        "horaFin": dateObjectHoraFin,
        "patente": patente
    }

    let res = request('POST', encodeURI('http://if012estm.fi.mdn.unp.edu.ar:28003/registros-conductores/recibir'),
        {
            json: this.registroConductor
        }
    );
});

Given('que se reciben los registros de agente de transito', function (dataTable) {
    // Recorre cada fila de la tabla de datos
    dataTable.hashes().forEach((row) => {
        let dateStringHoraRegistro = row.horaRegistro;
        let dateObjectHoraRegistro = new Date(dateStringHoraRegistro);

        this.registroAgenteTransito = {
            "horaRegistro": dateObjectHoraRegistro,
            "latitud": parseFloat(row.latitud),  // Convertir latitud y longitud a float
            "longitud": parseFloat(row.longitud),
            "patente": row.patenteRegistroAgenteTransito
        };

        // Hacer el request para cada fila de la dataTable
        let res = request('POST', encodeURI('http://if012estm.fi.mdn.unp.edu.ar:28003/registros-agentes-transito/recibir'), {
            json: this.registroAgenteTransito
        });

    });
});

Given('que no se recibe el registro de conductor de la patente {string}', function (patente) {
    
    this.patenteSinRegistroConductor = patente;


});

Given('que se recibe el registro de agente de transito con hora de registro {string} y latitud {float} y longitud {float} y patente {string}', function (horaRegistro, latitud, longitud, patente) {
    
    let dateStringHoraRegistro = horaRegistro;
    let dateObjectHoraRegistro = new Date(dateStringHoraRegistro);

    this.registroAgenteTransito = {
        "horaRegistro": dateObjectHoraRegistro,
        "latitud": latitud,
        "longitud": longitud,
        "patente": patente
    }

    let res = request('POST', encodeURI('http://if012estm.fi.mdn.unp.edu.ar:28003/registros-agentes-transito/recibir'),
        {
            json: this.registroAgenteTransito
        }
    );
});

Then('se genera una infracción para la patente {string}', function (patenteQueCometeInfraccion) {
    
    let data = this.response.data;

    patenteEncontrada = data.find(item => 
        item.registroAgenteTransito.patente === patenteQueCometeInfraccion
    );

    if (patenteEncontrada) {
        return true;
    } else {
        return false;
    }
});

Given('que se reciben los registros de conductor', function (dataTable) {
    // Recorre cada fila de la tabla de datos
    dataTable.hashes().forEach((row) => {
        let dateStringHoraInicio = row.horaInicio;
        const dateObjectHoraInicio = new Date(dateStringHoraInicio);

        let dateStringHoraFin = row.horaFin;
        const dateObjectHoraFin = new Date(dateStringHoraFin);

        this.registroConductor = {
            "horaInicio": dateObjectHoraInicio,
            "horaFin": dateObjectHoraFin,
            "patente": row.patente
        };

        // Hacer el request para cada fila de la dataTable
        let res = request('POST', encodeURI('http://if012estm.fi.mdn.unp.edu.ar:28003/registros-conductores/recibir'), {
            json: this.registroConductor
        });

    });
});

Then('se generan dos infracciones para la patente {string}', function (patenteQueCometeInfraccion) {
    // Obtener los datos de la respuesta
    let data = this.response.data;

    // Contador de infracciones para la patente
    let contadorDeInfracciones = 0;

    // Iterar sobre todos los registros y contar las veces que aparece la patente
    data.forEach(item => {
        if (item.registroAgenteTransito.patente === patenteQueCometeInfraccion) {
            contadorDeInfracciones++;
        }
    });

    // Verificar si la patente aparece exactamente dos veces
    if (contadorDeInfracciones === 2) {
        return true;  // Si se generaron dos infracciones, la prueba pasa
    } else {
        return false;
    }
});