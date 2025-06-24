object r2d2 {
    var bateria = 50
    const valentia = 10
    method potencia() = bateria * valentia
}
//Han Solo
//Tuvo la mala suerte de ser congelado en Carbonita hace poco. 
//Hasta donde sabemos aún está congelado y esperamos que pueda ser descongelado 
//antes de que deba entrar en acción. En caso de estar congelado, su potencia es nula. 
//Pero sabemos que en circunstancias normales su potencia depende del arma que tenga, 
//ya que siempre tiene un arma. 
//Hay muchas armas y todas aportan una determinada energía. 
//Por ejemplo, si tiene un blaster con energia 70 la potencia de Han sería 140; 
//si tiene otra arma, también su potencia es el doble de la energía de dicha arma. 

class Personaje{
    var property arma = new Blaster(adicional = 10)
    var congelado = true
    method potencia() = if (congelado) 0 else arma.energia()*2
}

class PersonajeProtagonico inherits Personaje{
    var potencia
    override method potencia() = super() + potencia
    method salir() {
        potencia = potencia * 2
    }
}

class Arma{
    var property energia 
}

class Blaster inherits Arma(energia = 10){
    var adicional 
    override method energia() = adicional + energia
}

class Planeta {
    const defensores = []
    var poblacion
    //Cuando se produce una invasión, si la suma de potencia de sus defensores 
    //es mayor que la intensidad del ataque, el planeta se defiende satisfactoriamente 
    //y no pierde población. En cambio, si el ataque fuera más intenso, 
    //pierde el 10% de su población. 
    //Se asume que la intensidad del ataque se representa con un valor numérico 
    //que se indica al momento de la invasión
    method invasion(intensidad){
        if (intensidad > self.defensa()) 
            poblacion = poblacion * 0.9
    }
    method defensa() = defensores.sum{d=>d.potencia()}
}

class Maestro {
    var sable
    var midiclorianos
    var property lado = ladoLuz
    var property esperanza
    method potencia() = (midiclorianos/1000 + sable.energia()) * lado.nivelFuerza()

    method vivir(suceso) {
        lado.vivirSuceso(self,suceso)
    }
    method aumentaEsperanza(nro){
        esperanza = esperanza + nro
    }
}

object ladoOscuro{
    var nivel = 5
    method nivelFuerza() = nivel
    method vivirSuceso(maestro,suceso) {
        if (suceso.cargaEmocional() > 100){
            maestro.lado(ladoLuz)
            self.disminuir()
        }

    }
    method incrementar(){
        nivel = nivel +1
    }
    method disminuir(){
        nivel = nivel / 2
    }
}

object ladoLuz{
    
    method nivelFuerza() = 10
    
    method vivirSuceso(maestro,suceso) {
       maestro.aumentaEsperanza(suceso.cargaEmocional()) 
       if (maestro.esperanza() <= 0){
         maestro.lado(ladoOscuro)
         ladoOscuro.incrementar()
       }
    }
}

class Suceso{
    var property cargaEmocional
}

class SucesoConAmigos{
    var amigo
    method cargaEmocional() = amigo.potencia()
}

class Batalla{
    var bajas
    method cargaEmocional() = bajas * -1

}