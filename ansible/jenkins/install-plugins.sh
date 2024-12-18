#!/bin/bash

set -x
for plugin in $(cat /var/lib/jenkins/config/plugins.txt); do
  java -jar /var/lib/jenkins/config/jenkins-cli.jar \
  -s http://localhost:8080/ \
  -auth admin:jenkins@admin@2023# \
  install-plugin $plugin;
done

java -jar /var/lib/jenkins/config/jenkins-cli.jar -s http://localhost:8080/ -auth admin:jenkins@admin@2023# safe-restart