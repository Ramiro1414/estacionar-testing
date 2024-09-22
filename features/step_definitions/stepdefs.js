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

    data = this.response.data;

    patenteEncontrada = data.find(item => 
        item.registroAgenteTransito.patente === patenteQueCometeInfraccion && 
        item.registroConductor.patente === patenteQueCometeInfraccion
    );

    if (patenteEncontrada) {
        return true;
    } else {
        return false;
    }
});