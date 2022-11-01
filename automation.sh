
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

inventory=/var/www/html/inventory.html
log="httpd-logs"
timestamp=$(stat --printf=%y /tmp/$filename | cut -d.  -f1)
file=${filename##*.}
size=$(ls -lh /tmp/${filename} | cut -d " " -f5)

echo "File-Name : $filename"
echo "Log_Type : $log"
echo "Time_Of_Creation : $timestamp"
echo "Type_Of_File : $file"
echo "File_Size : $size"


if  test -f "$inventory"
then
	echo "<br>${log}&nbsp;&nbsp;&nbsp;&nbsp;${timestamp}&nbsp;&nbsp;&nbsp;&nbsp;${file}&nbsp;&nbsp;&nbsp;&nbsp;${size}">>"${inventory}"
	echo "Inventory file updated"
else
        echo "Making '$inventory'"
        `touch ${inventory}`
        echo "<b>Log Type&nbsp;&nbsp;&nbsp;&nbsp;Date Created&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Type&nbsp;&nbsp;&nbsp;Size</b>">>"${inventory}"
        echo "<br>${log}&nbsp;&nbsp;&nbsp;&nbsp;${timestamp}&nbsp;&nbsp;&nbsp;&nbsp;${file}&nbsp;&nbsp;&nbsp;&nbsp;${size}">>"${inventory}"
        echo "UPDATED '$inventory' "
fi




cron_file="/etc/cron.d/automation"
if [ ! -f "$cron_file" ]
then
touch "$cron_file"
echo "00 00 * * * root /root/Automation_Project/automation.sh" > "$cron_file"
fi
