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