/*
 * Auteur     : Belkacem Ouarab (904 347 654), Pierre Gagnon (906 326 359) & Paul Gagné (910 161 950)
 *  
 * Professeur : Dzenan Ridjanovic
 * Cours      : SIO-6014 APPLICATIONS WEB DES SIO
 *
 * Description: 
 */

library circlo;

import 'dart:html';
import 'dart:math';

part "model/objAttributes.dart";
part "model/gate.dart";
part "model/variable.dart";
part "model/delimiter.dart";
part "functions/user_input_section.dart";
part "functions/analysis_section.dart";
part "functions/evaluation_section.dart";
part "functions/output_section.dart";

Map    gates                     = new Map();
Map    variables                 = new Map(); 
Map    delimiters                = new Map();
List   userInput                 = new List();

List   circuit_input             = new List();
List   circuit_output            = new List();
List   logical_gate=['and','or','nand','nor','xor'];
List   logical_function_element  = new List();
List   pile                      = new List();
List    result        = new List();

Map    output_function           = new Map();
String logical_function          ='';
bool   fonction_correcte         = true;
int    p_index                   = 0; 

void main() {
  
  create_circuit_input_output(5,1);
  setObjects(); 
  setInput();
  buildOutputFunction();

}


