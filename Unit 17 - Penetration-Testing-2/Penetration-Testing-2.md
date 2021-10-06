<p align="Center"><span style="font-family:calibri light;">GOODSECURITY PENETRATION TEST REPORT 
</span>


<p align="Center"><span style="font-family:calibri light; font-size: 30pt;">Richard.Brantsch@GoodSecurity.com</span>

<p align="Center"><span style="font-family:calibri light; font-size: 30pt;">27 September 2021
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
</span>

<p align="Center"><span style="font-family:calibri light; font-size: 25pt;">High-Level Summary</span>

<p align="Center"><span style="font-family:calibri light; font-size: 11pt;">GoodSecurity was tasked with performing an internal penetration test on GoodCorp’s CEO, Hans Gruber. An internal penetration test is a dedicated attack against internally connected systems. The goal of this test is to perform attacks similar to those of a hacker and attempt to infiltrate Hans’ computer to determine if it is at risk. GoodSecurity’s overall objective was to exploit any vulnerable software, find a secret recipe file on Hans’ computer, and report the findings back to GoodCorp.
The internal penetration test found several alarming vulnerabilities on Hans’ computer: When performing the attacks, GoodSecurity was able to gain access to his machine and find the secret recipe file by exploiting two programs with major vulnerabilities. The details of the attack are below.</span>



<p align="Center"><span style="font-family:calibri light; font-size: 25pt;">Findings 1.0</span>

<p align="Center"><span style="font-family:calibri light; font-size: 11pt;">
<b>Machine IP:</b> <br/> 
IPv4: 192.168.0.20 <br/>
IPv6: fe80::19ba:64e7:838c:b1b6 <br/>
<br/> 
<b>Hostname:</b> <br/> 
MSEDGEWIN10 <br/> <br/>
<b>Vulnerability Exploited:</b> <br/>
Icecast Header Overwrite <br/>
MSF: EXPLOIT/WINDOWS/HTTP/ICECAST_HEADER <br/><br/>
<b>Vulnerability Explanation:</b><br/>
The version 2.0.1 of the Icecast streaming media server allows for a buffer overflow exploit. 
The Icecast server accepts a maximum of 32 headers in the clients HTTP Request, a request with more than 31 headers cause the overwriting of the return address of the vulnerable function with a pointer to the beginning of the 32th header.
Utilizing this exploit makes it possible to execute remote code simply using the normal HTTP request plus 31 headers followed by a shellcode that will be executed.</span>
<br/>
<p align="Center"><span style="font-family:calibri light; font-size: 11pt;"><b>Link to Code</b></span>
<p align="Center"><span style="font-family:calibri light; font-size: 11pt;"><a href="https://vulners.com/metasploit/MSF:EXPLOIT/WINDOWS/HTTP/ICECAST_HEADER">Icecast Header Overwrite</a> </span>
<br/>
<p align="Center"><span style="font-family:calibri light; font-size: 11pt;"><b>Severity:</b>
<br/>
CVSS 7.5 High
<br/><br/>
<p align="center"; style="font-size: 25pt"><b>Proof of Concept:</b></p>
</span>


















