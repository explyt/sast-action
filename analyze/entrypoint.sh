#!/usr/bin/env bash

VERSION=2025-03-06-2

PROJECT_ROOT=$(echo "$ANALYZE_PROJECT_ROOT" | cut -c7- | rev | cut -c7- | rev)
echo "Run analyzer on $PROJECT_ROOT"

ANALYZER_ARGS="--build autobuild --ifds-analysis-timeout=1000 --verbosity=info --ifds-ap-mode=Tree"

if [ "$ANALYZE_PROJECT_KIND" = "spring" ]; then
  ANALYZER_ARGS="$ANALYZER_ARGS --project-kind spring-web";
fi

if [[ -n $ANALYZE_CONFIG ]]; then
  ANALYZER_ARGS="$ANALYZER_ARGS --config $ANALYZE_CONFIG";
fi

echo "Analyzer params: $ANALYZER_ARGS"

docker run -i -a stdout -a stderr -v /var/run/docker.sock:/var/run/docker.sock -v "$PROJECT_ROOT":/data/projects/project -v "$PROJECT_ROOT":/data/reports -e CONTAINER_UID="$(id -u)" -e CONTAINER_GID="$(id -g)" --entrypoint='/bin/bash' explyt/usvm-project-analyzer:"$VERSION" -c "echo start; ls -la /data/projects/project; /home/usvm/usvm_docker_entrypoint.sh --projects-root-dir /data/projects/project --output-dir /data/reports $ANALYZER_ARGS 2>&1; echo finish"