SELECT * FROM CMR_AJF;

SELECT jobname, orderid, status 
FROM CMR_AJF
WHERE holdflag = 'Y';
