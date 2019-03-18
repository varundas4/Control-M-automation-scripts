#!/bin/sh
########################################################################
##Script name: auto_ctm_agent_install.sh			      ## 
##Description: Performs silent install of Control-M Agent and services##
##	       on servers listed in srv.txt file 		      ##
##Created & Tested by: Varun Das 	                              ##
########################################################################

set +x;
 
#SSH connect to selected hosts
for host in $(cat /root/Desktop/srv.txt); do

	sshpass -p "redhat" ssh -o StrictHostKeyChecking=no redhat@$host << EOF	

#Pre-checks		 
	echo "Connected to host: $host"
	echo "DNS name: `hostname`"	
	echo "Today's date: `date`"
	echo "Currrent user: `whoami`"

#Check if Agent services pre-exist
#	ps -eaf | grep ctm*
#	rc=$?
#	if [ $rc -eq 0 ]; then
#	echo "Found pre-existing Control-M services. Starting Uninstall."
	
#Uninstalling existing Control-M agent services	
#	cd /home/redhat/BMCINSTALL/uninstall/DRKAI*/
#	sh -x uninstall.sh -silent
#	echo "Pre-existing Control-M services uninstalled successfully."
#	else
#	echo "Initiating fresh installation of Control-M services."
#	fi

#Switch to installation package directory
	cd /home/redhat/
	
#Unzip and extract installation package
	gunzip -r /home/redhat/DRKAI.8.0.00_Linux-x86_64.gz
	tar -xvf /home/redhat/DRKAI.8.0.00_Linux-x86_64

#Change file permissions
	chmod 777 -R FORMS setup.sh Setup_files

#Prepare OS for 32/64-bit installation
	export INSTALL_AGENT_LINUX_X86_64=Y

#Installation of Control-M Agent
	sh /home/redhat/setup.sh -silent /home/redhat/agent_para.xml
	
#Refresh session after installation 
	sshpass -p "redhat" ssh -o StrictHostKeyChecking=no redhat@$host

#Agent Diagnostic Check
	ag_diag_comm

#Check status of installation
	res=$?
	if [ $res -eq 0 ]; then
	echo "Control-M Agent successfully installed!!!"
	exit $res
	else
	echo "Installation Failed!"
	exit $res
	fi
	
EOF
done

#mail -s "1234" abc.xyz@mmmm.com


