
/*
 * Auteur     : Belkacem Ouarab, Pierre Gagnon (906 326 359) & Paul Gagné (910 161 950)
 * No étudiant: 910161950
 * Professeur : Dzenan Ridjanovic
 * Cours      : SIO-6014 APPLICATIONS WEB DES SIO
 *
 * Description: Dans ce 'part', nous avons la logique utilisée pour l'analyse de la syntax.
 *  
 */


part of circlo;

/*
Soit G' la grammaire factorisée de G�:

    S   -->   idf E0
    E0  -->   =  E
    E   -->   (EM |FT
    T   -->   orE |andE |xorE |norE |nandE |vide
    M   -->   )T
    F   -->   idf |not E

{idf : identificateur d'une entrée ou d'une sortie logique}
  
 */

and(int x, int y)
{
  return x & y;
}

or(int x, int y)
{ 
  return x | y;
}

xor (x,y)
{
  return x^y;
}

not(int x)
{
  if (x==1)
    return 0;
  else return 1;
}


bool is_idf(p_str)
/* Cette function retourne la valeur vrai si le lexeme est un identificateur (idf): une variable d'entrée du circuit
 * si non, elle retourne la valeur false.
 */
{ int i=0;
  bool idf = false;
  while (i<circuit_input.length)
  {
    if (p_str == circuit_input[i])
      { return true;
      }
      else i++;     
  }
  i=0;
  while (i<circuit_output.length)
  {
    if (p_str == circuit_output[i])
      { return true;
      }
      else i++;     
  }
  return false;
}

bool is_logical_gate(p_str)
/* Cette fonction retourne la valeur vrai si le lexeme est un identificateur (idf): une variable d'entrée du circuit
 * si non, elle retourne la valeur false.
 */
{ int i=0;
  bool gate = false;
  while (i<logical_gate.length)
  {
    if (p_str == logical_gate[i])
      { return true; }
      else i++;     
  } 
  return false;
}

create_circuit_input_output(p_nb_input,p_nb_output)
// Cette fonction permet de créer la liste des variable d'entrée/sortie du circuit logique;
// Dans le cadre de la conception des cicuits, cette fonction sera appellée directement par 
// le système en lui passant automatiquement (intelligement) le nombre d'entrées et de sorties
{
  for (var i=0;i<p_nb_input;i++)
  {
    circuit_input.add('e'.concat(i.toString()));
  }

  for (var i=0;i<p_nb_output;i++)
  {
    circuit_output.add('S'.concat(i.toString()));
  }

}

call_S()
{
  
  pile              = new List();
  p_index           = 0; 
  fonction_correcte = true;
  
  if (logical_function_element.length>p_index)
  { 
      if ( is_idf(logical_function_element[p_index]))
      {
        pile.add(logical_function_element[p_index]);
        p_index++;
        call_E0();
      }
      else 
        { 
          fonction_correcte =false;
          return;
        }
  }
}

call_E0()
{
  if (logical_function_element.length>p_index)
  { 
      if ( logical_function_element[p_index]=='=')
        { 
          pile.add(logical_function_element[p_index]);
          p_index++;
          call_E();
        }
      else 
        { 
          fonction_correcte =false;
        }
  }
  else
    { 
     fonction_correcte =false;
     return;
    }
}

call_E()
{
  if (logical_function_element.length>p_index)
  {
      if ( logical_function_element[p_index]=='(')
          {
            pile.add(logical_function_element[p_index]);
            p_index++;
            call_E();
            call_M();
          }
      else 
        {   call_F();
            call_T();
        }  
  }
  else 
    {
      fonction_correcte =false;
      return;
    }
}


call_T()
{

  if (logical_function_element.length>p_index)
  {
      if (is_logical_gate(logical_function_element[p_index]))
      {
        pile.add(logical_function_element[p_index]);
        p_index++;
        call_E();
      }
      else 
        {
          return;
        }
  }
}

call_M()
{
  if (logical_function_element.length>p_index)
  {   
     if ( logical_function_element[p_index]==')')
          {   
            pile.add(logical_function_element[p_index]);
            p_index++; 
            call_T();
          }
          else 
            {
               
              fonction_correcte =false;
              return;
            }
   }
  else {  
          fonction_correcte =false;
          return;
        }
}

call_F()
{
  if (logical_function_element.length>p_index)
  {
      if (is_idf(logical_function_element[p_index]))
      {
        pile.add(logical_function_element[p_index]);
        p_index++;
      }
      else if (logical_function_element[p_index]=='not')
      {
        pile.add(logical_function_element[p_index]);
        p_index++;
        call_E();
      }
      else 
        {  
          fonction_correcte =false;
        }
  }
  else 
  { 
    fonction_correcte =false;
    return;
   }
}

analyse() {
  
  // Vérification de la validité de la fonction 
  
  TextAreaElement analysis = query('#analysis'); // lien avec HTML pour le message d'erreur
  
  // On transfère l'entrée du l'utilisation dans la liste suivante: 
  logical_function_element = ['S0',"="];
  
  for (int i = 0; i < userInput.length; i++)
  {
    logical_function_element.add(userInput[i].value);
  }

  call_S(); 
  if (logical_function_element.length!=pile.length)
    // Si les langueurs des deux listes sont différentes => Erreur de syntaxe  
  {
    fonction_correcte=false;
  }
  
  if (fonction_correcte)
  {
    analysis.value = "L'expression de la fonction logique est correcte.";
    print_output();
  }
  else
    analysis.value = "L'expression de la fonction logique n'est pas correcte.";
   
}
