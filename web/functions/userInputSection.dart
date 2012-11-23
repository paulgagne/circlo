
/*
 * Auteur     : Belkacem Ouarab, Pierre Gagnon & Paul Gagné
 * No étudiant: 910161950
 * Professeur : Dzenan Ridjanovic
 * Cours      : SIO-6014 APPLICATIONS WEB DES SIO
 *
 * Description: 
 */


part of circlo;

setObjects() {
   
  syntax.putIfAbsent("D1", () => new Door("D1","css/not.png","NOT"));
  syntax.putIfAbsent("D2", () => new Door("D2","css/and.png","AND"));
  syntax.putIfAbsent("D3", () => new Door("D3","css/or.png","OR"));
  syntax.putIfAbsent("D4", () => new Door("D4","css/nand.png","NAND"));
  syntax.putIfAbsent("D5", () => new Door("D5","css/nor.png","NOR"));
  syntax.putIfAbsent("D6", () => new Door("D6","css/xor.png","XOR"));
  
  variables.putIfAbsent("V0", () => new Variable("V0","E0"));
  variables.putIfAbsent("V1", () => new Variable("V1","E1"));
  variables.putIfAbsent("V2", () => new Variable("V2","E2"));
  variables.putIfAbsent("V3", () => new Variable("V3","E3"));
  variables.putIfAbsent("V4", () => new Variable("V4","E4")); 
  
  delimiters.putIfAbsent("DL0", () => new Delimiter("DL0","("));
  delimiters.putIfAbsent("DL1", () => new Delimiter("DL1",")"));
  delimiters.putIfAbsent("DL2", () => new Delimiter("DL2","#"));
  
}

setInput() {
  
  TableElement doorsTab = query("#doorsAndVar");
  
  String tableTH = "<tr><th>Entrée</th>";
  String tableTD = "<tr><td></td>";
  
  for (int i = 1; i <= syntax.length; i++) {
     Door door = syntax["D${i}"];
    tableTH = "${tableTH} <th>${door.value}</th>";
    tableTD = "${tableTD} <td><button> <img id=${door.name} src='${door.url}' alt='${door.value}' /> </button></td>";
  };
  
  tableTH = "${tableTH} </tr>";
  tableTD = "${tableTD} </tr>";
  
  for (int i = 0; i < variables.length; i++) {
    Variable variable = variables["V${i}"];
    tableTD = "${tableTD} <tr><td><button type=button id='${variable.name}'> ${variable.value} </button></td></tr>";
  };
  
  doorsTab.addHTML("${tableTH} ${tableTD}");
  
  TableElement delTab = query("#delimiters");
  tableTH = "<tr><th colspan= ${delimiters.length}>Délimiteurs</th>";
  tableTD = "<tr>";
  
  for (int i = 0; i < delimiters.length; i++) {
    Delimiter delimiter = delimiters["DL${i}"];
    tableTD = "${tableTD} <td><button type=button id='${delimiter.name}'> ${delimiter.value} </button></td>";
  };
  tableTD = "${tableTD} </tr>";
  
  delTab.addHTML("${tableTH} ${tableTD}");
  
  setEvent();
  
}

setEvent() {
  
  //Doors
  syntax.forEach( ( key, door) {
    ImageElement doorImage = query('#${door.name}');
    doorImage.on.click.add( (Event e) {
      ImageElement img = e.srcElement;
      userInput.add(syntax[img.id]);
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
    }
  });
  
  ButtonElement restart = query('#restart');
  restart.on.click.add( (Event e) {
    userInput = new List();
    buildOutputFunction();
    TextAreaElement analysis = query('#analysis');
     analysis.value = "";
    });
  
  ButtonElement exec = query('#exec');
  exec.on.click.add( (Event e) {
    analyse();
    });

  variables.forEach( ( key, variable) {
    ButtonElement butVar = query('#${variable.name}');
    butVar.on.click.add( (Event e) {
     ButtonElement buttonVar = e.srcElement;
     userInput.add(variables[buttonVar.id]);
     buildOutputFunction();
    });
  });
  
  delimiters.forEach( ( key, delimiter) {
    ButtonElement butDl = query('#${delimiter.name}');
    butDl.on.click.add( (Event e) {
     ButtonElement buttonVar = e.srcElement;
     userInput.add(delimiters[buttonVar.id]);
     buildOutputFunction();
    });
  });
  
}

buildOutputFunction() {
  
  InputElement userFunction = query('#userFunction');
  
  String text = "S = ";
  for (int i = 0; i < userInput.length; i++) {
    text = "${text} ${userInput[i].value}";
    
  }
  userFunction.value = text;
   
}
