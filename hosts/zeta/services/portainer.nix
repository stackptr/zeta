{
  image = "portainer/portainer-ee:latest";
  ports = [
    "8000:8000"
    "9443:9443"
  ];
  volumes = [
    "/var/run/docker.sock:/var/run/docker.sock"
    "portainer_data:/data"
  ];
  autoStart = true;
  extraOptions = [
    "--network=host"
  ];
}