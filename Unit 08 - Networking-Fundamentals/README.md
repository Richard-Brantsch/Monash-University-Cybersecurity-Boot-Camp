### Week 8 Homework Submission File: Networking-Fundamentals

**"It’s the End of the Assessment as We Know It, and I Feel Fine"**

**Phase 1**

Hollywood office IP`s:

`15.199.95.91/28`   `15.199.94.91/28`   `11.199.158.91/28`  `167.172.144.11/32`   `11.199.141.91/28`

**Used the following commands to run `fping`**

- `fping -g 15.199.95.91/28 `
- `fping -g 15.199.94.91/28 `
- `fping -g 11.199.158.91/28 `
- `fping -g 167.172.144.11/32 `
- `fping -g 11.199.141.91/28`

**Summary**

- The only server IP that showed as alive was `167.172.144.11`
- The OSI Layer Ping runs on is the Network Layer (3)

**Mitigation**
- Restrict ICMP Echo requests to all of the servers, including: `167.172.144.11`, if RockStar Corporation doesn't want the ability to ping their server.





**Phase 2**

To check for open ports I did run a SYN SCAN against the server IP which is accepting connections `167.172.144.11`.

**The following command was used to run the SYN SCAN.**
- `sudo nmap -sS 167.172.144.11`

**Result of the command**

- Starting Nmap 7.60 ( https://nmap.org ) at 2021-08-02 13:45 AEST
  Nmap scan report for 167.172.144.11
  Host is up (0.00048s latency).
  Not shown: 674 filtered ports, 324 closed ports
  PORT   STATE SERVICE
  21/tcp open  ftp
  22/tcp open  ssh

  Nmap done: 1 IP address (1 host up) scanned in 2469.94 seconds

**Summary**

- Port 22 is open for SSH connection
- Port 21 is open for FTP (File Transfer Protocol)
- The OSI Layer SYN SCAN runs on is the Transport Layer (4)

**Mitigation**
- RockStar Corporation should filter out SSH traffic to prevent unauthorized access to the server.
- Using stronger passwords would help against an attack.
- Disable logging in through SSH as root to prevent brute force attacks. 
- Disable Standard FTP (if active) and switch to a more secure alternative like FTPS, SFTP, or both.





**Phase 3**

Since my findings showed me that **Port 22** was open for **SSH**, I logged into the RockStar Corporation server as default user with the credentials provided by RockStar Corporation:
- **Username: jimi**
- **Password: hendrix**

**I used the following command to get access to the server:**
- `ssh jimi@167.172.144.11`

Since RockStar Corporation reported that they are unable to access rollingstone.com or if they manage to access it, it’s being redirected to an unusual website I checked the hosts file (The hosts file is located in **/etc/host**). 							      

**To inspect it I used following command:**
- `cat /etc/hosts`

**The command returned the following**
    
    # Your system has configured 'manage_etc_hosts' as True.
    # As a result, if you wish for changes to this file to persist
    # then you will need to either
    # a.) make changes to the master file in /etc/cloud/templates/hosts.tmpl
    # b.) change or remove the value of 'manage_etc_hosts' in
    #     /etc/cloud/cloud.cfg or cloud-config from user-data
    #
    127.0.1.1 GTscavengerHunt.localdomain GTscavengerHunt
    127.0.0.1 localhost
    98.137.246.8 rollingstone.com
    
    oooooooollowing lines are desirable for IPv6 capable hosts
    ::1 ip6-localhost ip6-loopback
    fe00::0 ip6-localnet
    ff00::0 ip6-mcastprefix
    ff02::1 ip6-allnodes
    ff02::2 ip6-allrouters
    ff02::3 ip6-allhosts


- The hosts file revealed the following record: `98.137.246.8 rollingstone.com`, this explains why the rollingstone.com is being redirected to a different domain.

**To determine the real domain from the IP address I found I did run a nslookup (Name Server Lookup) with the following command:**
- `nslookup 98.137.246.8`

**Result of command**
- `8.246.137.98.in-addr.arpa	name = unknown.yahoo.com.`

**Summary**
- The hosts file has been modified, rollingstone.com is being redirected to unknown.yahoo.com.
- The OSI Layer DNS runs on is the Application Layer (7).

**Mitigation**
- Don`t use default user and passwords (Default user and passwords should never be used)
- Change all default user and passwords on all servers.
- The hosts file needs to be monitored more closely and write access should be given to limited staff only.





**Phase 4**

Within the RockStar server that I SSH'd into, in the `/etc` directory I discovered a file called **packetcaptureinfo.txt**.

I examined the file, and it led me to the Captured Packets location:
-  https://drive.google.com/file/d/1ic-CFFGrbruloYrWaw3PvT71elTkh3eF/view?usp=sharing
- This link redirected me to a google drive download which contained the pcap packets: [pcapfile](secretlogs.pcapng) as a backup
- These are packets that were captured from the activity in the Hollywood Office.

Next I used Wireshark to analyze file called `secretlogs.pcapng` which i downloaded from the link above.

**HTTP finding**
- I applied the HTTP filter first and then I looked for the `POST` request 
- Under "HTML Form URL Encoded: application/x-www-form-urlencoded" I found following message from the hacker.
    ````
    "Hi Got The Blues Corp!  This is a hacker that works at Rock Star Corp.  Rock Star has left port 22, SSH open if you want to hack in.  For 1 Milliion Dollars I will provide you the user and password!"
   ````

- The OSI Layer DNS runs on is the Application Layer (7).   

**ARP finding**
- I applied the ARP filter and examined the results.
- In packet 4 under info was an ARP response stating `192.168.47.200 is at 00:0c:29:0f:71:a3`
- In packet 5 under info the ARP response was different, the same IP `192.168.47.200` appears to be at a different MAC address `00:0c:29:0f:71:a3` (Indication of ARP spoofing)
- In addition to that Wireshark indicates that this a duplicate ARP response.
- I assume the hackers MAC address is `00:0c:29:1d:b3:b1`and he created a spoof record to direct the traffic for `192.168.47.200` to his device.

- The OSI Layer ARP runs on is the Data-Link Layer (2)

**Mitigation**
- Creating a static ARP entry can help RockStar Corporation reduce the risk of spoofing.
- Implement Ethernet switches, features like Dynamic ARP Inspection (DAI) evaluate the validity of each ARP message and drop packets that appear suspicious or malicious.
- An internal investigation would be recommended, best bet would be to start at the owner of the  MAC Address of `00:0c:29:1d:b3:b1` which was involved in the ARP Spoofing. I would also recommend to investigate the owner of the IP (`10.0.2.15`) responsible for the HTTP Post request.



















