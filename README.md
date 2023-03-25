# Automation_Project
this automation script does the following things in the following order:
1. update all the existing packages
2. install the apache2 server if it is not already installed
3. make sure that the apache2 server is running
4. make sure that after the reboot apache service start itself
5. create a tar file of log files
6. upload that tar file to the s3 bucket.
