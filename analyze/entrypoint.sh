docker run -it --rm \
  -v "/var/run/docker.sock":"/var/run/docker.sock" \
  -v "$INPUT_PROJECT":/data/projects/project \
  -v "$INPUT_PROJECT":/data/reports \
  -e CONTAINER_UID="$(id -u)" -e CONTAINER_GID="$(id -g)" \
  ghcr.io/explyt/usvm-project-analyzer:2024-08-12-obfuscated \
  --build autobuild \
  --projects-root-dir /data/projects/project \
  --output-dir /data/reports \
  --ifds-analysis-timeout=1000 \
  --verbosity info