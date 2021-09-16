### Week 14 Homework Submission File : Web Development
---

### Questions



#### HTTP Requests and Responses

Answer the following questions about the HTTP request and response process.

1. What type of architecture does the HTTP request and response process occur in?
    - <span style="color: blue">Client -Server Architecture. HTTP is based on the client-server architecture model and a stateless request/response protocol that operates by exchanging messages across a reliable TCP/IP connection.</span>


2. What are the different parts of an HTTP request?
    - <span style="color: blue">An HTTP request is divided into three parts: request line, header and body. A cycle of requests and responses between clients and servers.</span>


3. Which part of an HTTP request is optional?'
    - <span style="color: blue">The request body.</span>


4. What are the three parts of an HTTP response?
    - <span style="color: blue">An HTTP response is divided into the following parts: status line, response header and  response body.</span>


5. Which number class of status codes represents errors?
    - <span style="color: blue">400 and 500 status codes represent errors:</span>

        - <span style="color: red">400 CODES CLIENT ERRORS</span>

        - <span style="color: red">500 CODES SERVER ERRORS</span>


6. What are the two most common request methods that a security professional will encounter?
     - <span style="color: blue">GET and POST requests.</span>


7. Which type of HTTP request method is used for sending data?
    - <span style="color: blue">POST request.</span>


8. Which part of an HTTP request contains the data being sent to the server?
     - <span style="color: blue">The request body.</span>


9. In which part of an HTTP response does the browser receive the web code to generate and style a web page?
     - <span style="color: blue">The response body.</span>




#### Using curl

Answer the following questions about `curl`:

10. What are the advantages of using `curl` over the browser?
    - <span style="color: blue">Curl is able to pull information (raw) from the internet and display it in your terminal, it is repeatable, it can be modified while it is in use and it can be automated.</span>


11. Which `curl` option is used to change the request method?
     - <span style="color: blue">`-X` followed by a request method.</span>


1.  Which `curl` option is used to set request headers?
    - <span style="color: blue">`-H`: Sets a request header. For example: `curl -X --url https://httpbin.org/bearer -H 'authorization: {Type} {Credential}'`.</span>


13. Which `curl` option is used to view the response header?
    - <span style="color: blue">`-I` allows you to view the response header. For example: `curl -I example.com`</span>


14. Which request method might an attacker use to figure out which HTTP requests an HTTP server will accept?
    - <span style="color: blue">The OPTIONS request method for finding usable request methods.</span>




#### Sessions and Cookies

Answer the following questions about sessions and cookies:


15. Which response header sends a cookie to the client?

    ```HTTP
    HTTP/1.1 200 OK
    Content-type: text/html
    Set-Cookie: cart=Bob
    ```
    <span style="color: blue">Answer: The `Set-Cookie` response header send a cookie to the client.</span>

    ````HTTP
    Set-Cookie: cart=Bob
    ````

16. Which request header will continue the client's session?

    ```HTTP
    GET /cart HTTP/1.1
    Host: www.example.org
    Cookie: cart=Bob
    ```
    <span style="color: blue">Answer: The `Cookie` request header sends the `cart=Bob` cookie along with the GET request.</span>

    ````HTTP
    Cookie: cart=Bob
    ````

#### Example HTTP Requests and Responses

Look through the following example HTTP request and response and answer the following questions:

**HTTP Request**

```HTTP
POST /login.php HTTP/1.1
Host: example.com
Accept-Encoding: gzip, deflate, br
Connection: keep-alive
Content-Type: application/x-www-form-urlencoded
Content-Length: 34
Upgrade-Insecure-Requests: 1
User-Agent: Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Mobile Safari/537.36

username=Barbara&password=password
```

17. What is the request method?
    - <span style="color: blue">The request method is `POST`.</span>


18. Which header expresses the client's preference for an encrypted response?
    - <span style="color: blue">The `Upgrade-Insecure-Requests: 1` header.</span>


19. Does the request have a user session associated with it?
    - <span style="color: blue">No `Cookie` header is set, this indicates that there is no user associated with the request.</span>


20. What kind of data is being sent from this request body?
    - <span style="color: blue">It is an authentification request at the pages `/login.php` at the bottom we can also see `username=Barbara&password=password`.</span>




**HTTP Response**

```HTTP
HTTP/1.1 200 OK
Date: Mon, 16 Mar 2020 17:05:43 GMT
Last-Modified: Sat, 01 Feb 2020 00:00:00 GMT
Content-Encoding: gzip
Expires: Fri, 01 May 2020 00:00:00 GMT
Server: Apache
Set-Cookie: SessionID=5
Content-Type: text/html; charset=UTF-8
Strict-Transport-Security: max-age=31536000; includeSubDomains
X-Content-Type: NoSniff
X-Frame-Options: DENY
X-XSS-Protection: 1; mode=block

[page content]
```

21. What is the response status code?
    - <span style="color: green">`200 OK `</span>


22. What web server is handling this HTTP response?
     - <span style="color: blue">`Apache`</span>


23. Does this response have a user session associated to it?
    - <span style="color: blue">Yes `Set-Cookie: SessionID=5`</span>


24. What kind of content is likely to be in the [page content] response body?
    - <span style="color: blue">The `content-type: text/html` header indicates that the response body contains the site's web code.</span>


25. If your class covered security headers, what security request headers have been included?
    - <span style="color: blue">The `Strict-Transport-Security` header indicates that it should be only accessed over HTTPS and not over HTTP.</span>

        - <span style="color: blue">Always uses an https:// connection, even when clicking on an http:// link or after typing a domain into the location bar without specifying a protocol.</span>

        - <span style="color: blue">Removes the ability for users to click through warnings about invalid certificates.</span>

    - <span style="color: blue">The time, in seconds, that the browser should remember that a site is only to be accessed using HTTPS.</span>




#### Monoliths and Microservices

Answer the following questions about monoliths and microservices:

26. What are the individual components of microservices called?
    - <span style="color: blue">They are reffered to as `service`, meaning sysadmins have separated and isolated the front-end, back-end, and database components into their own machines. Each of the smaller blocks represent a single, independent machine. Within each machine is a component that executes one primary function or **service**.</span>


27. What is a service that writes to a database and communicates to other services?
    - <span style="color: blue">Most systems use application programming interfaces (APIs). In previous classes we used Ansible with SSH to communicate between our servers, but not every system uses Ansible to communicate.</span>


28. What type of underlying technology allows for microservices to become scalable and have redundancy?
    - <span style="color: blue">Containers allow microservices to be both scalable and redundant.</span>




#### Deploying and Testing a Container Set

Answer the following questions about multi-container deployment:

29. What tool can be used to deploy multiple containers at once?
    - <span style="color: blue">These requirements are achieved with a tool called Docker Compose.</span>


30. What kind of file format is required for us to deploy a container set?
    - <span style="color: blue">Docker Compose uses YAML files to declare container configurations. These files are often saved as `docker-compose.yml`.</span>




#### Databases

31. Which type of SQL query would we use to see all of the information within a table called `customers`?
    - <span style="color: blue">`SELECT * FROM customers;`</span>


32. Which type of SQL query would we use to enter new data into a table? (You don't need a full query, just the first part of the statement.)
    - <span style="color: blue">`INSERT INTO employees (firstname, lastname, email, department) `</span>

    - <span style="color: blue">`VALUES ('Luke', 'Latte', 'llatte@goodcorp.net', 'Logistics');`</span>


33. Why would we never run `DELETE FROM <table-name>;` by itself?
    - <span style="color: blue">You never want to run `DELETE FROM employees;` as it will delete the entire `employees`  table! </span>

    
    

---
**References**

- [HTTP Reference Sheet](Reference/HTTP_Reference.md)
- [curl Reference Sheet](Reference/cURL_Reference.md)

