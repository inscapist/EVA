{ theme, ... }:

with theme; {
  xdg.configFile."wofi/style.css".text = ''
    window { background: unset; }
    flowboxchild { outline-width: 0; }

    #outer-box {
      background: ${colors.base};
      border: 1px solid ${colors.border};
      border-radius: 24px;
      box-shadow: 0 2px 3px ${colors.crust};
      margin: 5px 5px 10px;
      padding: 5px 5px 10px;
    }

    #input {
      background-color: ${colors.crust};
      border: none;
      border-radius: 16px;
      color: ${colors.text};
      margin: 5px;
    }

    #inner-box {
      background-color: ${colors.base};
      border: none;
      border-radius: 16px;
      margin: 5px;
    }

    #scroll {
      border: none;
      margin: 0px;
    }

    #text {
      color: ${colors.text};
      margin: 5px;
    }

    #entry { border-radius: 16px; }

    #entry:selected {
      background-color: ${colors.surface0};
    }
  '';
}
