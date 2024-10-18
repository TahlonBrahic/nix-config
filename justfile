default:
  @just --list

rebuild:
  git add .
  sudo nixos-rebuild switch 
