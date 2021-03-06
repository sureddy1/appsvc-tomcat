#!/bin/bash
service ssh start

if [ ! -d "/home/site/conf" ]; then
	echo "Info: Tomcat configuration directory is not available. Creating one"
	mkdir -p /home/site/conf
	cp -R /usr/local/tomcat/conf/. /home/site/conf/	
else
	echo "Info: Tomcat configuration directory already exists"
fi

rm -rf /usr/local/tomcat/conf 
ln -s /home/site/conf /usr/local/tomcat/conf

chown -R root:root /home/site/conf

cd /home/site/wwwroot

test ! -e "ROOT.war" && wget -O ROOT.war https://raw.githubusercontent.com/sureddy1/appsvc-tomcat/master/apps/ROOT.war
test ! -e "examples.war" && wget -O examples.war https://raw.githubusercontent.com/sureddy1/appsvc-tomcat/master/apps/examples.war
test ! -e "host-manager.war" && wget -O host-manager.war https://raw.githubusercontent.com/sureddy1/appsvc-tomcat/master/apps/host-manager.war
test ! -e "manager.war" && wget -O manager.war https://raw.githubusercontent.com/sureddy1/appsvc-tomcat/master/apps/manager.war
test ! -e "docs.war" && wget -O docs.war https://raw.githubusercontent.com/sureddy1/appsvc-tomcat/master/apps/docs.war

/usr/local/tomcat/bin/catalina.sh run