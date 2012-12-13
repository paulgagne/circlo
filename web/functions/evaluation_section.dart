/*
 * Auteurs    : Belkacem Ouarab  (904 347 654), Pierre Gagnon (906 326 359) & Paul Gagné (910 161 950)
 *  
 * Professeur : Dzenan Ridjanovic
 * Cours      : SIO-6014 APPLICATIONS WEB DES SIO
 *
 * Description: Dans ce 'part', nous avons la logique utilisée pour la partie responsable de 
 * l'évaluation de la fonction.
 */


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

part of circlo;


Map varInput  = new Map();

and(int x, int y)
{
  return x & y;
}

nand(int x, int y)
{
  return not(x & y);
}

or(int x, int y)
{ 
  return x | y;
}

nor(int x, int y)
{ 
  return not(x | y);
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

bool v(String value)
{
  return (value.substring(0,1) == 'e') ? true : false; 
}

bool g(String value)
{
  bool test = false;
  if ( value == 'and'   ||
       value == 'nand'  ||
       value == 'or'    ||
       value == 'nor'   ||
       value == 'xor')
    test = true;
  return test; 
}

//Clone une liste pour permettre la récursivité
List cList(List lIn)
{
 List lOut = new List();
  for (int i = 0; i < lIn.length; i++)
  {
    lOut.add(lIn[i]);
  }
  return lOut;
}

//Change not var pour la valeur négative de var dans la liste
List lNot(List funct) {
  List nList = new List();
  for (int i = 0; i < funct.length; i++)
  {
    if ( funct[i] == 'not' && i < funct.length - 1 &&  ( funct[i+1] == 1 || funct[i+1] == 0) )
        {
          nList.add(not(funct[i+1]));
          i++;
        }
    else
        {
          nList.add(funct[i]);
        }
  }
  funct = nList;
  return funct;
}

//Verifie s'il y a des parenthèses
bool checkPar(List lIn)
{
  for (int i = 0; i < lIn.length; i++)
  {
    if ( lIn[i] == "(") return true;
  }
  return false;
}

//Verifie s'il y a des NOT
bool checkNot(List lIn)
{
  for (int i = 0; i < lIn.length; i++)
  {
    if ( lIn[i] == "not") return true;
  }
  return false;
}

//permet de faire and et nand en premier
int evalRank(String gate)
{
  switch(gate){
    case 'and'  : return 5;
    case 'nand' : return 5;
    case 'or'   : return 3;
    case 'xor'  : return 3;
    case 'nor'  : return 3;
  }
  return 0; 
}

int eval(List lIn)
{
  
  int pos    = 0;
  int rank   = 0;
  int rslt   = 0;
  List nList = new List();
  
  lIn = lNot(cList(lIn));
  lIn = par(cList(lIn));

  if ( !checkPar(lIn) && !checkNot(lIn) )
  {
   if ( lIn.length == 1 )
     return lIn[0];
   else if ( lIn.length == 3 )
   {
    switch (lIn[1])
     {
       case "and" : return and(lIn[0],lIn[2]);
       case "nand": return nand(lIn[0],lIn[2]);
       case "or"  : return or(lIn[0],lIn[2]); 
       case "xor" : return xor(lIn[0],lIn[2]);
       case "nor" : return nor(lIn[0],lIn[2]); 
     }
   }
  else 
   {
    for (int i = 0; i < lIn.length; i++)
    {
      if ( lIn[i] is String &&  g(lIn[i]) )
      {
        if ( rank < evalRank(lIn[i]) )
        {
          pos  = i;
          rank = evalRank(lIn[i]);
        }
      }
    }
    for (int j = pos - 1; j <= pos + 1; j++)
    {
      nList.add(lIn[j]);
    }
    rslt  = eval(nList);
    nList = new List();
    for (int j = 0; j < lIn.length; j++)
    {
      if ( j == pos - 1 )
        nList.add(rslt);
      else if ( j > pos - 1 && j <= pos + 1 )
      {
      }       
      else
      {
        nList.add(lIn[j]);
      }
     }
     lIn = nList;
    }
   
  }
  
  return eval(lIn); //On continue l'évaluation
}

// élimine une paranthèse et remplace par le résultat
List par(List funct)
{
  
  int  i    = funct.length - 1;
  int  pos1 = 0;
  int  pos2 = 0;
  bool fnd  = false;
  int  rslt = 0;
  List nList = new List();
  
  while ( i >= 0 && fnd == false) 
  {
    if ( funct[i] == "(")
      {
        pos1 = i;
        fnd = true;
      }
    if ( funct[i] == ")")
    {
      pos2 = i;
    }
    i--;
  }
  
  if ( fnd )
  {
   for (int j = pos1 + 1; j < pos2; j++)
   {
     nList.add(funct[j]);
   }
   rslt  = eval(nList);
   nList = new List();
   for (int j = 0; j < funct.length; j++)
   {
     if ( j == pos1 )
       nList.add(rslt);
     else if ( j > pos1 && j <= pos2 )
     {
     }       
     else nList.add(funct[j]);
   }
  }
  else
    nList = cList(funct);

  return nList;
  
}

int evalFunct()
{
  List funct = new List();
  for (int i = 2; i < logical_function_element.length; i++)
  {
    if (v(logical_function_element[i]))
        {
          funct.add(varInput[logical_function_element[i]]);
        }
    else
    {
      funct.add(logical_function_element[i]);
    }
  }
 
  return eval(cList(funct));
}

exec_funct() {
  
  int    itr   = 0;
  List   fVars = new List();
  String fVar  = "";
  
  clear_output();
  build_output();
  
   
  for(int i = 0; i < 5; i++)  // On trourve les variables choisit
  {
    if ( fullVarInput.containsKey('e${i}') )
        {
         fVars.add('e${i}');
        }
  }
 
  itr = fullVarInput[fVars[0]].length;
  
  for (int i = 0; i < itr; i++)
  {
    varInput  = new Map();
    for (int j = 0; j < fVars.length; j++)
    {
       varInput.putIfAbsent(fVars[j], () => fullVarInput[fVars[j]][i]);
    }
    result.add(evalFunct());
  }
  
  print_output();
  
}
