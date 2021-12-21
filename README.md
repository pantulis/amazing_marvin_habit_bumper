# Amazing Marvin Habit Bumper

This is a minimal Sinatra App to interface with Amazing Marvin Habit API.

**Important** - This is low level stuff.  Use at your own risk: any bug in the code or any unexpected changes in Amazing Marvin's internal data structures can destroy your data.  Always backup your data.

## Requirements

The following environment variables need to be configured:

```
ENV["SYNC_USER"]
ENV["SYNC_PASSWORD"]
ENV["SYNC_SERVER"]
ENV["SYNC_DATABASE"]
```

They can be easily obtained from Amazing Marvin's settings page.  You do not need to configure the API_TOKEN and FULL_ACCESS_TOKEN variables.

## Endpoints

### GET /habits

Returns a JSON file including all the habits present in Marvin's Cloudant database.   This includes the name of the Habit and its internal id.
You can parse this file with a tool like jq:

```
curl https://<your-server.com>/habits | jq '.docs[] | [._id, .title]'
````

### GET /habits/<habit_id>

Returns a JSON file including the data for a specific id. Use this to double check the specific ID of the habit you are trying to bump.

### GET /habits/bump/<habit_id>

This downloads the habit information from Amazing Marvin database, inserts a new ocurrence and uploads the information, effectively _bumping_ the habit.  Upon hitting this endpoint, you should see Amazing Marvin's updating the habit in realtime in the "Today's Habits" screen.

Note: although this technically should be a POST request, I've decide to use a GET in order to facilitate integration with other tools.  



