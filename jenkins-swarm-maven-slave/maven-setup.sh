#!/bin/bash
set -e

# Setup nexus as the maven proxy
if [ -n "${NEXUS_REPO}" ] ; then
    mkdir -p "${MAVEN_CONFIG}"
    cat > ${MAVEN_CONFIG}/settings.xml <<EOF
<settings xmlns="http://maven.apache.org/SETTINGS/1.1.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.1.0 http://maven.apache.org/xsd/settings-1.1.0.xsd">

  <mirrors>
    <mirror>
      <id>nexus</id>
      <name>Local Maven Repository Manager</name>
      <url>${NEXUS_REPO}</url>
      <mirrorOf>*</mirrorOf>
    </mirror>
  </mirrors>
  <servers>
    <server>
      <id>deployment</id>
      <username>deployment</username>
      <password>deployment123</password>
    </server>
  </servers>
</settings>
EOF
fi
