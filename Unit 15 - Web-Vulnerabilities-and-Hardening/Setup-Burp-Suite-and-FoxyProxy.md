**Setup the security proxy tool Burp Suite**

1. From the command line, type `sudo burpsuite` and press Enter.

   - Enter in your password: `cybersecurity` when prompted

   - This will open the **Burp Suite** application.

   - On the first page of Burp Suite, select **Temporary project** from the list of options. Select Next on the bottom right of the page. [Burp Suite Temporary Project Image](Images/burpsetup.png)

   - On the second page, select **Use Burp defaults** from the list of options. Select Start Burp on the bottom right of the page. [Use Burp defaults Image](Images/burpdef.png)

   - The Burp Suite Dashboard will appear once you have successfully accessed Burp Suite. 

     The following image illustrates the page that should be displayed: [Burp Suite Dashboard](Images/burpdash.png)

     

2. We need to set up the proxy to capture web traffic with Burp.

   - Select the Proxy tab from the tool bar at the top of the Burp window.

   - On this page, confirm that Intercept is on. You should see a gray button that reads **Intercept is on**:

   - If the button says **Intercept is off**, click the button to turn it back on.

   - Under Proxy on the tool bar, select the Options tab.

    - Under Proxy Listeners, confirm that you have the interface `127.0.0.1:8080` set up, with the Running option checked.

     - The following image illustrates how the listener should be set up: [Burp Suite Proxy](Images/proxy.png)

       

3. Next we need to set up the proxy to send traffic to Burp from Firefox.

   - Open the Firefox browser within Vagrant.

     - **Note**: You can open the Firefox browser from the Vagrant menu or type "firefox" in your terminal.
   - Next we need to add a free add-on browser feature called **Foxy Proxy**.
   - In your browser, search for "Foxy Proxy" and select **Add to Firefox**.
   - Once you have added it, you will see the Foxy Proxy icon in the top-right corner of your browser.
     - It is a drawing of a fox, with a circle and line through it.

     - The circle and line indicate that it is currently not enabled.
    - Click on the Foxy Proxy add-on, and the application will open a box on the top right of your browser.

   - Within the Foxy Proxy window that opens, select Options.

     - Select Add on the top left, to go to the Add Proxy page.

     - Because we are going to add a proxy to send the traffic to Burp Suite, under Title, enter "Burp" or "Burp Suite".

    - On the right, update the following fields to match what we configured in Burp:

      - Proxy Type: `HTTP`

      - Proxy IP address or DNS name: `127.0.0.1`

      - Port: `8080`

    - Leave the rest of the fields blank.

   - Select Save on the bottom right to save your proxy.

