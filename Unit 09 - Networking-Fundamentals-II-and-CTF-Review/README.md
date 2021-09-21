### Week 9 Homework Submission File: Networking-Fundamentals-II-and-CTF-Review

**Mission 1**

**Determined the mail servers of `starwars.com`**

> run = `nslookup -type=MX starwars.com`

````
    starwars.com	mail exchanger = 10 aspmx3.googlemail.com.
    starwars.com	mail exchanger = 1 aspmx.l.google.com.
    starwars.com	mail exchanger = 5 alt1.aspx.l.google.com.
    starwars.com	mail exchanger = 5 alt2.aspmx.l.google.com.
    starwars.com	mail exchanger = 10 aspmx2.googlemail.com.
````

- The Resistance (starwars.com) isn't receiving emails because the new mail servers are not set up. 




> Corrected mail server record should be.

````
    starwars.com    MX preference = 1, mail exchanger = asltx.l.google.com
    starwars.com    MX preference = 5, mail exchanger = asltx.2.google.com
````





**Mission 2**

**SPF record for `theforce.net`**

- run = `nslookup -type=txt theforce.net` to reveal the SPF record
````
v=spf1 a mx mx:smtp.secureserver.net include:aspmx.googlemail.com ip4:104.156.250.80 ip4:45.63.15.159 ip4:45.63.4.215
````


**Why are the Force's emails going into the spam folder?**
- Because the changed IP `45.23.176.21` is not included in the SPF record therefore its a non trusted source and will be send straight to the spam folder.



> **The new mail server IP address needs to be added to the SPF record**

````
v=spf1 a mx mx:smtp.secureserver.net include:aspmx.googlemail.com ip4:45.23.176.21 ip4:104.156.250.80 ip4:45.63.15.159 ip4:45.63.4.215
````





**Mission 3**

**CNAME lookup**

> run = `nslookup -type=all www.theforce.net`

````
    www.theforce.net	canonical name = theforce.net.
    Name:	theforce.net
    Address: 104.156.250.80
````

**You could also run**

> run = `nslookup -type=CNAME www.theforce.net`

````
    www.theforce.net	canonical name = theforce.net.
````



**Why isn't the sub page of `resistance.theforce.net`  redirected to `theforce.net`?**

- Because there is no CNAME record for it to do so.



> **To fix this problem add a CNAME record for it.**

````
    resistance.theforce.net     canonical name = theforce.net
````





**Mission 4**

**DNS records for `princessleia.site`**

> run = `nslookup -type=NS princessleia.site`

````
    princessleia.site	nameserver = ns25.domaincontrol.com
    princessleia.site	nameserver = ns26.domaincontrol.com
````



> **Adding a secondary server would fix the issue.**

````
    princessleia.site	nameserver = ns25.domaincontrol.com
    princessleia.site	nameserver = ns26.domaincontrol.com
    princessleia.site   nameserver = ns2.galaxybackup.com
````





**Mission 5**

**Shortest path from `Batuu` to `Jedha`.**

> `Batuu > D > C > E > F > J > I > L  > Q > T > V > Jedha`





**Mission 6**

**In order to decrypt, I need to use a wordlist (-w) such as `rockyou.txt`.**

In Terminal on the Linux machine run:

> `sudo find / -iname rockyou.txt`

> `cd /usr/share/wordlists && ls -la`

````
    drwxr-xr-x   2 root root      4096 May 15 06:33 .
    drwxr-xr-x 260 root root     12288 Aug  4 20:27 ..
    -rwxr-xr-x   1 root root         0 May 15 06:33 .gitkeep
    - rwxr-xr-x   1 root root 139921497 May 15 06:33 rockyou.txt
````

I changed the directory of the `rockyou.txt` by copying it to the Desktop:

> run = `cp ./rockyou.txt ~/Desktop/`



Aircrack-ng command to get the wireless key:

> run = `aircrack-ng -w rockyou.txt Darkside.pcap`

````
    Opening Darkside.pcap
    Read 586 packets.

    #  BSSID              ESSID                     Encryption

    1  00:0B:86:C2:A4:85  linksys                   WPA (1 handshake)

    Choosing first network as target.

    Opening Darkside.pcap
    Reading packets, please wait...

    Aircrack-ng 1.2 rc4

    [00:00:00] 2280/7120714 keys tested (2969.74 k/s) 

    Time left: 39 minutes, 57 seconds                          0.03%

                          KEY FOUND! [ dictionary ]


    Master Key:     5D F9 20 B5 48 1E D7 05 38 DD 5F D0 24 23 D7 E2 
                    52 22 05 FE EE BB 97 4C AD 08 A5 2B 56 13 ED E2 

    Transient Key:  1B 7B 26 96 03 F0 6C 6C D4 03 AA F6 AC E2 81 FC 
                    55 15 9A AF BB 3B 5A A8 69 05 13 73 5C 1C EC E0 
                    A2 15 4A E0 99 6F A9 5B 21 1D A1 8E 85 FD 96 49 
                    5F B4 97 85 67 33 87 B9 DA 97 97 AA C7 82 8F 52 

    EAPOL HMAC:     6D 45 F3 53 8E AD 8E CA 55 98 C2 60 EE FE 6F 51
````

**Found the KEY and the SSID**

- SSID  =`linksys`
- KEY   = `dictionary`

**Used the Dark Side's key to decrypt the wireless traffic in Wireshark.**

- Toggle `Wireless Toolbar` if not already on.
    - Toolbar `View` and check `Wireless Toolbar`

    
    
- Decrypt the wireless traffic in Wireshark.
  
    - Toolbar   `Edit` > `Preferences` > `Protocols` > `IEEE 802.11` > `Decription keys` > `Edit...` > `+`
    - Select    `wpa-pwd`
    - Apply     `dictionary:linksys`

> **Dark Side information:**

````
    Sender MAC address: Cisco-Li_e3:e4:01 (00:0f:66:e3:e4:01)
    Sender IP address: 172.16.0.1 (172.16.0.1)
    Target MAC address: IntelCor_55:98:ef (00:13:ce:55:98:ef)
    Target IP address: 172.16.0.101 (172.16.0.101)
````





**Mission 7**

**Command to view the TXT record**

> run = `nslookup -type=TXT princessleia.site`

````
    princessleia.site	text = "Run the following in a command line: telnet towel.blinkenlights.nl or as a backup access in a browser: www.asciimation.co.nz"
````

- Following the link a video is being played.





