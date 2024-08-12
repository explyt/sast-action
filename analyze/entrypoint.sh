#!/usr/bin/env bash

prefix="xxx___"
suffix="___xxx"
PROJECT_ROOT=${"$ANALYZE_PROJECT_ROOT"#"$prefix"}
PROJECT_ROOT=${PROJECT_ROOT%"$suffix"}
export PROJECT_ROOT

echo $PROJECT_ROOT

docker run -i -a stdout -a stderr -v /var/run/docker.sock:/var/run/docker.sock -v "$PROJECT_ROOT":/data/projects/project -v "$PROJECT_ROOT":/data/reports -e CONTAINER_UID="$(id -u)" -e CONTAINER_GID="$(id -g)" --entrypoint='/bin/bash' ghcr.io/explyt/usvm-project-analyzer:2024-08-12-obfuscated -c "echo start; ls -la /data/projects/project; /home/usvm/usvm_docker_entrypoint.sh --build autobuild --projects-root-dir /data/projects/project --output-dir /data/reports --ifds-analysis-timeout=1000 --verbosity=debug 2>&1; echo finish"