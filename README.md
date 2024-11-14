# Fresh Recipes API

This is a backend database that helps track subscriptions for a company that sells tea.

## About this Application

This application is designed around the idea of expandability. It has the basic premises of tracking subscriptions, customers, and teas, while offering some extra features that could be expanded upon without serious rewriting of the database.

## Setup

#### Versions
- Ruby: 3.2.2  
- Rails: 7.1.4.2


1. Fork and clone the repo
2. Install gem packages: `bundle install`
3. Setup the database: `rails db:{drop,create,migrate,seed}`
4. Only seed if you want the prebuilt data, otherwise don't worry about it.

## Database Overview

The database should create 5 tables for you and is now ready to take in the required data to track tea subscriptions. 

## Testing the API
Utilizing RSpec, WebMock, and VCR, there is a wide array of built in tests to help troubleshoot your databases.
- Use `bundle exec rspec spec/...` to run rspec within the api

# Endpoints

## Subscriptions
### Get all subscriptions
`GET /api/v1/subscriptions/` **No authentication needed** <br>
To retrieve all the available subscriptions in your user base. It will return basic information on every available subscription.

### Get one subscription
`GET /api/v1/subscriptions/:id` **No authentication needed** <br>
To retrieve one subscription from the database. It will return all the information of the subscription to include teas, active users and inactive users.

### Update a subscription
`PUT /api/v1/subscriptions/:id` **No authentication needed** <br>
To update the status of the subscription from active to canceled or from canceled to active. It requires a parameter being sent.

###Parameters
**"status"**: |string| Is looking for currently two different strings `canceled` or `active`<br>

#### Example of Parameters
```
params = {
  status: "canceled"
}
```


## Contributors

- [Shane G.](https://github.com/Sgalvin36)

## Future features
- Build out functionality to allow customers to define their own subscriptions by establishing the teas that they would like and the frequency that they would like them.
