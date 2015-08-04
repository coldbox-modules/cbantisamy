WELCOME TO THE ANTISAMY MODULE
==============================
OWASP AntiSamy Module that provides XSS cleanup operations to ColdBox 4 applications

* http://www.owasp.org/index.php/Category:OWASP_AntiSamy_Project
* http://code.google.com/p/owaspantisamy/downloads/list

##LICENSE
Apache License, Version 2.0.

##IMPORTANT LINKS
- https://github.com/ColdBox/cbox-antisamy
- http://forgebox.io/view/cbantisamy

##SYSTEM REQUIREMENTS
- Railo 4+
- ColdFusion 9+

---

#INSTRUCTIONS
Just drop into your **modules** folder or use the box-cli to install

`box install cbantisamy`

The module registers the following mapping in WireBox: `antisamy@cbantisamy`
that you can use to clean input a-la-carte intrusions.  You can also activate different policies and an auto clean interceptor that will clean incoming variables for you automatically.  The main methods to clean input are:

- `clean( HTMLData, policyFile='ebay', resultsObject=false)`

## Settings
Here are the module settings you can place in your `ColdBox.cfc` under an `antisamy` structure

```js
// Antisamy settings
antisamy = {
    // Activate auto request capture cleanups interceptor
    autoClean = false,
    // Default Policy to use, available are: antisamy, ebay, myspace, slashdot and tinymce
    defaultPolicy = "ebay",
    // Custom Policy absolute path, leave empty if not used
    customPolicy = ""
};
```

You can read more about AntiSamy here: https://www.owasp.org/index.php/Category:OWASP_AntiSamy_Project

********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldbox.org | www.luismajano.com | www.ortussolutions.com
********************************************************************************
####HONOR GOES TO GOD ABOVE ALL
Because of His grace, this project exists. If you don't like this, then don't read it, its not for you.

>"Therefore being justified by faith, we have peace with God through our Lord Jesus Christ:
By whom also we have access by faith into this grace wherein we stand, and rejoice in hope of the glory of God.
And not only so, but we glory in tribulations also: knowing that tribulation worketh patience;
And patience, experience; and experience, hope:
And hope maketh not ashamed; because the love of God is shed abroad in our hearts by the 
Holy Ghost which is given unto us. ." Romans 5:5

###THE DAILY BREAD
 > "I am the way, and the truth, and the life; no one comes to the Father, but by me (JESUS)" Jn 14:1-12