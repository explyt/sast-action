#!/usr/bin/env bash

docker run -i -a stdout -a stderr -v /var/run/docker.sock:/var/run/docker.sock -v /github/workspace:/data/projects/project -v /github/workspace:/data/reports -e CONTAINER_UID="$(id -u)" -e CONTAINER_GID="$(id -g)" --entrypoint='/bin/bash' ghcr.io/explyt/usvm-project-analyzer:2024-08-12-obfuscated -c "echo start; /home/usvm/usvm_docker_entrypoint.sh --build autobuild --projects-root-dir /data/projects/project --output-dir /data/reports --ifds-analysis-timeout=1000 --verbosity=info 2>&1; echo finish"