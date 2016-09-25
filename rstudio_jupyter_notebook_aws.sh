###############################
## LAUNCHING AN EC2 INSTANCE ##
###############################
# 1.  Log into the AWS Console and click on the option to take you to "EC2" under "Compute".
# 2.  This will bring you to the EC2 Dashboard and will show you the number of "Running Instances",
#     or servers, that you have.  Somewhere on the page should be a large blue button that says "Launch
#     Instance".  Click that button.
# 3.  Step 1 in launching an instance is to choose an AMI.  Select the option for "Community AMIs" and search
#     for the AMI you want.  For RStudio, we'll choose the AMI "RStudio-0.99.447_R-3.2.1_ubuntu-14.04-LTS-64bit" (ami-47a6622c)
#     and for jupyter notebooks we'll use the AMI "anaconda-2.3.0-on-ubuntu-14.04-lts" (ami-bda16fd6).  Click the blue button
#     to "Select".
# 4.  Next, we need to choose an instance size.  Which size you choose will depend on how many CPU cores and how much RAM you
#     want.  An m3.xlarge is a decently beefy instance size with 4 cores and 15 GB of RAM, so we'll work with that.
#     Selet the button next to that instance size and click the gray button for "Next: Configure Instance Details".
# 5.  If you want to use "spot pricing" to choose your own bid price for the instance, check the "Request Spot Instances"
#     box and specify the maximum price that you're willing to pay.  Otherwise, just click the gray button "Next: Specify Storage".
# 6.  If you want, make the disk size bigger. Otherwise, click the gray "Next: Tag Instance" button.
# 7.  Enter a value for the "Name" of your instance so that you can reognize it in the list of running instances.
# 8.  Click "Next: Configure Security Group" to specify firewall rules that allow us to connect to RStudio and
#     the jupyter notebook from our web browsers.
# 9.  Click the gray button to "Add Rule".  We want to add a rule of type "Custom TCP Rule" and protocol "TCP".  For RStudio,
#     enter 80 for the "Port Range".  For jupyter notebooks, enter 8888.  For "Source", select "Anywhere".
# 10. Click the blue "Review and Launch" button and then the blue "Launch" button.
# 11. If you haven't created an ssh security key, do so in the window that pops up.  Otherwise, select your key and click the 
#     blue "Launch Instances" button and then the "View Instances" button to get to the list of EC2 instances.
# 12. Locate the line for your instance and wait until the "Instance State" turns green and says "Running".  Check the box next to
#     your instance and locate the information at the bottom of the screen for "Public DNS".  It should look something like 
#     ec2-54-83-78-89.compute-1.amazonaws.com.

#################################
## TERMINATING AN EC2 INSTANCE ##
#################################
# Remember that you pay for your instance hourly as long as it's running.  
# TO TERMINATE YOUR INSTANCE: From the list of running instances, select the box next to the instance that you want to kill.
# Click the gray "Actions" button, and under "Instance State" select "Terminate."

#############
## RSTUDIO ##
#############
# Follow the instructions above to launch the AMI "RStudio-0.99.447_R-3.2.1_ubuntu-14.04-LTS-64bit" (ami-47a6622c)
# Connect to the created instance in your web browser at the public DNS, for example
# http://ec2-54-237-87-215.compute-1.amazonaws.com.  
# You should see an RStudio login page.  The default username and password are both rstudio.
# Follow the instructions in the file opened up by rstudio to change the password to something else.

######################
## JUPYTER NOTEBOOK ##
######################
# Follow the instructions above to launch the AMI "anaconda-2.3.0-on-ubuntu-14.04-lts" (ami-bda16fd6)
# ssh into the created instance at the public DNS, for example
# ssh -i my_key.pem ubuntu@ec2-54-237-87-215.compute-1.amazonaws.com
# On the commandline, run the following
pip install jupyter
jupyter notebook --generate-config

ipython
# This will open an ipython command line.  Type the following:
In [1]:from IPython.lib import passwd
In [2]:passwd()
# Now enter a password and then copy everything in quotes that gets printed to the screen.  It
# should look something like this:
Out[2]: 'sha1:somecrazyhash'
# Exit ipython
In [3]: quit()

# Edit the configuration file in the text editor nano:
nano /home/ubuntu/.jupyter/jupyter_notebook_config.py
# uncomment the line starting with c.NotebookApp.ip and change it to c.NotebookApp.ip = '*'
# uncomment the line c.NotebookApp.port = 8888
# uncomment the line c.NotebookApp.password and change it to c.NotebookApp.password = = u'sha1:somecrazyhash'
# with the value from above
# Hit ctrl-x to exit, and then "Y" to save the changes you made to the file.

# Start the jupyter notebook:
jupyter notebook --no-browser --profile=.jupyter/jupyter_notebook_config.py

# Go to your web browser to your public DNS and port 8888, for example
# http://ec2-54-237-87-215.compute-1.amazonaws.com:8888
# Log in with the password that you specified in ipython above.

# You can find more information on setting up the jupyter notebook sever here:
# http://blog.impiyush.me/2015/02/running-ipython-notebook-server-on-aws.html
# In particular, if you're going to put real data on the server you should set up
# an SSL certificate following the instructions there.
