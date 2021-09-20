### Week 11 Homework Submission File: Network Security Homework 

### Part 1: Review Questions 

#### Security Control Types

The concept of defense in depth can be broken down into three different security control types. Identify the security control type of each set  of defense tactics.

1. Walls, bollards, fences, guard dogs, cameras, and lighting are what type of security control?

    > Answer: <span style="color:blue">**Physical Security Control.**</span>

2. Security awareness programs, BYOD policies, and ethical hiring practices are what type of security control?

    > Answer:<span style="color:blue"> **Administrative Security Controls.**</span>

3. Encryption, biometric fingerprint readers, firewalls, endpoint security, and intrusion detection systems are what type of security control?

    > Answer:<span style="color:blue"> **Technical Security Controls.**</span>

#### Intrusion Detection and Attack indicators

1. What's the difference between an IDS and an IPS?

    > Answer: <span style="color:blue"> **IDS are passive. They don't respond to attacks, they only log and document information. Therefore IDS needs an administrator to examine the (flagged) attacks. An IPS does everything that an IDS can do, but can also respond to attacks. IPS can (automatically) react to packets by blocking malicious traffic, preventing it from being delivered to a host on the network.**</span>

2. What's the difference between an Indicator of Attack and an Indicator of Compromise?

   > Answer:<span style="color:blue"> **Indicator of Attack (IOA), Indicators of attack indicate attacks happening in real time (Proactive). Indicator of Compromise (IOC), Indicators of compromise indicate previous malicious activity. It Indicates that an attack has occurred, resulting in a breach.**</span>

#### The Cyber Kill Chain

Name each of the seven stages for the Cyber Kill chain and provide a brief example of each.

1. Stage 1:<span style="color:blue"> **Reconnaissance: which can be either passive or active! Passive: A hacker searches for information without interacting with the target. The victim has no way of knowing or recording the attacker’s activity. Active: A hacker gains unauthorized access to the network and engages with the system directly to gather information.**</span>

2. Stage 2:<span style="color:blue"> **Weaponization: The attacker found a weak point in the system and knows how to create an entry point he then creates a remote access malware, such as a virus or worm, tailored to one or more vulnerabilities.**</span>

3. Stage 3:<span style="color:blue"> **Delivery: The hacker transmits the malware to target (e.g., via e-mail attachments, Direct hacking through an open port or other external access point, websites or USB drives)** </span>

4. Stage 4:<span style="color:blue"> **Exploitation: Malware weapon's program code triggers, which takes action on target network to exploit vulnerability.**</span>

5. Stage 5:<span style="color:blue">**Installation: Once the malware installs the hacker has an access point (e.g., "backdoor"). Now he can install the necessary tools, create scripts, modify security certificates and look for more vulnerabilities before starting the main attack. This is also refereed as Lateral Movement , the goal is to gain higher permissions and reach more data trough laterally movement to other systems and accounts on the network**</span>

6. Stage 6:<span style="color:blue"> **Command and Control (C2): C2 can be gained via a beacon over an external network path. Beacons are usually HTTP or HTTPS-based and appear as ordinary traffic due to falsified HTTP headers.**</span>

7. Stage 7:<span style="color:blue"> **Actions on Objective: Attackers takes action (C2 control) to achieve their goals, such as data exfiltration, data destruction, or encryption for ransom.**</span>


#### Snort Rule Analysis

Use the Snort rule to answer the following questions:

Snort Rule #1

```bash
alert tcp $EXTERNAL_NET any -> $HOME_NET 5800:5820 (msg:"ET SCAN Potential VNC Scan 5800-5820"; flags:S,12; threshold: type both, track by_src, count 5, seconds 60; reference:url,doc.emergingthreats.net/2002910; classtype:attempted-recon; sid:2002910; rev:5; metadata:created_at 2010_07_30, updated_at 2010_07_30;)
```

1. Break down the Sort Rule header and explain what is happening.

   > Answer:<span style="color:blue"> **Triggers an alert for any tcp traffic icoming from anywhere outside the LAN on any port, to port 5800 trough 5820 on the LAN**</span>

2. What stage of the Cyber Kill Chain does this alert violate?

   > Answer:<span style="color:blue"> **Reconnaissance**</span>

3. What kind of attack is indicated?

   > Answer:<span style="color:blue"> **Emerging Threat for Network SCAN Potential VNC Scan of port 5800-5820**</span>

Snort Rule #2

```bash
alert tcp $EXTERNAL_NET $HTTP_PORTS -> $HOME_NET any (msg:"ET POLICY PE EXE or DLL Windows file download HTTP"; flow:established,to_client; flowbits:isnotset,ET.http.binary; flowbits:isnotset,ET.INFO.WindowsUpdate; file_data; content:"MZ"; within:2; byte_jump:4,58,relative,little; content:"PE|00 00|"; distance:-64; within:4; flowbits:set,ET.http.binary; metadata: former_category POLICY; reference:url,doc.emergingthreats.net/bin/view/Main/2018959; classtype:policy-violation; sid:2018959; rev:4; metadata:created_at 2014_08_19, updated_at 2017_02_01;)
```

1. Break down the Sort Rule header and explain what is happening.

   > Answer:<span style="color:blue"> **Triggers an alert for tcp traffic incoming from anywhere outside the LAN on port 80 to any port on the LAN** </span>

2. What layer of the Defense in Depth model does this alert violate?

   > Answer:<span style="color:blue"> **Policies, Procedures, and Awareness**</span>

3. What kind of attack is indicated?

   > Answer:<span style="color:blue"> **Emerging Threat for Policy Violation "EXE or DLL Windows file download"**</span>

Snort Rule #3

- Your turn! Write a Snort rule that alerts when traffic is detected inbound on port 4444 to the local network on any port. Be sure to include the `msg` in the Rule Option.

    > Answer:<span style="color:blue"> **alert tcp $EXTERNAL_NET 4444 -> $HOME_NET any (msg: "ET Possible Trojan or CrackDown)**</span>

### Part 2: "Drop Zone" Lab

#### Log into the Azure `firewalld` machine

Log in using the following credentials:

- Username: `sysadmin`
- Password: `cybersecurity`

#### Uninstall `ufw`

Before getting started, you should verify that you do not have any instances of `ufw` running. This will avoid conflicts with your `firewalld` service. This also ensures that `firewalld` will be your default firewall.

- Run the command that removes any running instance of `ufw`.

    ```bash
    $ sudo ufw disable
    $ sudo apt -y remove ufw (readme.md said also uninstall ufw)
    ```

#### Enable and start `firewalld`

By default, these service should be running. If not, then run the following commands:

- Run the commands that enable and start `firewalld` upon boots and reboots.

    ```bash
    $ sudo systemctl enable firewalld
    $ sudo systemctl start firewalld
    ```

  Note: This will ensure that `firewalld` remains active after each reboot.

#### Confirm that the service is running.

- Run the command that checks whether or not the `firewalld` service is up and running.

    ```bash
    $ sudo firewall-cmd --state
    ```


#### List all firewall rules currently configured.

Next, lists all currently configured firewall rules. This will give you a good idea of what's currently configured and save you time in the long run by not doing double work.

- Run the command that lists all currently configured firewall rules:

    ```bash
    $ sudo firewall-cmd --list-all
    ```

- Take note of what Zones and settings are configured. You many need to remove unneeded services and settings.

#### List all supported service types that can be enabled.

- Run the command that lists all currently supported services to see if the service you need is available

    ```bash
    $ sudo firewalld-cmd --get-services
    ```

- We can see that the `Home` and `Drop` Zones are created by default.


#### Zone Views

- Run the command that lists all currently configured zones.

    ```bash
    $ sudo firewall-cmd --list-all-zones
    ```

- We can see that the `Public` and `Drop` Zones are created by default. Therefore, we will need to create Zones for `Web`, `Sales`, and `Mail`.

#### Create Zones for `Web`, `Sales` and `Mail`.

- Run the commands that creates Web, Sales and Mail zones.

    ```bash
    $ sudo firewall-cmd --permanent --new-zone=web
    $ sudo firewall-cmd --permanent --new-zone=sales
    $ sudo firewall-cmd --permanent --new-zone=mail
    ```

#### Set the zones to their designated interfaces:

- Run the commands that sets your `eth` interfaces to your zones.

    ```bash
    $ sudo firewall-cmd --zone=public --change-interface=eth0 			
    $ sudo firewall-cmd --zone=web --change-interface=eth1
    $ sudo firewall-cmd --zone=sales --change-interface=eth2
    $ sudo firewall-cmd --zone=mail --change-interface=eth3
    ```

#### Add services to the active zones:

- Run the commands that add services to the **public** zone, the **web** zone, the **sales** zone, and the **mail** zone.

- Public:

    ```bash
    $ sudo firewall-cmd --zone=public --add-service=http 
    $ sudo firewall-cmd --zone=public --add-service=https 
    $ sudo firewall-cmd --zone=public --add-service=pop3 
    $ sudo firewall-cmd --zone=public --add-service=smtp 
    ```

- Web:

    ```bash
    $ sudo firewall-cmd --zone=web --add-service=http
    $ sudo firewall-cmd --zone=web --add-source=201.45.34.126
    ```

- Sales

    ```bash
    $ sudo firewall-cmd --zone=sales --add-service=https 
    $ sudo firewall-cmd --zone=sales --add-source=201.45.15.48
    ```

- Mail

    ```bash
    $ sudo firewall-cmd --zone=mail --add-service=smtp 
    $ sudo firewall-cmd --zone=mail --add-service=pop3 
    $ sudo firewall-cmd --zone=mail --add-source=201.45.105.12
    ```

- What is the status of `http`, `https`, `smtp` and `pop3`?

    They have been added to the respective zones

#### Add your adversaries to the Drop Zone.

- Run the command that will add all current and any future blacklisted IPs to the Drop Zone.

     ```bash
    $ sudo firewall-cmd  --zone=drop --add-source=10.208.56.23
    $ sudo firewall-cmd  --zone=drop --add-source=135.95.103.76
    $ sudo firewall-cmd  --zone=drop --add-source=76.34.169.118
    ```

#### Make rules permanent then reload them:

It's good practice to ensure that your `firewalld` installation remains nailed up and retains its services across reboots. This ensure that the network remains secured after unplanned outages such as power failures.

- Run the command that reloads the `firewalld` configurations and writes it to memory

    ```bash
    $ sudo firewall-cmd --runtime-to-permanent
    $ sudo firewall-cmd --reload
    ```

#### View active Zones

Now, we'll want to provide truncated listings of all currently **active** zones. This a good time to verify your zone settings.

- Run the command that displays all zone services.

    ```bash
    $ sudo firewall-cmd --get-active-zones
    ```

    ````bash
    drop
        sources: 10.208.56.23 135.95.103.76 76.34.169.118
    mail
        interfaces: eth3
        source: 201.45.105.12
    public
        interfaces: eth0
    sales
        interfaces: eth2
        source: 201.45.15.48
    web
        interfaces: eth1
        source: 201.45.34.126
    ````

#### Block an IP address

- Use a rich-rule that blocks the IP address `138.138.0.3`.

    ```bash
    $ sudo firewall-cmd --zone=public --add-rich-rule='rule family="ipv4" source address="138.138.0.3" reject' --permanent
    ```

#### Block Ping/ICMP Requests

Harden your network against `ping` scans by blocking `icmp ehco` replies.

- Run the command that blocks `pings` and `icmp` requests in your `public` zone.

    ```bash
    $ sudo firewall-cmd --zone=public --add-icmp-block=echo-reply --add-icmp-block=echo-request --permanent
    ```

#### Rule Check

Now that you've set up your brand new `firewalld` installation, it's time to verify that all of the settings have taken effect.

- Run the command that lists all  of the rule settings. Do one command at a time for each zone.

    ```bash
    $ sudo firewall-cmd --zone=public --list-all
    $ sudo firewall-cmd --zone=web --list-all
    $ sudo firewall-cmd --zone=sales --list-all
    $ sudo firewall-cmd --zone=mail --list-all
    $ sudo firewall-cmd --zone=drop --list-all
    ```

- Are all of our rules in place? If not, then go back and make the necessary modifications before checking again.


Congratulations! You have successfully configured and deployed a fully comprehensive `firewalld` installation.

---

### Part 3: IDS, IPS, DiD and Firewalls

Now, we will work on another lab. Before you start, complete the following review questions.

#### IDS vs. IPS Systems

1. Name and define two ways an IDS connects to a network.

   > Answer 1:<span style="color:blue"> **Network TAP (Test Access Port), is a hardware device that provides access to a network. Network taps transit both inbound and outbound data streams on separate channels at the same time, so all data will arrive at the monitoring device in real time.** </span>

   > Answer 2:<span style="color:blue"> **SPAN (Switched Port Analyzer) known as (port mirroring), sends a mirror image of all network data to another physical port, where the packets can be captured and analyzed.**</span>

2. Describe how an IPS connects to a network.

   > Answer:<span style="color:blue">**IPS connects inline with the flow of data, typically between the firewall and network switch.**</span>

3. What type of IDS compares patterns of traffic to predefined signatures and is unable to detect Zero-Day attacks?

   > Answer:<span style="color:blue"> **Signature Based**</span>

4. Which type of IDS is beneficial for detecting all suspicious traffic that deviates from the well-known baseline and is excellent at detecting when an attacker probes or sweeps a network?

   > Answer:<span style="color:blue"> **Anomaly Based**</span>

#### Defense in Depth

1. For each of the following scenarios, provide the layer of Defense in Depth that applies:

    1.  A criminal hacker tailgates an employee through an exterior door into a secured facility, explaining that they forgot their badge at home.

        > Answer:<span style="color:blue"> **Physical**</span>

    2. A zero-day goes undetected by antivirus software.

        > Answer:<span style="color:blue"> **Application**</span>

    3. A criminal successfully gains access to HR’s database.

        > Answer:<span style="color:blue"> **Data**</span>

    4. A criminal hacker exploits a vulnerability within an operating system.

        > Answer:<span style="color:blue"> **Host**</span>

    5. A hacktivist organization successfully performs a DDoS attack, taking down a government website.

        > Answer:<span style="color:blue"> **Network**</span>

    6. Data is classified at the wrong classification level.

        > Answer:<span style="color:blue"> **Policy, Procedures, and Awareness**</span>

    7. A state sponsored hacker group successfully firewalked an organization to produce a list of active services on an email server.

        > Answer:<span style="color:blue"> **Perimeter**</span>

2. Name one method of protecting data-at-rest from being readable on hard drive.

    > Answer:<span style="color:blue"> **Encryption at rest, fingerprint reader for two-factor authentication, and Bitlocker.**</span>

3. Name one method to protect data-in-transit.

    > Answer:<span style="color:blue"> **End-to-end encryption**</span>

4. What technology could provide law enforcement with the ability to track and recover a stolen laptop.

   > Answer:<span style="color:blue"> **GPS and LoJack for Laptops**</span>

5. How could you prevent an attacker from booting a stolen laptop using an external hard drive?

    > Answer:<span style="color:blue"> **Firmware encrypted password**</span>


#### Firewall Architectures and Methodologies

1. Which type of firewall verifies the three-way TCP handshake? TCP handshake checks are designed to ensure that session packets are from legitimate sources.

   > Answer:<span style="color:blue"> **Circuit-Level Gateways (Proxy)**</span>

2. Which type of firewall considers the connection as a whole? Meaning, instead of looking at only individual packets, these firewalls look at whole streams of packets at one time.

   > Answer:<span style="color:blue"> **Stateful Packet Filtering Firewalls**</span>

3. Which type of firewall intercepts all traffic prior to being forwarded to its final destination. In a sense, these firewalls act on behalf of the recipient by ensuring the traffic is safe prior to forwarding it

   > Answer:<span style="color:blue"> **Proxy-based Firewalls**</span>


4. Which type of firewall examines data within a packet as it progresses through a network interface by examining source and destination IP address, port number, and packet type- all without opening the packet to inspect its contents?

   > Answer:<span style="color:blue"> **Packet-Filtering Firewall (Stateless)**</span>


5. Which type of firewall filters based solely on source and destination MAC address?

   > Answer:<span style="color:blue"> **MAC Firewall**</span>




---

© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.
