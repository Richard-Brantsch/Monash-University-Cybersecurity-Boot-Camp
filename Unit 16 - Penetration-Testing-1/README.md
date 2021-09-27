## Week 16 Homework Submission File: Penetration Testing 1



#### Step 1: Google Dorking


- Using Google, can you identify who the Chief Executive Officer of Altoro Mutual is:
  - **Karl Fitzgerald** is the Chairman & Chief Executive Officer of Altoro Mutual
    https://demo.testfire.net/index.jsp?content=inside_executives.htm
  
- How can this information be helpful to an attacker:

  - Having the information of Executives & Management the Attacker can launch Phishing attacks or even attempt Social Engineering attacks.

    


#### Step 2: DNS and Domain Discovery

Enter the IP address for `demo.testfire.net` into Domain Dossier and answer the following questions based on the results:

  1. Where is the company located: `Sunnyvale CA (California) 94085 US (USA)` [Location](Images/location.png)
  2. What is the NetRange IP address: `65.61.137.64 - 65.61.137.127` [NetRange](Images/netrange.png)
  3. What is the company they use to store their infrastructure: `Rackspace Backbone Engineering` [Store](Images/infra.png)
  4. What is the IP address of the DNS server: `65.61.137.117` [DNS](Images/dns.png)



#### Step 3: Shodan

- What open ports and running services did Shodan find: 
  - [Port 80](Images/80.png)
  - [Port 443](Images/443.png)
  - [Port 8080](Images/8080.png)



#### Step 4: Recon-ng

- Install the Recon module `xssed`. 
  - Run `> marketplace search xssed` [Search](Images/search.png)
  - Run `> marketplace install recon/domains-vulnerabilities/xssed` [Install](Images/install.png)
- Set the source to `demo.testfire.net`. 
  - Run `> modules load recon/domains-vulnerabilities/xssed` [Load_Module](Images/load.png)
  - Run `> options set SOURCE demo.testfire.net` [Set_Source](Images/source.png)
- Run the module. 
  - Run `> run` [Run_Module](Images/run.png)

Is Altoro Mutual vulnerable to XSS: 
  - Yes it is. [XSS_Firefox](Images/xssff.png)  [ReconNG](Images/recon.png)



#### Step 5: Zenmap

Your client has asked that you help identify any vulnerabilities with their file-sharing server. Using the Metasploitable machine to act as your client's server, complete the following:

- Command for Zenmap to run a service scan against the Metasploitable machine: 

  - Run: `nmap -sV 192.168.0.10` This is a [Quick_Scan_NMAP](Images/nmap.png)
  - Run: `nmap -sV -p- 192.168.0.10` This takes longer but scans **All 65535 Ports**. [All_Ports](Images/65.png)

    

- Bonus command to output results into a new text file named `zenmapscan.txt`:
  - Run: `nmap -sV -oN zenmapscan.txt 192.168.0.10`
  
  - Run: `nmap -sV -p- -oN zenmapscan.txt 192.168.0.10`
  
    
  
- Zenmap vulnerability script command: 

  - Run : `nmap -T4 -F --script ftp-proftpd-backdoor,smb-enum-shares 192.168.0.10`

  - `ftp-vsftpd-backdoor`: This script attempts to exploit the  backdoor using the innocuous id command by default, but that can be  changed with the exploit.cmd or ftp-vsftpd-backdoor.cmd

  - `smb-enum-shares`: Host script results: | smb-enum-shares: |  account_used: WORKGROUP\Administrator | ADMIN$ | Type:  STYPE_DISKTREE_HIDDEN | Comment: Remote Admin

    

- Once you have identified this vulnerability, answer the following questions for your client:
  1. What is the vulnerability: [Scan_Pt.1](Images/scan1.png)	 [Scan_Pt.2](Images/scan2.png)	 [Scan_Pt.3](Images/scan3.png)

     - **VSFTPD v2.3.4 Backdoor Command Execution** on Port 21, This module exploits a malicious backdoor that was added to the VSFTPD download archive.
     - **Windows Server Message Block (SMB)** (IPC Service - Samba smbd 3.X - 4.X (workgroup: WORKGROUP)) on port 139 and port 445

     

  2. Why is it dangerous:

     - The concept of the attack on VSFTPD 2.3. 4 is to trigger the malicious vsf_sysutil_extra(); function by sending a sequence of specific bytes on port 21, which, on  successful execution, results in opening the backdoor on port 6200 of  the system.
     - This module exploits a command execution vulnerability in Samba versions 3.0.20 through 
       3.0.25rc3 [7] when using the non-default “username map script” configuration option. The service runs on port 139. By specifying a username containing shell meta characters, 
       attackers can execute arbitrary commands and get root shell. No authentication is needed to 
       exploit this vulnerability since this option is used to map usernames prior to authentication. 
       The SMB gets access through the organization's networks, the SMB protocols used by  PC's for file and printer sharing, along with the remote access  services. SMB vulnerabilities allow their payloads to spread laterally through connected systems. 

     

  3. What mitigation strategies can you recommendations for the client to protect their server:

     - Since version 2.3.4 of the vsftpd contained backdoor, the best possible way 
       to mitigate this risk is to update to the latest version of the vsftpd . Perhaps keeping port 6200 closed or if not desired closely monitoring port 6200 until the exploit is fixed will mitigate the risk of an successful attack. 

       *The vsFPTD 2.3.4 patch was released on July 3, 2011 with the patch constantly monitored and updated. The vsFTPD v2.3.4 backdoor reported on 2011-07-04 (CVE-2011-2523).*

       

     - The recommendation for mitigating from this exploit is that anonymous login should not be 
       enabled and the samba service version should not be disclosed to the extent possible. 
       Further the patched version of samba should be used and regular security updates must be 
       installed timely. 

       *The SMB (CVE-2017-0145) patch was released by Microsoft MS17-010 , and the SAMBA (CVE-2017-0145) patches were released by Red Had for Linux RHSA-2017:1390 (5, 6 & 7)*

---


