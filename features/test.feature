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

      Esquema del escenario: Registro de conductor con registro de agente de transito sin infraccion
      Dado que se recibe el registro de conductor con "<horaInicio>" y "<horaFin>" y "<patente>"
      Y que se recibe el registro de agente de transito con "<horaRegistro>" y <latitud> y <longitud> y "<patenteRegistroAgenteTransito>"
      Cuando se realiza el cruzamiento de registros
      Entonces se genera una infraccion para la patente "OLA 111"

      Ejemplos:
      | horaInicio                    | horaFin                       | patente | horaRegistro                  | latitud    | longitud   | patenteRegistroAgenteTransito |
      | 2024-09-20T15:00:00.000+00:00 | 2024-09-20T15:30:00.000+00:00 | OLA 111 | 2024-09-20T15:33:00.000+00:00 | -42.767204 | -65.034616 | OLA 111                       |