{ pkgs, ... }:
{
  # there are two modes
  # there is offload and SYNC
  # TL;DR SYNC offers better gaming performance at cost of battery
  # Offload offers better battery at the cost of gaming performance
  
  # NVIDIA
  hardware.nvidia.prime = {
    sync.enable = true;

    # Integrated 
    amdgpuBusId = "PCI:12:0:0";

    # Dedicated
    nvidiaBusId = "PCI:11:0:0";
  };
  
  # STEAM
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;

  environment.systemPackages = with pkgs; [
    mangohud # to check performance
    protonup-qt # add proton compatability layer
  ];
  
  # Using proton in steam
  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = 
      "/home/austinb/.steam/root/compatabilitytools.d";
  };

  programs.gamemode.enable = true; # need to put gamemoderun %command% in luanch options on steam
}
