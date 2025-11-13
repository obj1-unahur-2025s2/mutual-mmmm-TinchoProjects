class Viajes {
  const idiomas = [] //Conjunto de strings
  method implicaEsfuerzo()
  method sirveParaBroncearse()
  method diasDeActividad()
}
class ViajeDePlaya inherits Viajes {
  const largo
  override method implicaEsfuerzo(){
    return largo > 1200
  }
  override method sirveParaBroncearse() = true
  override method diasDeActividad(){
    return largo / 500
  }
}