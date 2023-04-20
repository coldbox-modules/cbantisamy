# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

* * *

## [Unreleased]

## [2.1.0] - 2023-04-20

### Added

-   Github actions
-   Github supprt files
-   Upgraded to AntiSamy 1.7.3

## [2.0.0] => 2022-01

### Changed

-   Changes the HTMLSanitizer method to use the native adobe `getSafeHTML()` and `isSafeHTML()` methods when on ACF
-   Updates module registration to use the Coldbox 5+ conventions ( Module configuration now nested in `moduleSettings` )
-   Changes the `autoClean` module configuration setting to default to `true`. This is opinionated but also makes this module more "plug and play"
-   Adds a `basic` policy file. This policy file is the same default policy file used by ACF
-   Renames the `resultsObject` argument in `HTMLSanitizer.cfc` method to check and changes it to return a boolean, to allow for consistent return types between ACF and Lucee
-   Remove the `check` argument from the `clean` method and adds a `check` method in `AntiSamy.cfc`

### Updated

-   Converts the build process to GitHub actions
-   Github repo slug was changed from `cbox-antisamy` to `cbantisamy` to allow the default CI scripts and request variables to work without major modification
-   Separates the Unit and Interceptor tests
-   Updates the AntiSamy JAR to v1.6.4

### Added

-   New helper methods: `antisamyClean(), antisamyCheck()`
-   Adds additional tests for return types

## [1.4.0] => 2017-03

### Updated

-   Updated fixes on readme and assets
-   Update of all dependencies
-   Updated antisamy to version 1.5.7

## [1.3.1] => 2017-03

### Updated

-   Unified workbench

## [1.3.0] => 2016-03

### Updated

-   Updated build process
-   Travis integration
-   JavaLoader dependencies updated
-   DocBox udpates

## [1.2.0] => 2015-08

### Updated

-   Updated readme locations
-   `Autoclean` property not respecting proper boolean value
-   Updated build process to CommandBox

## [1.1.0] => 2015-08

### Updated

-   Invalid slug id, so CommandBox was getting confused on installations

### Changed

-   Defaults for configuration setup differently to avoid collisions

## [1.0.0] => 2014-11

### Added

-   Create first module version

[Unreleased]: https://github.com/coldbox-modules/cbantisamy/compare/v2.1.0...HEAD

[2.1.0]: https://github.com/coldbox-modules/cbantisamy/compare/7ab109d61d824bd5da70332cc52d01133530d8d4...v2.1.0
