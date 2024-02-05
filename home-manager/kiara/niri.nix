{ pkgs, ... }:

{

	home.packages = with pkgs; [
		swaybg
		xwayland
	];

}
