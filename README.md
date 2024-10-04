## notification-header

This Application extension for SharePoint 2019 adds a Banner to each page in a Website or in a SiteCollection.

### Building the code

```bash
git clone the repo
npm i
npm i -g gulp
gulp
```

This package produces the following:

* lib/* - intermediate-stage commonjs build artifacts
* dist/* - the bundled script, along with other resources
* deploy/* - all resources which should be uploaded to a CDN.

### Build options

gulp clean - TODO
gulp test - TODO
gulp serve - TODO
gulp bundle - TODO
gulp package-solution - TODO

### Powershell script for activating it on SharePoint SiteCollections

There are 2 Powershell scripts using PnP Powershell in the folder src/Deployment that aid you in adding and removing this ApplicationExtension from a SiteCollection.
