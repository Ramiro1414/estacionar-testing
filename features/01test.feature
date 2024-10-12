# language: es

Característica: Cruzamiento de registros de agentes de transito y registros de conductores

   Esquema del escenario: Registro de conductor sin registro de agente de transito sin infraccion
      Dado que se recibe el registro de conductor con "<horaInicio>" y "<horaFin>" y "<patente>"
      Cuando se realiza el cruzamiento de registros
      Entonces no se genera ninguna infraccion

      Ejemplos:
      | horaInicio                    | horaFin                       | patente |
      | 2024-09-20T16:00:00.000+00:00 | 2024-09-20T17:00:00.000+00:00 | ZZZ 000 |

    Esquema del escenario: Registro de conductor con registro de agente de transito sin infraccion
      Dado que se recibe el registro de conductor con "<horaInicio>" y "<horaFin>" y "<patente>"
      Y que se recibe el registro de agente de transito con "<horaRegistro>" y <latitud> y <longitud> y "<patenteRegistroAgenteTransito>"
      Cuando se realiza el cruzamiento de registros
      Entonces no se genera ninguna infraccion

      Ejemplos:
      | horaInicio                    | horaFin                       | patente | horaRegistro                  | latitud    | longitud   | patenteRegistroAgenteTransito |
      | 2024-09-20T14:00:00.000+00:00 | 2024-09-20T15:00:00.000+00:00 | ABC 123 | 2024-09-20T14:30:00.000+00:00 | -42.766007 | -65.036533 | ABC 123                       |

    Esquema del escenario: Registro de conductor con registro de agente de transito con infraccion
      Dado que se recibe el registro de conductor con "<horaInicio>" y "<horaFin>" y "<patente>"
      Y que se recibe el registro de agente de transito con "<horaRegistro>" y <latitud> y <longitud> y "<patenteRegistroAgenteTransito>"
      Cuando se realiza el cruzamiento de registros
      Entonces se genera una infraccion para la patente "OLA 111"

      Ejemplos:
      | horaInicio                    | horaFin                       | patente | horaRegistro                  | latitud    | longitud   | patenteRegistroAgenteTransito |
      | 2024-09-20T15:00:00.000+00:00 | 2024-09-20T15:30:00.000+00:00 | OLA 111 | 2024-09-20T15:33:00.000+00:00 | -42.767204 | -65.034616 | OLA 111                       |

    Esquema del escenario: Registro de conductor con multiples registros de agente de transito sin infraccion
      Dado que se recibe el registro de conductor con hora inicio "2024-09-20T16:24:00.000+00:00" y hora fin "2024-09-20T17:47:00.000+00:00" y patente "QWE 234"
      Y que se reciben los registros de agente de transito
      | horaRegistro                  | latitud    | longitud   | patenteRegistroAgenteTransito |
      | 2024-09-20T16:28:00.000+00:00 | -42.767204 | -65.034616 | QWE 234                       |
      | 2024-09-20T16:46:00.000+00:00 | -42.767204 | -65.034616 | QWE 234                       |
      | 2024-09-20T17:22:00.000+00:00 | -42.767204 | -65.034616 | QWE 234                       |
      Cuando se realiza el cruzamiento de registros
      Entonces no se genera ninguna infraccion

    Esquema del escenario: Registro de agente de transito sin registro de conductor con infraccion
      Dado que no se recibe el registro de conductor de la patente "ADW 813"
      Y que se recibe el registro de agente de transito con hora de registro "2024-09-21T13:01:00.000+00:00" y latitud -42.767204 y longitud -65.034616 y patente "ADW 813"
      Cuando se realiza el cruzamiento de registros
      Entonces se genera una infracción para la patente "ADW 813"

  Esquema del escenario: Registro de conductor con multiples registros de agente de transito con infraccion
    Dado que se recibe el registro de conductor con hora inicio "2024-09-22T17:04:00.000+00:00" y hora fin "2024-09-22T17:23:00.000+00:00" y patente "BZC 200"
    Y que se reciben los registros de agente de transito
    | horaRegistro                  | latitud    | longitud   | patenteRegistroAgenteTransito |
    | 2024-09-22T16:52:00.000+00:00 | -42.767204 | -65.034616 | BZC 200                       |
    | 2024-09-22T17:15:00.000+00:00 | -42.767204 | -65.034616 | BZC 200                       |
    Cuando se realiza el cruzamiento de registros
    Entonces se genera una infraccion para la patente "BZC 200"

  Esquema del escenario: Multiples registros de conductor con multiples registros de agente de transito sin infraccion
    Dado que se reciben los registros de conductor
    | horaInicio                    | horaFin                       | patente |
    | 2024-09-23T14:00:00.000+00:00 | 2024-09-23T15:30:00.000+00:00 | WQQ 308 |
    | 2024-09-23T18:00:00.000+00:00 | 2024-09-23T18:30:00.000+00:00 | WQQ 308 |
    Y que se reciben los registros de agente de transito
    | horaRegistro                  | latitud    | longitud   | patenteRegistroAgenteTransito |
    | 2024-09-23T14:03:00.000+00:00 | -42.767204 | -65.034616 | WQQ 308                       |
    | 2024-09-23T15:19:00.000+00:00 | -42.767204 | -65.034616 | WQQ 308                       |
    | 2024-09-23T18:21:00.000+00:00 | -42.767204 | -65.034616 | WQQ 308                       |
    Cuando se realiza el cruzamiento de registros
    Entonces no se genera ninguna infraccion

  Esquema del escenario: Multiples registros de conductor con multiples registros de agente de transito con una infraccion
    Dado que se reciben los registros de conductor
    | horaInicio                    | horaFin                       | patente |
    | 2024-09-24T13:20:00.000+00:00 | 2024-09-24T14:05:00.000+00:00 | SWK 111 |
    | 2024-09-24T15:00:00.000+00:00 | 2024-09-24T18:21:00.000+00:00 | SWK 111 |
    Y que se reciben los registros de agente de transito
    | horaRegistro                  | latitud    | longitud   | patenteRegistroAgenteTransito |
    | 2024-09-24T13:07:00.000+00:00 | -42.767204 | -65.034616 | SWK 111                       |
    | 2024-09-24T15:15:30.000+00:00 | -42.767204 | -65.034616 | SWK 111                       |
    | 2024-09-24T18:00:00.000+00:00 | -42.767204 | -65.034616 | SWK 111                       |
    Cuando se realiza el cruzamiento de registros
    Entonces se genera una infraccion para la patente "SWK 111"

  Esquema del escenario: Multiples registros de conductor con multiples registros de agente de transito con dos infracciones en distintas ubicaciones
    Dado que se reciben los registros de conductor
    | horaInicio                    | horaFin                       | patente |
    | 2024-09-25T16:10:00.000+00:00 | 2024-09-25T16:45:00.000+00:00 | EHL 540 |
    | 2024-09-25T19:35:00.000+00:00 | 2024-09-25T20:20:00.000+00:00 | EHL 540 |
    Y que se reciben los registros de agente de transito
    | horaRegistro                  | latitud    | longitud   | patenteRegistroAgenteTransito |
    | 2024-09-25T16:58:00.000+00:00 | -42.767204 | -65.034616 | EHL 540                       |
    | 2024-09-25T19:24:00.000+00:00 | -42.737254 | -65.031611 | EHL 540                       |
    | 2024-09-25T20:26:00.000+00:00 | -42.737254 | -65.031611 | EHL 540                       |
    Cuando se realiza el cruzamiento de registros
    Entonces se generan dos infracciones para la patente "EHL 540"

  Esquema del escenario: Multiples registros de conductor con multiples registros de agente de transito con dos infracciones en la misma ubicacion
    Dado que se reciben los registros de conductor
    | horaInicio                    | horaFin                       | patente |
    | 2024-09-25T13:00:00.000+00:00 | 2024-09-25T14:00:00.000+00:00 | LOW 150 |
    | 2024-09-25T18:00:00.000+00:00 | 2024-09-25T19:00:00.000+00:00 | LOW 150 |
    Y que se reciben los registros de agente de transito
    | horaRegistro                  | latitud    | longitud   | patenteRegistroAgenteTransito |
    | 2024-09-25T12:52:00.000+00:00 | -42.737254 | -65.031611 | LOW 150                       |
    | 2024-09-25T14:05:00.000+00:00 | -42.737254 | -65.031611 | LOW 150                       |
    | 2024-09-25T19:21:00.000+00:00 | -42.737254 | -65.031611 | LOW 150                       |
    Cuando se realiza el cruzamiento de registros
    Entonces se generan dos infracciones para la patente "LOW 150"