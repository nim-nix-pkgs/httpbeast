{
  description = ''A performant and scalable HTTP server.'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-httpbeast-v0_2_1.flake = false;
  inputs.src-httpbeast-v0_2_1.owner = "dom96";
  inputs.src-httpbeast-v0_2_1.ref   = "refs/tags/v0.2.1";
  inputs.src-httpbeast-v0_2_1.repo  = "httpbeast";
  inputs.src-httpbeast-v0_2_1.type  = "github";
  
  inputs."asynctools".owner = "nim-nix-pkgs";
  inputs."asynctools".ref   = "master";
  inputs."asynctools".repo  = "asynctools";
  inputs."asynctools".type  = "github";
  inputs."asynctools".inputs.nixpkgs.follows = "nixpkgs";
  inputs."asynctools".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-httpbeast-v0_2_1"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-httpbeast-v0_2_1";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}