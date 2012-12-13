/*
 * Auteurs    : Belkacem Ouarab  (904 347 654), Pierre Gagnon (906 326 359) & Paul Gagné (910 161 950)
 *  
 * Professeur : Dzenan Ridjanovic
 * Cours      : SIO-6014 APPLICATIONS WEB DES SIO
 *
 * Description: Dans ce 'part', nous avons la logique utilisée pour la partie supérieure de la
 * page HTML 5. Elle contient donc la logique pour la saisie de donnée.   
 */


part of circlo;

setObjects() {
  
  // Creation des éléments qui seront placés sur la page web 
   
  gates.putIfAbsent("D1", () => new Gate("D1","css/not.png","not"));
  gates.putIfAbsent("D2", () => new Gate("D2","css/and.png","and"));
  gates.putIfAbsent("D3", () => new Gate("D3","css/or.png","or"));
  gates.putIfAbsent("D4", () => new Gate("D4","css/nand.png","nand"));
  gates.putIfAbsent("D5", () => new Gate("D5","css/nor.png","nor"));
  gates.putIfAbsent("D6", () => new Gate("D6","css/xor.png","xor"));
  
  variables.putIfAbsent("V0", () => new Variable("V0","e0"));
  variables.putIfAbsent("V1", () => new Variable("V1","e1"));
  variables.putIfAbsent("V2", () => new Variable("V2","e2"));
  variables.putIfAbsent("V3", () => new Variable("V3","e3"));
  variables.putIfAbsent("V4", () => new Variable("V4","e4")); 
  
  delimiters.putIfAbsent("DL0", () => new Delimiter("DL0","("));
  delimiters.putIfAbsent("DL1", () => new Delimiter("DL1",")"));
  
}

setInput() {
  
//  Ajout dynamique sur la page HTML des bouttons que l'utilisateur peut activer
  
  TableElement gatesTab = query("#gatesAndVar");
  
  String tableTH = "<tr><th>Entrée</th>";
  String tableTD = "<tr><td></td>";
  
  for (int i = 1; i <= gates.length; i++) {
     Gate door = gates["D${i}"];
    tableTH = "${tableTH} <th>${door.value}</th>";
    tableTD = "${tableTD} <td><button> <img id=${door.name} src='${door.url}' alt='${door.value}' /> </button></td>";
  };
  
  tableTH = "${tableTH} </tr>";
  tableTD = "${tableTD} </tr>";
  
  for (int i = 0; i < variables.length; i++) {
    Variable variable = variables["V${i}"];
    tableTD = "${tableTD} <tr><td><button type=button id='${variable.name}'> ${variable.value} </button></td></tr>";
  };
  
  gatesTab.appendHtml("${tableTH} ${tableTD}");
  
  TableElement delTab = query("#delimiters");
  tableTH = "<tr><th colspan= ${delimiters.length}>Délimiteurs</th>";
  tableTD = "<tr>";
  
  for (int i = 0; i < delimiters.length; i++) {
    Delimiter delimiter = delimiters["DL${i}"];
    tableTD = "${tableTD} <td><button type=button id='${delimiter.name}'> ${delimiter.value} </button></td>";
  };
  tableTD = "${tableTD} </tr>";
  
  delTab.appendHtml("${tableTH} ${tableTD}");
  
  setEvent();
  
}

setEvent() {
  
//  Ajout de la logique des événements sur le boutton
  
  //Gates
  gates.forEach( ( key, door) {
    ImageElement doorImage = query('#${door.name}');
    doorImage.on.click.add( (Event e) {
      ImageElement img = e.target;
      userInput.add(gates[img.id]);
      buildOutputFunction();
    });
  });
  //Buttons
  ButtonElement erase = query('#erase');
  erase.on.click.add( (Event e) {
    if ( userInput.length > 0 )
    {
     userInput.removeLast();
     buildOutputFunction();
     TextAreaElement analysis = query('#analysis');
     analysis.value = "";
     clear_output(); //Erase output
    }
  });
  
  ButtonElement restart = query('#restart');
  restart.on.click.add( (Event e) {
    userInput = new List();
    buildOutputFunction();
    TextAreaElement analysis = query('#analysis');
     analysis.value = "";
     clear_output(); //Erase output
    });
  
  ButtonElement exec = query('#exec');
  exec.on.click.add( (Event e) {
    analyse();
    });

  variables.forEach( ( key, variable) {
    ButtonElement butVar = query('#${variable.name}');
    butVar.on.click.add( (Event e) {
     ButtonElement buttonVar = e.target;
     userInput.add(variables[buttonVar.id]);
     buildOutputFunction();
    });
  });
  
  delimiters.forEach( ( key, delimiter) {
    ButtonElement butDl = query('#${delimiter.name}');
    butDl.on.click.add( (Event e) {
     ButtonElement buttonVar = e.target;
     userInput.add(delimiters[buttonVar.id]);
     buildOutputFunction();
    });
  });
  
}

buildOutputFunction() {

//  Constrution du text de la fonction pour l'utilisateur
  
  InputElement userFunction = query('#userFunction');
  
  String text = "S0 =";
 for (int i = 0; i < userInput.length; i++)
  {
    text = text.concat(' ${userInput[i].value}');
  }
  userFunction.value = text;
   
}