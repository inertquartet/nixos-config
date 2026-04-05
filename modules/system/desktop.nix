{ pkgs, ... }:
{
	# KDE Plasma 6 on Wayland
	services.desktopManager.plasma6.enable = true;

	# SDDM display manager w/ Wayland backend
	services.displayManager.sddm = {
		enable = true;
		wayland.enable = true;
	};

	# XWayland for legacy X11 app compatibility
	programs.xwayland.enable = true;

	# KDE-specific system packages
	environment.systemPackages = with pkgs; [
		kdePackages.kate 		# text editor
		kdePackages.ark			# archive manager
		kdePackages.gwenview		# image viewer
		kdePackages.okular		# document viewer
		kdePackages.filelight		# disk usage visualizer
		kdePackages.kdeconnect-kde	# phone integration
	];

	# Enable KDE Connect firewall rules
	programs.kdeconnect.enable = true;

	# Ensure portalz work correctly under Plasma
	xdg.portal = {
		enable = true;
		extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];
	};
}
