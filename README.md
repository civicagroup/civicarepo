Group 17 App Design Project - README 
===

# CIVICA APP

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)
3. [Video Walkthrough](#Video-Walkthrough)

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

The **Project Board** can be located [here](https://github.com/orgs/civicagroup/projects/1).

**Required Must-have Stories**

- [x] User can see list of their representatives when they input their address
- [x] User can click on a representative's name to see more about them
- [x] User can see if there are any news about a representative 
- [x] user can see local municipal news if no news about representative is available
- [x] User can see representative's latest tweets (if their account is verified)

**Optional Nice-to-have Stories**
- [ ] User logs in to twitter through the app
- [ ] User can reply to a tweet
- [ ] User can retweet
- [x] Event organizers/users create an account with our app
- [x] Event organizers can create local events
- [ ] Local events get displayed to users based on their address/city/zipcode
- [ ] Users can favorite useful info

### Video Walkthrough

Here's a walkthrough of implemented user stories:

#### Code Sprint 2
<img src='https://github.com/civicagroup/civicarepo/blob/osl/codeSprint2.gif' title='Video Walkthrough' width='250' alt='Video Walkthrough' />

#### Code Sprint 1
<img src='https://github.com/civicagroup/civicarepo/blob/get_local_news/localNews.gif' title='Video Walkthrough' width='250' alt='Video Walkthrough' />
<img src='https://github.com/civicagroup/civicarepo/blob/osl/codeSprint1.gif' title='Video Walkthrough' width='250' alt='Video Walkthrough' />


### 2. Screen Archetypes

* Landing page
   * User inputs address
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
<img src="https://i.imgur.com/ApDYqBG.png" width=600>

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 
[This section will be completed in Unit 9]
### Models
#### User

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId      | String   | unique id for the user (default field) |
   | emaileVerified | Boolean | determine whether email was verified | 
   | username        | String | username user uses to log in with |
   | password         | String     | password user uses to log in with |
   | email       | String   | image caption by author |
   | createdAt | DateTime | date when post is created (default field) | 
   | updatedAt | DateTime | date when post is last updated (default field) |
   
#### Comments
   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId | String | unique id for the comments (default field) | 
   | createdAt | DateTime | date when comment is created (default field) | 
   | updatedAt | DateTime | date when comment is last updated (default field) |
   | event | Pointer to Events | event associatted with comment | 
   | author | Pointer to User | user who posted comment | 

#### Events
   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId | String | unique id for the event (default field) | 
   | organizer | Pointer to User | Event organizer | 
   | description | String | event description |
   | createdAt | DateTime | date when post is created (default field) | 
   | updatedAt | DateTime | date when post is last updated (default field) |
   | attendees | Array[Pointer to User] | List of attendees | 
   | image | File | image of event post |
   | comments | Array[Pointer to Comments] | List of comments |
### Models
[Add table of models]
### Networking
**List of network requests by screen**

  - Landing page & list of reps: 
      - (Read/GET) representatives based on address input
  - single rep view:
      - (Read/GET) contact info 
      - (Read/GET) rep's twitter profile
      - (Read/GET) news about rep
      - (Create/POST) respond to a tweet
    
- [Create basic snippets for each Parse network request]
- 
#### [OPTIONAL:] Existing API Endpoints
##### Google Civic Info API
- Base URL - [https://www.googleapis.com/civicinfo/v2/](https://www.googleapis.com/civicinfo/v2/representatives)

   HTTP Verb | Endpoint | Description
   ----------|----------|------------
    `GET`    | /representatives/?address=address | get all representatives for a specific address |
    `GET` | /representatives/?levels=levels | get all representatives for a specific level |
    `GET` | /representatives/?role=role | get all representatives for a specific role |
    
##### Google News API
- Base URL - [https://newsapi.org/s/google-news-api](https://newsapi.org/s/google-news-api)

   HTTP Verb | Endpoint | Description
   ----------|----------|------------
    `GET`    | /v2/top-headlines | Get the top  news headline |
    
#### Twitter API 
- Base URL - [https://api.twitter.com](https://api.twitter.com)

    HTTP Verb | Endpoint | Description
   ----------|----------|------------
    `GET`    | /1.1/statuses/user_timeline.json | Get information on the specifed user |
    `POST`    | /1.1/favorites/create.json | Favorites (likes) the Tweet specified in the ID parameter  |
    `POST`    | /1.1/favorites/destroy.json | Unfavorites (un-likes) the Tweet specified in the ID parameter |
    `POST`    | /1.1/statuses/retweet/:id.json | Retweets a tweet |
    `POST`    | /1.1/statuses/unretweet/:id.json | Untweets a retweeted status |

## Video Walkthrough
Here's a walkthrough of implemented user stories:

<img src='./localNews.gif' title='Video Walkthrough' width='250' alt='Video Walkthrough' />

<img src=https://media2.giphy.com/media/cS93j8FQDZ3b6q2CgN/giphy.gif?cid=790b76111adde5895dd1cd4ddccacd11c26b3a9e611072f4&rid=giphy.gif&ct=gtitle='Video Walkthrough' width='250' alt='Video Walkthrough' />
