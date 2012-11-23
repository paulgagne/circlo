/*
 * Auteur     : Belkacem Ouarab, Pierre Gagnon & Paul Gagné
 * No étudiant: 910161950
 * Professeur : Dzenan Ridjanovic
 * Cours      : SIO-6014 APPLICATIONS WEB DES SIO
 *
 * Description: 
 */

library circlo;

import 'dart:html';

part "model/door.dart";
part "model/variable.dart";
part "model/delimiter.dart";
part "functions/userInputSection.dart";
part "functions/analysisSection.dart";

Map  syntax     = new Map();
Map  variables  = new Map(); 
Map  delimiters = new Map();
List userInput  = new List();

void main() {
  
  setSyntax(); 
  setInput();
  buildOutputFunction();

}


