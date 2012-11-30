/*
 * Auteur     : Belkacem Ouarab, Pierre Gagnon & Paul Gagné
 * No étudiant: 910161950
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
