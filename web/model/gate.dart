/*
 * Auteurs    : Belkacem Ouarab  (904 347 654), Pierre Gagnon (906 326 359) & Paul Gagné (910 161 950)
 *  
 * Professeur : Dzenan Ridjanovic
 * Cours      : SIO-6014 APPLICATIONS WEB DES SIO
 *
 * Description: 
 */


part of circlo;

class Gate extends ObjAttributes {
  
  String url   = "";
  
  Gate(String name, this.url, String value)
  {
    this.name  = name;
    this.value = value;
  }
  
}
