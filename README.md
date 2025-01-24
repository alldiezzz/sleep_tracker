# BREAK DOWN TASK
    ## Task:
        - ~ Setup Sleep Tracker Repo ~
        - Config New Repo
        - ~ create DB Diagram ~
        - ~ Create diagram Flow ~
        - ~ Add table to project (setup migration)~
        - Add Function
            -~ Api for record sleep ~
            -~ Api for record wakeup ~
            -~ Api for fetch sleep record ~
            -~ Api for follow ~
            -~ Api for unfollow ~
            -~ Api for fetch friend sleep record ~
            - Add unit test

# README

## How To Run
- Use Ruby 3.3.5
- Use Rails 8.0.1
- Run `bundle install`
- Run `rails db:migrate`
- Run `rails db:seed`
- update `.env.example` to `.env` and don't forget to update the DB credentials with your local creds
- Run `sidekiq`
- Run `rails s`

## DB Schema
<img width="815" alt="DB Schema" src="https://github.com/user-attachments/assets/a1ade284-48b3-42f6-a3e9-caa0c25ebda3" />

## App Diagram Flow
<img alt="App Diagram Flow" src="https://github.com/user-attachments/assets/c7cde5ad-c56e-47f6-9b0f-5269f83070cf/" />

## Functions
- API for recording sleep
- API for recording wakeup
- API for fetching sleep records
- API for follow
- API for unfollow
- API for fetching friend's sleep records


## Postman Collection
You can find the Postman collection file [here](/Sleep%20Tracker.postman_collection.json).


