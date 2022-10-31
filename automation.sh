s3_bucket="upgrad-ashish"
timestamp=$(date '+%d%m%Y-%H%M%S') 
myname="ashish"

apt update -y

PKG_OK=$(dpkg-query -W apache2)
echo Checking for apache2: $PKG_OK
if [ "" = "$PKG_OK" ]; then
  echo "No apache2. installing apache2."
  sudo apt-get --yes install apache2 
fi

systemctl restart apache2

systemctl service enable



tar -cvf ../../tmp/${myname}-httpd-logs-${timestamp}.tar /../../var/log/apache2

aws s3 \
cp /tmp/${myname}-httpd-logs-${timestamp}.tar \
s3://${s3_bucket}/${myname}-httpd-logs-${timestamp}.tar 
