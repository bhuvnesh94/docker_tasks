#!/bin/sh
# Adding new line
echo  '\n'
# Getting internal ip addresses of running docker containers
echo "All ip addresses of running instance:"
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker ps -aq)
echo  '\n'
# Taking first ip address
echo "selecting 1st ip"
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker ps -aq) | head -n 1
echo  '\n'
# Storing required ip to a variable
cont_ip=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker ps -aq) | head -n 1)
# Printing variable data
echo $cont_ip
echo  '\n'
# Replacing variable data with required location in the file "environment.prod.ts"
sed -i -e    's/\([0-9]\+\).\([0-9]\+\).\([0-9]\+\).\([0-9]\+\):9000/'$cont_ip':9000/' 'environment.prod.ts' 
echo  '\n'
echo "File is updated"
# Getting external ip of the system
echo "your external ip is: "
curl ifconfig.me
echo  '\n'
