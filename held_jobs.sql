/*##############################################
##Script name: held_jobs.sql	              ##
##Description: Lists out active Control-M jobs##
##	       that have been put on hold     ##	      
##Created & Tested by: Varun Das 	      ##			      
##Date: 19th November 2018                    ##
##############################################*/					

SELECT * FROM CMR_AJF;

SELECT jobname, orderid, status 
FROM CMR_AJF
WHERE holdflag = 'Y';
