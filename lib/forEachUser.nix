let
  forEachUser = {users}: builtins.attrValues users;
in
  forEachUser
