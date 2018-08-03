# Launching the Website: Repointing DNS to Development Server
The following instructions detail how to update a site which has been built on a development server and the domain name for the live website will be repointed to the development server. No files will be moved and the site does not need to be republished in its entirety. In the following examples, the development server was *dev.domain.edu* and the production domain is *www.domain.edu*.

## Site Setup
### Update FTP Settings
1. Setup > Sites > Edit (for the site)
2. Production Server FTP/SFTP Settings
   a. Server: change from development server to live production server url; e.g., dev.domain.edu:222 becomes www.domain.edu:222. If an IP address is used, no change is necessary.
   b. FTP Root: may be unchanged if the site does not change server locations, but this should be verified by your server administrators.
   c. HTTP Root: update from development to production; ie., http://dev.domain.edu becomes http://www.domain.edu.
   d. FTP Root Relative – the following settings may be unchanged if the site does not change server locations, but this should be verified by your server administrators.
      - FTP Home
      - FTP Directory
      - Image Directory
      - LDP Gallery Directory
      - Template Directory
3. LDP Settings
   a. *LDP Admin Host:* the OU Server-Side Module (SSM) may be installed on the same web server as your published files, or it may be on a separate server. If installed on development, update host to production. If not, leave unchanged.

## Updating Links
It is recommended that you keep your development subdomain active for a period following the go-live to ensure that all links are updated. There are multiple instances where absolute links to the development domain may need to be updated manually: in RSS items, in Assets, and in Content.

*Updating RSS Feeds and Items* – If RSS items are created prior to going live there are several manual updates which will need to be made. If there are too many items built out to edit by hand, OmniUpdate has a tool to automate this process. Please contact your Project Manager about scheduling the best time prior or after “go-live” to make these updates.

### Update Links for RSS feeds
1. Select Content > RSS from the global navigation bar. The RSS Feeds view is shown.
2. Click the linked path or hover over the row to display the options and select Edit.
3. Change the Link from http://dev.domain.edu to http://www.domain.edu.
4. Click Save.
5. Publish the feed for the changes to take effect.

### Update Links for RSS Items
1. From Content > RSS > hover over the feed and click Items (Admins Only)
2. Change the “Link” from http://dev.domain.edu to http://www.domain.edu.
3. Edit each Media Content item, click the item link to edit it. Update “Link” and “Thumbnail” to update file URLs from http://dev.domain.edu/_resources/img/image.jpg to http://www.domain.edu/_resources/img/image.jpg.

*Updating Assets* – Assets are excluded from Find & Replace, so any links to pages at http://dev.domain.edu will need to be manually updated to http://www.domain.edu. Assets must be republished for changes to take effect.

*Updating Content* – Find and Replace any instances of http://dev.domain.edu with http://www.domain.edu in page content. Pages must be republished for changes to take effect.

### Find and Replace
Please read the Global Find and Replace documentation on the OmniUpdate Support website at [http://support.omniupdate.com/oucampus10/interface/content/find-replace.html](http://support.omniupdate.com/oucampus10/interface/content/find-replace.html).
1. Content > Find and Replace
2. Choose Literal Text search. Review the results with a "find-only" search before doing a full-scale replace.
   a. Find: dev.domain.edu
   b. Replace with: www.domain.edu
   c. Comment: Switch to production domain.

## Republishing Assets
To enable LDP Gallery assets to be used across multiple sites they are given absolute URLs to the thumbnail and image locations based on current HTTP Root. After the HTTP Root has been updated, gallery assets will need to be checked-out and republished. Republishing the assets will republish all pages on which they are deployed.

### Update Gallery Assets
1. Content > Assets
2. Sort the list to show all the gallery assets together and select the check-box next to them.
3. Publish all the selected assets.

## Enable Analytics
To prevent skewing of analytics data (e.g. Google), the code is typically hidden during development. How to enable analytics will depend on your implementation and what was decided during the specifications process. The most common implementation is for an analytics.inc file is included on each page and instructions on how to update this file are below.

### Update an Included File
1. Content > Pages
2. Checkout and select “Source Edit” of the include file, which is commonly located at [/_resources/includes/analytics.inc/](/_resources/includes/analytics.inc/) but may be unique to your site.
3. Remove <!-- ... --> from around code. If no code has been provided, this include will be empty and you will need to get existing analytics code from your current website or from [http://support.google.com/analytics/bin/answer.py?hl=en&answer=1008080](http://support.google.com/analytics/bin/answer.py?hl=en&answer=1008080).
4. Save and publish. This will update all pages where that file is being included.

## Finishing Details
- Test search functionality.
- Test “Share This” links.
- Verify all necessary robots.txt files have been uploaded or updated.
- Verify favicon icon (next to browser address bar) is enabled. 

## Tips
- Prepare to go live at a time when you believe the fewest amount of viewers will be visiting the website.
- Schedule the go-live with OmniUpdate so that members of the OmniUpdate support team can be standing by.
- Ensure that the production server is set up to parse everything the site's pages need (i.e., server- side includes, PHP/ASP.NET/CFM, etc.).