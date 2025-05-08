/*
https://samleathers.com/posts/2022-02-11-my-new-network-and-sops.html
*/
{
...
}: let
  mode = "0600"; # owner = rw- | group = --- | others = --- 
in {
  sops = {
    age.keyFile = "/home/abhi/.config/sops/age/keys.txt"; 
    defaultSopsFile = ./secrets.yaml;
    secrets = {
      y-key = {
        path = "/home/abhi/.local/share/age/key.txt";
        inherit mode;
      };
      github_ssh_key = {
        path = "/home/abhi/.ssh/id_ed25519";
        inherit mode;
      };
      mobile_ssh_key = {
        path = "/home/abhi/.ssh/id_rsa";
        inherit mode;
      };
      "kde_connect/trusted_device_keys" = {
        path = "/home/abhi/.config/kdeconnect/trusted_devices";
        inherit mode;
      };
      "kde_connect/certificate_pem" = {
        path = "/home/abhi/.config/kdeconnect/certificate.pem";
        inherit mode;
      };
      "kde_connect/privateKey_pem" = {
        path = "/home/abhi/.config/kdeconnect/privateKey.pem";
        inherit mode;
      };
    };
  };
}
