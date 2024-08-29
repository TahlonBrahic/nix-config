# Tahlon's NixOS Configuration

This repository contains a modular NixOS configuration designed to support multiple machines with profile support distributed across those machines.

## Directory Structure

- **`flake.nix`**: The main entry point for the NixOS configurations.
- **`LICENSE`**: A standard MIT License for ease of distribution and modification.
- **`README.md`**: This file, which provides an overview of the repository.
- **`home-manager`**: Contains user-specific configurations managed by Home Manager.
- **`hosts`**: Defines the hosts I use in my day-to-day.
- **`modules`**: Contains reusable modules for hardware, networking, security, services, and shells.
- **`overlays`**: Custom packages or package overrides.
- **`profiles`**: Defines user profiles that are shared between hosts.
- **`secrets`**: Secures storage for sensitive information (e.g., API keys, passwords).
- **`themes`**: Custom themes for the desktop environments and applications.

## Getting Started 

As this is still in developement it is not recommended to clone this repository.

I still encourage this to be used as a basis for other repositories as it is an aggregation of 
many hours of learning and studying similar configurations.

I will publish a full installation guide when it reaches its first build.

## Helper 

The idea I am going for is to select a profile that selects a group of packages from /home-manager that are GUI agnostic as well as anything in modules.
You can then select what you wish in terms of display manager and window-manager.
This is just an idea and amy not need a helper.

## References

The following websites and/or content creators were the most influential in the help of the developement of this NixOS repository and my understanding of both NixOS and its language:

[nix.dev](https://nix.dev/tutorials/nix-language)

