# Automation_Project
this is for my upgrad assignment.
this automation script does the following things in the following order:
1. update all the existing packages
2. install the apache2 server if it is not already installed
3. make sure that the apache2 server is running
4. make sure that after the reboot apache service start itself
5. create a tar file of log files
6. upload that tar file to the s3 bucket.
7. every time the tar file is uploaded to the s3, we are keeping bookloging for it in the inventory.html
8. to further automate the script we write a cron job so that it ca execute by itself.
