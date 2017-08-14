# dockerci
This is a enhance and integration of the openfrontier project.

# Usefule CLI to setup environment

docker run --name pg-gerrit --net ci-network --volume pg-gerrit-volume:/var/lib/postgresql/data -p 5432:5432 -e POSTGRES_USER=gerrit2 -e POSTGRES_PASSWORD=gerrit -e POSTGRES_DB=reviewdb --restart=unless-stopped -d postgres

docker run --name gerrit --net ci-network -p 29418:29418 --volume gerrit-volume:/var/gerrit/review_site -e WEBURL=http://192.168.8.79/gerrit -e HTTPD_LISTENURL=proxy-http://*:8080/gerrit -e DATABASE_TYPE=postgresql -e DB_PORT_5432_TCP_ADDR=192.168.8.79 -e DB_PORT_5432_TCP_PORT=5432 -e DB_ENV_POSTGRES_DB=reviewdb -e DB_ENV_POSTGRES_USER=gerrit2 -e DB_ENV_POSTGRES_PASSWORD=gerrit -e AUTH_TYPE=LDAP -e LDAP_SERVER=openldap -e LDAP_ACCOUNTBASE="ou=accounts,dc=example,dc=com" -e GERRIT_INIT_ARGS='--install-plugin=download-commands --install-plugin=replication' -e SMTP_SERVER=pop3.126.com -e SMTP_USER=zsl6658 -e SMTP_PASS='1234@1234' -e USER_EMAIL=zsl6658@126.com -e INITIAL_ADMIN_USER=admin -e INITIAL_ADMIN_PASSWORD=passwd -e JENKINS_HOST=jenkins -e GITWEB_TYPE=gitiles --restart=unless-stopped -d openfrontier/gerrit-ci

docker run --name jenkins-volume --entrypoint="echo" openfrontier/jenkins "Create Jenkins volume."



docker run --name jenkins --net ci-network -p 50000:50000 --volumes-from jenkins-volume -e JAVA_OPTS="-Duser.timezone=Asia/Shanghai -Djenkins.install.runSetupWizard=false" -e LDAP_SERVER=openldap -e LDAP_ROOTDN="ou=accounts,dc=example,dc=com" -e LDAP_INHIBIT_INFER_ROOTDN=false -e LDAP_DISABLE_MAIL_ADDRESS_RESOLVER=false -e GERRIT_HOST_NAME='192.168.8.79' -e GERRIT_FRONT_END_URL=http://192.168.8.79/gerrit --restart=unless-stopped -d openfrontier/jenkins --prefix=/jenkins


docker run --name proxy --net ci-network -p 80:80 --restart=unless-stopped -e SERVER_NAME=192.168.8.79 -e CLIENT_MAX_BODY_SIZE=200m -d openfrontier/nginx


docker run --name nexus-volume openfrontier/nexus echo "Create nexus volume."

docker run --name nexus --net ci-network --volumes-from nexus-volume -e CONTEXT_PATH=/nexus -d openfrontier/nexus

docker run --name ldap-ssp --net ci-network --restart=unless-stopped -e -e LDAP_URL=ldap://openldap -e LDAP_BASE="ou=accounts,dc=example,dc=com" -e LDAP_BINDDN=cn=admin,ou=accounts,dc=example,dc=com -e LDAP_BINDPW=secret -e SMTP_HOST=pop3.126.com -e SMTP_USER=zsl6658 -e SMTP_PASS=1234@1234 -e MAIL_FROM=zsl6658@126.com -d openfrontier/ldap-ssp


cat ".ssh/id_rsa.pub" | curl --data @- --user "admin:passwd"  http://192.168.8.79/gerrit/a/accounts/self/sshkeys


docker run --detach \
    --hostname 192.168.8.80 \
    --publish 443:443 --publish 80:80 --publish 8022:22 \
    --name gitlab \
    --restart always \
    --volume /srv/gitlab/config:/etc/gitlab \
    --volume /srv/gitlab/logs:/var/log/gitlab \
    --volume /srv/gitlab/data:/var/opt/gitlab \
    gitlab/gitlab-ce:latest

[root@compass openldap-docker]# cat user.ldif 
dn: uid=steven2,ou=accounts,dc=example,dc=com
objectClass: posixAccount
objectClass: inetOrgPerson
objectClass: organizationalPerson
objectClass: person
homeDirectory: /home/steven2
loginShell: /bin/false
gidNumber: 10000
uid: steven2
cn: steven2 user
displayName: user steven2
uidNumber: 10000
sn: steven2
givenName: steven2
mail: steven2@example.com


docker exec openldap ldapadd -f user.ldif -x -D "cn=steven2,dc=example,dc=com" -w "secret"
docker exec openldap ldappasswd -x -D "cn=admin,dc=example,dc=com" -w "secret" -s "steven1234" "uid=steven2, ou=accounts, dc=example, dc=com"


gitlab: root/12345678
redmine: admin/12345678


gitlab gerrit2 gerrit123

docker exec 9304656e15fd ssh -p 29418 localhost replication start

docker exec 41e2016aa2650e135d25 sed -i "s/\"redmine\/redmine\"//g" /usr/local/bin/nginx-entrypoint.sh

docker exec 41e2016aa2650e135d25 sed -i 42,48d /etc/nginx/conf.d/default.conf

docker exec 9304656e15fd ssh-keygen -q -t rsa -N "" -f /root/.ssh/id_rsa

# Import project
The demo project imported in shell, need to log into gerrit container and remove the demo and demo-docker and

git clone --bare ssh://git@192.168.8.80:8022/shunliz/demo.git
git clone --bare ssh://git@192.168.8.80:8022/shunliz/demo-docker.git
to reimport. Fix this later


#Jekins configure

1, No swarm configure need to remove the swarm label from the job configure.
2, in the global tool configure, add a maven which install from apache as there is no maven installed in jekins image.


# Finally succeed to configure gerrit replication

As we deployed the gitlab in docker and published the port 22 to 8022,
need to "docker exec -it gitlab vim /etc/gitlab/gitlab.rb"
and set 'gitlab_shell_ssh_port' as below:
gitlab_rails['gitlab_shell_ssh_port'] = 8022

then restat the gitlab, then configure replication as ususal and notice the 8022 port.

[root@compass ~]# docker exec gerrit cat /var/gerrit/.ssh/config
Host *
    StrictHostKeyChecking no
    UserKnownHostsFile=/dev/null
    IdentityFile ~/.ssh/id_rsa

Host 192.168.8.80
    User gerrit2
    Port 8022
    IdentityFile /var/gerrit/.ssh/id_rsa
    StrictHostKeyChecking no
    UserKnownHostsFile /dev/null


[root@compass ~]# docker exec gerrit cat /var/gerrit/review_site/etc/replication.config
[remote "demo"]
projects = demo
url = ssh://git@192.168.8.80:8022/shunliz/demo.git
push = +refs/heads/*:refs/heads/*
push = +refs/tags/*:refs/tags/*
push = +refs/changes/*:refs/changes/*
threads = 3

[remote "demo-docker"]         
projects = demo-docker                              
url = ssh://git@192.168.8.80:8022/shunliz/demo-docker.git
push = +refs/heads/*:refs/heads/*      
push = +refs/tags/*:refs/tags/*                   
push = +refs/changes/*:refs/changes/*
threads = 3


make sure ssh -vT git@192.168.8.80 succeed, and you can see 'Welcome to GitLab, Administrator!'

