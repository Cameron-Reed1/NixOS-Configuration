{ services, ... }:

{
  services.frp = {
    enable = true;
    role = "client";
    settings = {
      common = {
        server_addr = "45.79.110.117";
        server_port = 7486;

        authentication_method = "token";
        token = "6%i&MOc@!RPE6xGkRuABnp*3S";
      };

      mc_vh = {
        type = "tcp";
        local_ip = "127.0.0.1";
        local_port = 25565;
        remote_port = 35000;
      };
    };
  };
}
