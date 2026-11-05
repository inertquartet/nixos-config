{ ... }:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings."*" = {
      # Essential — your 1Password agent
      IdentityAgent = "~/.1password/agent.sock";

      # The one default worth overriding: 0 → 60
      # Keeps NAT/firewall middleboxes from silently killing idle sessions
      ServerAliveInterval = 60;
      ServerAliveCountMax = 3;

      # Optional: connection reuse (multiplexing)
      # ControlMaster = "auto";
      # ControlPath = "~/.ssh/cm-%C";
      # ControlPersist = "10m";

      # Optional: privacy — hides which hosts you've visited
      # HashKnownHosts = "yes";
    };
  };
}
