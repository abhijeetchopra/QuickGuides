# --------------------------------------
# Auth: Abhijeet Chopra
# Date: Tue July 17, 2018
# Desc: Quick Fedora Guide
# --------------------------------------

1. getfedora.com > workstation > download now > other downloads > 64-bit 1.5 GB live image (iso) 
2. Oracle VM VirtualBox Manager > New > Name: "Fedora" Ram : "2018" > HDD : "20.00 GB"
3. Settings > Storage > Controller : IDE -> Empty > Optical Drive > Selct ISO 
4. Start > Press Enter > Install to Hard-drive > English > Installation destination ( 20.GB HDD ) -> Done > Begin Installation > Set Root Password > User Creation : Make admin > Done > Quit ( after installation ).
5. Shutdown VM > Unmount ISO Disk > Start VM again.
  CTRL + SHIFT + '+' >> Inc. Terminal Font Size
6. $ sudo dnf install f26-backgrounds-gnome
   $ sudo dnf install f-26-backgrounds-extras-gnome
