#!/bin/sh 
 
# this script is run from a launchd job  
# use -v for verbose output 
# mainly for debugging 
 
# must be run as root  
WHOAMI=`whoami` 
if [ "$WHOAMI" != "root" ]; then 
 echo "The puppet.sh script (part of STOM) must be run as root. You are $WHOAMI" 
 exit 0   
fi 
 
# need to make sure /usr/sbin is in the path, or puppet and facter will not run 
export PATH=$PATH:/usr/sbin 
 
# avoid unsightly errors in the logs 
export TERM_PROGRAM=Apple_Terminal 
export TERM=xterm-color 
 
# this suffix is added to the value to make it look like 
# a FQDN. This allows for auto sign to work on the server 
SUFFIX=huronhs.com 
if [ "$1" = "-v" ]; then echo "SUFFIX set to $SUFFIX "; fi 
 
# this is the server to sent a puppetca clean to 
SERVER=wesreplica.huronhs.com 
if [ "$1" = "-v" ]; then echo "SERVER set to $SERVER "; fi 
 
# see if the MAC_UID is in nvram already 
MAC_UID=`/usr/sbin/nvram MAC_UID 2>/dev/null | awk '{print $2}'` 
if [ -z "$MAC_UID" ]; then 
 # flag that nothing is in nvram yet 
 NVRAM="no" 
 if [ "$1" = "-v" ]; then echo "MAC_UID not found in nvram"; fi 
fi 
 
# get the serial number for this Mac 
if [ -z "$MAC_UID" ]; then 
 MAC_UID=`facter | grep sp_serial_number | awk '{print $3}' | sed 's/[\/\~\!\@\#\$\%\^\&\*\(\)\+\=]/_/g'` 
  
 # test to see if the sreial number is fubar 
 FUBAR=`echo $MAC_UID | grep -i system` 
 if [ -n "$FUBAR" ]; then 
  MAC_UID="" 
 fi 
fi 
 
# if the MAC_UID is still null 
# get the primary MAC address 
if [ -z "$MAC_UID" ]; then 
 if [ "$1" = "-v" ]; then echo "No asset_id found, checking primary MAC address"; fi 
 MAC_UID=`facter | grep 'macaddress =>' | awk '{print $3}'` 
fi 
 
# if all the above fails, get the hostname 
if [ -z "$MAC_UID" ]; then 
 if [ "$1" = "-v" ]; then echo "No primary MAC address found, using hostname for MAC_UID"; fi 
 MAC_UID=`hostname` 
fi  
 
# assuming we have something, write it to nvram  
# getting it from nvram is much faster and is limited to this 
# specific computer 
if [ "$NVRAM" == 'no' ]; then 
 # cert names must be lowercase 
 MAC_UID=`echo $MAC_UID | tr "[:upper:]" "[:lower:]"` 
 MAC_UID=${MAC_UID}.${SUFFIX} 
 /usr/sbin/nvram MAC_UID=${MAC_UID} 
fi 
 
if [ "$1" = "-v" ]; then  
 tempfoo=`basename $0` 
 PUPPET_RESULTS_FILE=`mktemp /tmp/${tempfoo}.XXXXXX` 
 touch $PUPPET_RESULTS_FILE 
 echo "puppetd -o --no-daemonize -v --certname=$MAC_UID --debug --report"  
 puppetd -o --no-daemonize -v --certname=$MAC_UID --debug --report 2>&1 | /usr/bin/tee $PUPPET_RESULTS_FILE 
 #cat $PUPPET_RESULTS_FILE 
 CERT_ERROR_RESULTS_1=`cat $PUPPET_RESULTS_FILE | grep 'Certificate request does not match existing certificate'` 
 CERT_ERROR_RESULTS_2=`cat $PUPPET_RESULTS_FILE | grep 'Retrieved certificate does not match private key'` 
# rm $PUPPET_RESULTS_FILE 
else 
  
 RESULTS=`puppetd -o --no-daemonize -v --certname=$MAC_UID --report 2>&1` 
 CERT_ERROR_RESULTS_1=`echo $RESULTS | grep 'Certificate request does not match existing certificate'` 
 CERT_ERROR_RESULTS_2=`echo $RESULTS | grep 'Retrieved certificate does not match private key'` 
fi 
 
# this cert error says the key on the client has changed, so need to clean the cert on the server 
if [ -n "$CERT_ERROR_RESULTS_1" ]; then 
	CMD="http://${SERVER}/cgi-bin/pclean.rb?certname=${MAC_UID}" 
 	if [ "$1" = "-v" ]; then echo "Sleeping for 10 seconds, then cleaning cert on server"; fi 
 	sleep 10; 
 	if [ "$1" = "-v" ]; then echo "curl $CMD"; fi 
 	curl "$CMD" 
fi 
 
# this is also a cleaning issue, but the server needs to be cleaned and the client SSL cert needs to be cleaned 
if [ -n "$CERT_ERROR_RESULTS_2" ]; then 
 # clean the cert on the server 
 CMD="http://${SERVER}/cgi-bin/pclean.rb?certname=${MAC_UID}" 
 if [ "$1" = "-v" ]; then echo "Sleeping for 10 seconds, then cleaning cert on server"; fi 
 sleep 10; 
 if [ "$1" = "-v" ]; then echo "curl $CMD"; fi 
 curl "$CMD" 
 # clear the local cached cert 
 if [ "$1" = "-v" ]; then echo "Cleaning local cached cert"; fi 
 rm -rf /etc/puppet/ssl/certs/${MAC_UID}.pem 
 if [ "$1" = "-v" ]; then echo "Run puppet again and it should work now"; 
fi 
  
 # all should be good on the next puppet run 
fi
