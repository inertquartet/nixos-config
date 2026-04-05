{ ... }:

{
  services.snapper = {
    snapshotInterval = "hourly";
    cleanupInterval = "1d";

    configs = {
      home = {
        SUBVOLUME = "/home";
        ALLOW_USERS = [ "inertquartet" ];
	TIMELINE_CREATE = true;
	TIMELINE_CLEANUP = true;
	TIMELINE_LIMIT_HOURLY = "6";
	TIMELINE_LIMIT_DAILY = "14";
	TIMELINE_LIMIT_WEEKLY = "4";
	TIMELINE_LIMIT_MONTHLY = "3";
	TIMELINE_LIMIT_YEARLY = "0";
      };
    };
  };
}
