#!/bin/sh	
########################################################################
##Script name: auto_ctm_agent_install.sh			      ## 
##Description: Performs silent install of Control-M Agent and services##
##	       on servers listed in a 'separte' file 		      ##
##Created & Tested by: Varun Das 				      ##
##Date: 6th March 2019						      ##
########################################################################

set +x;
 
#SSH connect to selected hosts
for host in $(cat <file_name>); do #maintain a .txt file with list of servers (one-per-line) where installation is required

	sshpass -p "<password>" ssh -o StrictHostKeyChecking=no <username>@$host << EOF	

#Pre-checks		 
	echo "Connected to host: $host"
	echo "DNS name: `hostname`"	
	echo "Today's date: `date`"
	echo "Currrent user: `whoami`"

#Switch to installation package directory
	cd <package_path> #usually it is /tmp
	
#Unzip and extract installation package
	gunzip -r <desired_file_path>/DRKAI.8.0.00_Linux-x86_64.z	#for packages downloaded from EPD site
	tar -xvf <desired_file_path>/DRKAI.8.0.00_Linux-x86_64

#Change file permissions
	chmod 700 -R FORMS setup.sh Setup_files #set permission for further operation on files as appropriate

#Prepare OS for 32/64-bit installation
	export INSTALL_AGENT_LINUX_X86_64=Y

#Installation of Control-M Agent
	sh <desired_file_path>/setup.sh -silent <agent_parameters_file_name> #Remember to genrate a .xml file prior to this process with generic installation parameters (sample provided) 
	
#	    <target.product>Control-M/Agent 8.0.00</target.product>
 #   <agent.parameters>
  #      <entry key="field.Authorized.Controlm.Server.Host" value="ctmtest"/>
   #     <entry key="ctm_agent.Tracker.Event.Port" value="****"/>       #enter only 4-digit numeric values
    #    <entry key="ctm_agent.Tracker.Event.Port" value="****"/>       <!--enter only 4-digit numeric values-->
     #   <entry key="field.Agent.To.Server.Port.Number" value="****"/>
      #  <entry key="ctm_agent.Tcp_ip.Timeout" value="60"/>
       # <entry key="field.Server.To.Agent.Port.Number" value="****"/>
	
#Refresh session after installation 
	sshpass -p "<password>" ssh -o StrictHostKeyChecking=no <username>@$host

#Agent Diagnostic Check
	ag_diag_comm #Report MUST be successful

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


