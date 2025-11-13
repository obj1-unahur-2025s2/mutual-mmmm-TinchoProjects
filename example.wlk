class Actividad {
  const property idiomas = [] //Conjunto de strings
  method idiomas() = idiomas
  method implicaEsfuerzo()
  method sirveParaBroncearse()
  method diasDeActividad()
  method esInteresante() {
    return idiomas.size() > 1
  }
  method actividadAtractivaPara(unSocio){
    return unSocio.actividadEsAtractiva(self) && self.esInteresante() && !unSocio.activRealizadas().contains(self) 
  }
}
class ViajeTrekking inherits Actividad{
  const kmsRecorrido
  const diasDeSolAlAño
  override method diasDeActividad() {
    return kmsRecorrido / 50
  }
  override method implicaEsfuerzo(){
    return kmsRecorrido > 80
  }
  override method sirveParaBroncearse(){
    return diasDeSolAlAño > 200 || (kmsRecorrido >= 120 && 100 <= diasDeSolAlAño >= 200)
  }
  override method esInteresante(){
    return super() && diasDeSolAlAño > 140
  }
}
class ViajeDePlaya inherits Actividad {
  const largo
  override method implicaEsfuerzo(){
    return largo > 1200
  }
  override method sirveParaBroncearse() = true
  override method diasDeActividad(){
    return largo / 500
  }
}

class ViajeACiudad inherits Actividad {
  const property atracciones
  override method diasDeActividad() {
    return atracciones / 2
  }
  override method implicaEsfuerzo(){
    return 5 <= atracciones >= 8
  }
  override method sirveParaBroncearse() = false
  override method esInteresante(){
    return super() || atracciones == 5
  }
}

class ViajeACiudadTropical inherits ViajeACiudad{
  override method diasDeActividad(){
    return super() + 1
  }
  override method sirveParaBroncearse() = true
}
//3. Clases de gimnasia
class Gimnasia inherits Actividad{
  override method idiomas() = ["Español"]
  override method implicaEsfuerzo() = true
  override method sirveParaBroncearse() = false
  override method diasDeActividad() = 1
  override method actividadAtractivaPara(unSocio){
    return 20 <= unSocio.edad() <= 30
  }
}
//Bonus: taller literario
class TallerLiterario inherits Actividad{
  const librosTrabajados = [] //lista de libros
  override method idiomas(){
    return librosTrabajados.map({l => l.idioma()})
  }
  override method implicaEsfuerzo(){
    return librosTrabajados.any({l => l.paginas() > 500}) || librosTrabajados.all({l => l.autor()}) && !librosTrabajados.isEmpty()
  }
  override method sirveParaBroncearse() = false
  override method diasDeActividad() = librosTrabajados.size() + 1
  override method actividadAtractivaPara(unSocio){
    return unSocio.idiomasHablados().size() > 1
  }
}
class Libros {
  const property idioma
  const property paginas
  const property autor
}
//4. Socios, agregar actividad
class Socio {
  const property activRealizadas = []
  const activMaximas //un número
  const property idiomasHablados = []
  const edad //un número
  method esAdoradorDelSol(){
    return activRealizadas.all({a => a.sirveParaBroncearse()})
  }
  method actividadesEsforzadas(){
    return activRealizadas.all({a => a.implicaEsfuerzo()})
  }
  method cantidadActivRegistradas() = activRealizadas.size()
  method registrarActividad(unaActividad){
    if(self.cantidadActivRegistradas() < activMaximas){
      activRealizadas.add(unaActividad)
    } else {
      self.error("Actividades Maximas Registradas")
    }
  }
  method actividadEsAtractiva(unaActividad)
}
class SocioTranquilo inherits Socio{
  override method actividadEsAtractiva(unaActividad){
    return unaActividad.diasDeActividad() >= 4
  }
}
class SocioCoherente inherits Socio{
  override method actividadEsAtractiva(unaActividad){
    if (self.esAdoradorDelSol()){
      return unaActividad.sirveParaBroncearse()
    } else {
      return unaActividad.implicaEsfuerzo()
    }
  }
}
class SocioRelajado inherits Socio{
  override method actividadEsAtractiva(unaActividad){
    return unaActividad.idiomas().contains({idiomasHablados})
  }
}