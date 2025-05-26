
# Desktop system config

{ config, lib, pkgs, ... }: 
{
    # boot.loader.efi.efiSysMountPoint = "/boot";

	boot.loader.grub.enable = true;
	boot.loader.grub.devices = [ "nodev" ];
	boot.loader.grub.efiInstallAsRemovable = true;
	boot.loader.grub.efiSupport = true;
	boot.loader.grub.useOSProber = true;
    
    networking.hostName = "shogun-desktop";
    networking.networkmanager.enable = true;

    time.timeZone = "Europe/Lisbon";
	i18n.extraLocaleSettings = {
		LC_ADDRESS = "pt_PT.UTF-8";
		LC_IDENTIFICATION = "pt_PT.UTF-8";
		LC_MEASUREMENT = "pt_PT.UTF-8";
		LC_MONETARY = "pt_PT.UTF-8";
		LC_NAME = "pt_PT.UTF-8";
		LC_NUMERIC = "pt_PT.UTF-8";
		LC_PAPER = "pt_PT.UTF-8";
		LC_TELEPHONE = "pt_PT.UTF-8";
		LC_TIME = "pt_PT.UTF-8";
	};

	system.tools.nixos-option.enable = true;

	hardware.opengl = {
		enable = true;
		driSupport32Bit = true;
	};

	hardware.nvidia = {
		modesetting.enable = true;
		open = false;

		nvidiaSettings = true;
		package = config.boot.kernelPackages.nvidiaPackages.latest;
	};

    services.openssh = {
		enable = true;
		settings = {
			PermitRootLogin = "no";
			PasswordAuthentication = false;
		};
	};

	# X11 and XServer
	services.xserver = {
		enable = true;
		videoDrivers = ["nvidia"];
		# X11 keymap
		layout = "pt";
		xkbVariant = "";
		displayManager.gdm.enable = true;
		desktopManager.gnome.enable = true;
	};

	console.keyMap = "pt-latin9";

	hardware.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
	};

    environment.systemPackages = with pkgs; [
        libevdev
		libnotify
        kbd
		htop
		neofetch
		dunst
		wget
		rofi

		xwayland
		waybar
		wofi
		wl-clipboard

		wine
		wine64
		winetricks

		vscode
		brave
    ];

	environment.variables={
		NIXPKGS_ALLOW_UNFREE = "1";
		GDK_GL = "gles";

		__GLX_VENDOR_LIBRARY_NAME = "nvidia";
		LIBVA_DRIVER_NAME = "nvidia";
		
		NIXOS_OZONE_WL = "1";
		XDG_SESSION_TYPE = "wayland";
		WLR_NO_HARDWARE_CURSORS = "1";
	};

	programs.appimage.enable = true;

	programs.hyprland = {
		enable = true;
		xwayland.enable = true;
	};

	programs.steam = {
		enable = true;
		remotePlay.openFirewall = true;
		dedicatedServer.openFirewall = true;
	};

	programs.fish.enable = true;

    programs.git.enable = true;

	programs.zsh.enable = true;

	# Configure User - shogun

	home-manager.users.shogun = {
		programs.kitty.enable = true;
	};
    
    users.users.shogun = {
        isNormalUser = true;
        openssh.authorizedKeys.keys = [];
        extraGroups = [ "wheel" "networkmanager" ];
		shell = pkgs.zsh;
    };

	nix.settings.experimental-features = [ "nix-command" "flakes" ];

    nix.gc = {
		automatic = true;
		dates = "weekly";
		options = "--delete-older-than 7d";
	};

    #system.autoUpgrade = {
	#	enable = true;
	#	channel = "https://nixos.org/channels/nixos-24.11";
	#};

    system.stateVersion = "24.11";
}
