

### Week 10 Homework Submission File: Cryptography Homework



**RIDDLE 1**

- I used https://cryptii.com/pipes/caesar-cipher with the -8 SHIFT pattern to determine the answer.

  > **Answer 1** =  **6skd8s**



**RIDDLE 2**

- I used CyberChef From Binary converter to determine the answer.

  > **Answer 2** =  **cy8snd2**



**Riddle 3**

**I used the Terminal in our VM.**

- Step 1 = Create a file that contains the cipher text.
    - Run - `echo 4qMOIvwEGXzvkMvRE2bNbg== > RIDDLE_3`

- Step 2 = Decrypted with openssl.
    - Run - `openssl enc -pbkdf2 -nosalt -aes-256-cbc -in RIDDLE_3 -d -base64 -K 5284A3B154D99487D9D8D8508461A478C7BEB67081A64AD9A15147906E8E8564 -iv 1907C5E255F7FC9A6B47B0E789847AED`

    > **Answer** = **ud6s98n**
    



**RIDDLE 4**

- Part 1 = Jill's Public Key
- Part 2 = Jill's Private Key
- Part 3 = 12 Asymmetric and 15 Symmetric
    - N * 2 for Asymmetric (N = Individuals )
    - (N * (N-1)) / 2 for Symmetric (N = Individuals )
- Part 4 = Alice's Public Key

    > **Answer** = **7gsn3nd2**



**RIDDLE 5**

**I used the Terminal in our VM.**

- Step 1 = Create a file that contains the Hash.
    - Run - `echo 3b75cdd826a16f5bba0076690f644dc7 > RIDDLE_5`

- Step 2 = Import the rockyou.txt file to crack the Hash.
    - Run - `cp /usr/share/wordlists/rockyou.txt ./`

- Step 3 = Use hashcat to decrypt.
    - Run - `hashcat -m 0 -a 0 -o RIDDLE_5_SOLVED RIDDLE_5 rockyou.txt --force`

- Step 4 = Preview the solved file.
    - Run - `cat RIDDLE_5_SOLVED`

    > **Answer** = **ajy39d2**
    



**RIDDLE 6**

**I used the Terminal in our VM.**

- Step 1 = I used steghide to extract the secret code.
    - Run- `steghide extract -sf mary-lamb.jpg`
        - `Enter passphrase: ABC (On the Book-Cover)`

- Step 2 = Preview the file  "code_is_inside_this_file.txt".
    - Run - `cat code_is_inside_this_file.txt`
        - Submit the secret code: `mcclane`

    > **Answer** = **7skahd6**
    



