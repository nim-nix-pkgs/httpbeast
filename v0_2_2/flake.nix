{
  description = ''A super-fast epoll-backed and parallel HTTP server.'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-httpbeast-v0_2_2.flake = false;
  inputs.src-httpbeast-v0_2_2.ref   = "refs/tags/v0.2.2";
  inputs.src-httpbeast-v0_2_2.owner = "dom96";
  inputs.src-httpbeast-v0_2_2.repo  = "httpbeast";
  inputs.src-httpbeast-v0_2_2.type  = "github";
  
  inputs."github-timotheecour-asynctools".owner = "nim-nix-pkgs";
  inputs."github-timotheecour-asynctools".ref   = "master";
  inputs."github-timotheecour-asynctools".repo  = "github-timotheecour-asynctools";
  inputs."github-timotheecour-asynctools".dir   = "master";
  inputs."github-timotheecour-asynctools".type  = "github";
  inputs."github-timotheecour-asynctools".inputs.nixpkgs.follows = "nixpkgs";
  inputs."github-timotheecour-asynctools".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-httpbeast-v0_2_2"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-httpbeast-v0_2_2";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}