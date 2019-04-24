#!/bin/bash
#This is a script  scan for ports

dates=`date '+%Y-%m-%d %H:%M:%S'`
echo "$dates"
echo "Enter the name of the Project"
read projectname
echo "Enter the ip of the target E.g. 127.0.0.1"
read ipaddress
function valid_ip()
{
    local  ip=$1
    local  stat=1

    if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        OIFS=$IFS
        IFS='.'
        ip=($ip)
        IFS=$OIFS
        [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 \
            && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
        stat=$?
    fi
    return $stat
}
if valid_ip $ipaddress; then
	echo "valid ip"
else 
	echo "Bad ip"
	exit
fi
if [ "$EUID" -ne 0 ]
then
echo "Please run as the root ......exiting"
exit
fi

echo "scan started .... please wait"
nmap -Pn -sS -sV -A  $ipaddress >> "$projectname.txt"
echo "Enumerating..."
smbclient -N -L \\$ipaddress >> "$projectname.txt"
whois -B $ipaddress >> "$projectname.txt"
dirb "http://$ipaddress" >> "$projectname.txt"
while :
do
echo "Do you wish to further scan a port (y/n)"
read option
if [ $option == "y" ]
then
echo "Enter the port number"
read port
re='^[0-9]+$'
if ! [[ $port =~ $re ]] ; then
   echo "error: Not a valid port number" 
	continue;
else
	nmap $ipaddress -p $port -sV -n -A >> "$projectname.txt"
	amap $ipaddress $port >> "$projectname.txt"
fi

elif [ $option == "n" ]
then
echo "All done "
break;
else
echo "wrong input .... Enter your choice again"
fi
done



#ip = $(cut -d / -f1 <<< $ipaddress )


