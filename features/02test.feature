# language: es

Característica: Funcion que determina si una persona se encuentra en alguno de los poligonos de estacionamiento del sistema central

    Esquema del escenario: Persona se encuentra en poligono Zona centro
      Dado que la persona se encuentra en -42.76781622597126 y -65.03644792398303
      Cuando se ejecuta la funcion para determinar si esta en un poligono
      Entonces se obtiene como resultado que se encuentran en el poligono con nombre "Zona centro"

    Esquema del escenario: Persona no se encuentra en ningun poligono
        Dado que la persona se encuentra en -42.76724910661824 y -65.03483321092102
        Cuando se ejecuta la funcion para determinar si esta en un poligono
        Entonces se obtiene que no se encuentra en ningun poligono de estacionamiento