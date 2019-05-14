## Pre-requisites

To get started, you need to download:

-	Teradata Express 16.20 VM Image.
-	VMWare Workstation 15 Player.
-	Teradata tools and utilities.
- JDK 8 and other dependencies (see the download page for TD Express).
- You can download these from: [Teradata Downloads page.](http://downloads.teradata.com/download/database/teradata-express-for-vmware-player)
- An account is required, you can create one for free.

---
## Launch your VM
	
- In VMWare Player's main window, right click on the VM name and select "Virtual Machine Settings".
- In the settings window, click on "Network Adapter" and among the options on the right, select "Host-only: a private network shared with the host".
- Click ok and boot your virtual machine.
- Login credentials are root/root

---
## Connect to your DB

- Open a terminal and type `ifconfig`. You should see an `inet addr` value as below.

![](img/vmware.PNG)

--- 
## Test connection

- On your `PowerShell` or `UNIX` console, ping the IP address of your DB with the command `ping 192.168.47.129`
![](img/ps.png)

---
## Connect with SQLA
- Now open SQL Assistant, and create a new connection using the IP address of your DB. 
- Default credentials are dbc/dbc.
- Run a simple query.

![](img/sqla.png)
