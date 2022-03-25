Group 20 App Design Project - README 
===

# CIVICA APP

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Civica is an app that promotes civic engagement by providing the user access to information about their representatives in one centralized hub. With Civica users input their address in order to receive a list of all their representatives from the presidential to the municipal level and everything in between. When users tap on the name of a representative they have access to the latest news about them as well as a look into their latest tweets. 

### App Evaluation

- **Category:** Civic Engagement
- **Mobile:** App would be mobile first (iOS), but could be expanded to desktop.
- **Story:** Connects citizens with their local representatives, raise awareness of community development, invite users to be participants of local volunteering events. An app that the folks at Pawness in Parks & Rec would use.
- **Market:** There is a market gap in apps for civic engagement. Average citizens who would like to be more informed or engaged with their local governments and civic organizations would find this app userful. 
- **Habit:** By offering pertinent news stories and personal tweets, this app provides users a personal touch of civic engagement that government websites cannot rival.
- **Scope:** First this app serves as an information aggregator. Gradually, we would like to see community leaders use this app to communicate civic events with the users. 

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User can see list of their representatives when they input their address
* User can click on a representative's name to see more about them
* User can see if there are any news about a representative 
* user can see local municipal news if no news about representative is available
* User can see representative's latest tweets (if their account is verified)


**Optional Nice-to-have Stories**
* User logs in to twitter through the app
* User can reply to a tweet
* User can retweet
* Event organizers/users create an account with our app
* Event organizers can create local events
* Local events get displayed to users based on their address/city/zipcode
* Users can favorite useful info

### 2. Screen Archetypes

* Login
   * User logs in to twitter through the app
* Registration
   * Event organizers/users create an account with our app
* Stream
   * User can see list of their representatives when they input their address
   * User can see if there are any news about a representative
   * User can see local municipal news if no news about representative is available
   * User can see representative's latest tweets (if their account is verified)
   * Local events get displayed to users based on their address/city/zipcode
* Detail
   * User can reply to a tweet
   * User can retweet
   * Users can favorite useful info
* Creation
   * Event organizers can create local events
* Profile
   * User can click on a representative's name to see more about them

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Local news
* Local representatives
* My Profile

**Flow Navigation** (Screen to Screen)
* Welcome screen
    * Require user address
    * Optional login to Civica
* Local news
   * Tap on a news cell to modally open a new screen with the story from the source site
* Local representatives
   * Tap on a representative's name to open a new screen with their contact info, latest news, and/or tweets
       * Retweet or reply to a tweet
* My profile
    * Login to Twitter screen
    * Login to Civica screen
    * Input my address
    * Open My Saved Stories

## Wireframes
[Add picture of your hand sketched wireframes in this section]
<img src="YOUR_WIREFRAME_IMAGE_URL" width=600>

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 
[This section will be completed in Unit 9]
### Models
[Add table of models]
### Networking
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
