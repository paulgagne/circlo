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

part "model/objAttributes.dart";
part "model/gate.dart";
part "model/variable.dart";
part "model/delimiter.dart";
part "functions/userInputSection.dart";
part "functions/analysisSection.dart";

Map  gates                     = new Map();
Map  variables                 = new Map(); 
Map  delimiters                = new Map();
List userInput                 = new List();

List circuit_input             = new List();
List circuit_output            = new List();
List logical_gate=['and','or','nand','nor','xor'];
List logical_function_element  = new List();
List pile                      = new List();
Map output_function            = new Map();
String logical_function        ='';
bool fonction_correcte         = true;
int p_index                    = 0; 

void main() {
  
  create_circuit_input_output(5,1);
  setObjects(); 
  setInput();
  buildOutputFunction();

}


