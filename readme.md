<p align="center">
	<img src="https://www.ortussolutions.com/__media/coldbox-185-logo.png">
	<br>
	<img src="https://www.ortussolutions.com/__media/wirebox-185.png" height="125">
	<img src="https://www.ortussolutions.com/__media/cachebox-185.png" height="125" >
	<img src="https://www.ortussolutions.com/__media/logbox-185.png"  height="125">
</p>

<p align="center">
	Copyright Since 2005 ColdBox Platform by Luis Majano and Ortus Solutions, Corp
	<br>
	<a href="https://www.coldbox.org">www.coldbox.org</a> |
	<a href="https://www.ortussolutions.com">www.ortussolutions.com</a>
</p>

----

# WELCOME TO THE ANTISAMY MODULE

OWASP AntiSamy Module that provides XSS cleanup operations to ColdBox applications

- http://www.owasp.org/index.php/Category:OWASP_AntiSamy_Project
- http://code.google.com/p/owaspantisamy/downloads/list
- https://jar-download.com/artifacts/org.owasp.antisamy/antisamy

## LICENSE

Apache License, Version 2.0.

## IMPORTANT LINKS

- Source: https://github.com/coldbox-modules/cbantisamy
- ForgeBox: http://forgebox.io/view/cbantisamy

## SYSTEM REQUIREMENTS

- Lucee 5+
- ColdFusion 2018+

---

## Instructions

Just drop into your `modules` folder or use the box-cli to install

`box install cbantisamy`

## Usage

The module registers the following mapping in WireBox: `antisamy@cbantisamy`
that you can use to clean input a-la-carte intrusions.  You can also activate different policies and an auto clean interceptor that will clean incoming variables for you automatically.  The main methods to clean input are:

```javascript
/**
 * Clean HTML from XSS scripts using the AntiSamy project. The available policies are basic, antisamy, ebay, myspace, slashdot, custom
 *
 * @htmlData   The html data to clean
 * @policyFile The policy file to use. Defaults to the one in the configuration file
 *
 * @return sanitized html data
 */
string function clean( required htmlData, string policyFile = variables.defaultPolicy )

/**
 * Checks whether HTML is safe from XSS scripts using the AntiSamy project. The available policies are basic, antisamy, ebay, myspace, slashdot, custom
 *
 * @htmlData   The html data to clean
 * @policyFile The policy file to use. Defaults to the one in the configuration file
 *
 * @return True if it is safe, false if not
 */
boolean function check( required htmlData, string policyFile = variables.defaultPolicy )
```

You can also use the two registered helper methods which delegate to the two methods above:

* `antisamyClean()`
* `antisamyCheck()`

## Settings

Here are the module settings you can place in your `ColdBox.cfc` under an `antisamy` structure

```js
// Antisamy settings
moduleSettings = {
    "cbantisamy" : {
        // Activate auto request capture cleanups interceptor
        autoClean = true,
        // Default Policy to use, available are: antisamy, ebay, myspace, slashdot and tinymce
        defaultPolicy = "ebay",
        // Custom Policy absolute path, leave empty if not used
        customPolicy = ""
    }
};
```

You can read more about AntiSamy here: https://www.owasp.org/index.php/Category:OWASP_AntiSamy_Project

********************************************************************************
Copyright Since 2005 ColdBox Framework by Ortus Solutions, Corp
www.ortussolutions.com
********************************************************************************

### HONOR GOES TO GOD ABOVE ALL

Because of His grace, this project exists. If you don't like this, then don't read it, its not for you.

>"Therefore being justified by faith, we have peace with God through our Lord Jesus Christ:
By whom also we have access by faith into this grace wherein we stand, and rejoice in hope of the glory of God.
And not only so, but we glory in tribulations also: knowing that tribulation worketh patience;
And patience, experience; and experience, hope:
And hope maketh not ashamed; because the love of God is shed abroad in our hearts by the
Holy Ghost which is given unto us. ." Romans 5:5

### THE DAILY BREAD

 > "I am the way, and the truth, and the life; no one comes to the Father, but by me (JESUS)" Jn 14:1-12
