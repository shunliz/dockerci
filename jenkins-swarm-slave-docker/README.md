# Jenkins swarm slave

[`openfrontier/jenkins-swarm-slave`](https://hub.docker.com/r/openfrontier/jenkins-swarm-slave/)

A [Jenkins swarm](https://wiki.jenkins-ci.org/display/JENKINS/Swarm+Plugin) slave.

## Running

To run a Docker container passing [any parameters](https://wiki.jenkins-ci.org/display/JENKINS/Swarm+Plugin#SwarmPlugin-AvailableOptions) to the slave

    docker run openfrontier/jenkins-swarm-slave -master http://jenkins:8080 -username jenkins -password jenkins -executors 1

Linking to the Jenkins master container there is no need to use `--master`

    docker run -d --name jenkins -p 8080:8080 openfrontier/jenkins
    docker run -d --link jenkins:jenkins openfrontier/jenkins-swarm-slave -username jenkins -password jenkins -executors 1
