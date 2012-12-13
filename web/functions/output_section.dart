/*
 * Auteurs    : Belkacem Ouarab (904 347 654), Pierre Gagnon (906 326 359) & Paul Gagné (910 161 950)
 *  
 * Professeur : Dzenan Ridjanovic
 * Cours      : SIO-6014 APPLICATIONS WEB DES SIO
 *
 * Description: Dans ce 'part', nous avons la logique utilisée pour la création de la table
 * de vérité et de chronogramme.
 *  
 */


part of circlo;

Map     fullVarInput    = new Map();
List    hdr           = new List();

int     lDigit        = 0;
int     noVariables   = 0; 

build_output() {

  int     position      = 0;
  int     bin           = 1;
  int     chg           = 0;
  int     cnt           = 0;
  int     cnt2          = 0;
  List    eValues       = new List();
  
  
  for (int i = 0; i < userInput.length; i++)
  {

    if (userInput[i].value.substring(0,1) == 'e')
    {
      fullVarInput.putIfAbsent(userInput[i].value, () => new List());
    }
    noVariables = fullVarInput.length;
  }
  
  lDigit = pow(2, noVariables);
  for ( int i = 0; i < lDigit * 2; i++)
  {
    hdr.add(bin);
    bin = ( bin == 0) ? 1 : 0;
  }
  
  for ( int i = 0; i <= 4; i ++)
  {
    if ( fullVarInput.containsKey('e${i}') )
    {
      cnt++;
      chg = pow(2, noVariables - cnt);
      bin  = 0;
      cnt2 = 0;
      eValues = new List();
      for ( int j = 0; j < lDigit; j++)
      {
        eValues.add(bin);
        cnt2++;
        if ( cnt2 == chg )
          {
            bin  = ( bin == 0) ? 1 : 0;
            cnt2 = 0;
          }
      }
      fullVarInput['e${i}'] = eValues;
    }
  }
  
 
}

built_truth_tab() {
  
//  Ajout dynamique sur la page HTML value pour la table de vérité
  
  TableElement truthTab = query("#truthtab");
  
  String tableTH = "<tr><th colspan='${noVariables}'>Entrées de Circuit logique</th><th>Sortie</th></tr>";
  String tableTD = "";
  
  truthTab.appendHtml(tableTH);
  
  tableTD = '${tableTD}<tr>';  
  for ( int j = 0; j <= 4; j ++)
  {
    if ( fullVarInput.containsKey('e${j}') )
    {
      tableTD = '${tableTD} <th class=nobg> e${j} </th>';
    }
  }
  tableTD = '${tableTD} <th class=nobg> S0 </th>';
  tableTD = '${tableTD} </tr>';
  
  for ( int i = 0; i < lDigit; i++ )
  {
    tableTD = '${tableTD}<tr>';  
    for ( int j = 0; j <= 4; j ++)
    {
      if ( fullVarInput.containsKey('e${j}') )
      {
        tableTD = '${tableTD} <td> ${fullVarInput['e${j}'][i]} </td>';
      }
    }
    tableTD = '${tableTD} <td> ${result[i]} </td>';
    tableTD = '${tableTD}</tr>';    
    
  }
    tableTD = '${tableTD} </tr>';
    truthTab.appendHtml(tableTD);
  
}


graph_output(String name, List Ei, rank)
{
  
  CanvasElement canvas             = query("#chrono");
  CanvasRenderingContext2D context = canvas.getContext('2d');
  
  int dim        = 15;
  int dDim       = dim * 2;
  
  int x_position = 1;
  int h_bas      = ( name == 'H' ) ? 70 : 70 + rank * dDim * 2;
  int h_haut     = ( name == 'H' ) ? 40 : 40 + rank * dDim * 2;
  int h_period   = ( name == 'H' ) ? dim : dDim;
  
  int i     = 1;
  int n     = Ei.length;
  int j     = x_position + 15;
  int posX  = 0;
  int posX2 = 0;
  int k     = ( name == 'H' ) ? 1 : 2;

  //juster Canvas
  if ( name == 'H' )
  {
    int width = dim*n  + 15;
    if ( width < 450 ) width = 450;
    canvas.width  = width;
    canvas.height = 2*dDim*noVariables + 135;
  }
  
  
  //Arrière plan
  context.beginPath(); 
  context.lineWidth   = 1;
  context.strokeStyle = '#AEEEEE'; 
  
  if ( name == 'H' ) { // Ligne top
    context.moveTo(x_position+ dim , h_haut-dDim);
    context.lineTo(x_position+ n*dim*k+dim , h_haut-dDim);
  }
  context.moveTo(x_position, h_haut);
  context.lineTo(x_position+ n*dim*k+dim , h_haut); // Ligne supérieur
  context.moveTo(x_position, h_bas);
  context.lineTo(x_position+ n*dim *k+dim, h_bas);  // Ligne inférieur
  context.moveTo(x_position, h_bas);
  context.lineTo(x_position, h_haut);
  context.font = '10pt Calibri';
  
  posX  = posX  + dim ;
  posX2 = posX2 + dim ;
  
  for (int l = 1; l <= n * k + 1 ; l++)
  {
    context.moveTo(posX, h_haut-dDim);
    context.lineTo(posX, h_bas);
    if (name == 'H' && l <= n / 2) // Entête numérique
    {
      context.fillText(l.toString(), ( l > 9 ) ? posX2+1 : posX2+5, h_haut-10);   
    }
    posX  = posX  + dim ;
    posX2 = posX2 + dDim ;

  }
  context.stroke();
  context.closePath();
 
  //Chronogramme 
  context.beginPath();
  context.lineWidth = 1;
  context.strokeStyle = 'red'; 
  context.moveTo(j, h_bas);
  context.font = '10pt Calibri';
  context.fillText(name, x_position, h_bas-10); // nom variable
  if (Ei[0]==0)
    {
      context.lineTo(j+h_period, h_bas);
    }
  else 
    { 
      context.lineTo(j, h_haut);
      context.lineTo(j+h_period, h_haut);
    }
  j=j+h_period;
  while (i<n) 
  {
    if (Ei[i-1]==0 && Ei[i]==0)
        {// Le précédent = 0 et l'actuelle = 0
         // context.moveTo(j, );
          context.lineTo(j+h_period, h_bas);
        } 
      else if (Ei[i-1]==0 && Ei[i]==1)
          {// Le précédent = 0 et l'actuelle = 1
              context.lineTo(j, h_haut);
              context.lineTo(j+h_period, h_haut);
          } 
      else if (Ei[i-1]==1 && Ei[i]==0)
      {// Le précédent = 1 et l'actuelle = 0
          context.lineTo(j, h_bas);
          context.lineTo(j+h_period, h_bas);    
        } 
    else 
      {// Le précédent = 1 et l'actuelle = 1
          context.lineTo(j+h_period, h_haut);
          context.lineWidth = 1;      
        }
  j=j+h_period;
  i=i+1;
  
}

  context.stroke();
  context.closePath(); 

}

build_chrono() {
  
    int rank = 0;
    
    graph_output('H', hdr, 0);
    
    // Variable
    for ( int j = 0; j <= 4; j ++)
    {
      if ( fullVarInput.containsKey('e${j}') )
      {
        graph_output('e${j}', fullVarInput['e${j}'], ++rank);
      }
    }
    
    //Result
    graph_output('S0', result, ++rank);
    

  
}

clear_output() {
    
  fullVarInput    = new Map();
  hdr           = new List();
  result        = new List();
  lDigit        = 0;
  noVariables   = 0; 
  
  
  TableElement truthTab = query("#truthtab");
  truthTab.innerHtml = "";
  
  CanvasElement canvas             = query("canvas");
  CanvasRenderingContext2D context = canvas.getContext('2d');
  canvas.width  = 450;
  canvas.height = 150;
  context.clearRect(0,0,450,150);
  
}


print_output() {
  
  built_truth_tab();  
  build_chrono();
  
}
