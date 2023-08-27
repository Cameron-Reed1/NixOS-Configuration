{ ... }:

{
  fileSystems."/home" = {
    # Disable checking /home partition with fsck
    # Arch has a newer version than Nix, so it errors
    noCheck = true;
  };
}
