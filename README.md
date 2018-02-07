# SmartAc

## Device API

There are two endpoints a device needs to know about. One, during setup, gets you an authentication token to then use at the other endpoint, which allows you to submit your device's status reports.

### `POST /api/air_conditioner`

This endpoint expects a body containing the Air Conditioner's attributes. The body should be formatted like so:

```json
{
  "serial": "serial12345",
  "registered_at": "2010-04-17 14:00:00.000000Z",
  "firmware_version": "0.1"
}
```

Which will return:

```json
{
  "token" : "JWT.token.here"
}
```

This will in turn let you utilize the second endpoint.

### `POST /api/status_report/bulk`

This endpoint expects both a formatted `authorization` header, containing `"Bearer <token_from_previous_endpoint>"`. Without this the request will fail.

 and a body containing a collection of status reports. 1 or more can be included, but they must always be in a JSON array, formatted like so:

```json
{
  "status_reports": [
    {"carbon_monoxide_ppm": 1, "temperature": 13, "humidity": 14, "device_health": "healthy"},
    {"carbon_monoxide_ppm": 2, "temperature": 15, "humidity": 8, "device_health": "aging"},
  ]
}
````

Which in turn, will return:

```json
{
  "number_created": 2
}
```

## Local Server Development
To start your Phoenix server:

* Install dependencies with `mix deps.get`
* Create and migrate your database with `mix ecto.create && mix ecto.migrate`
* Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Server Production

For now we'll assume Heroku, as a more complex setup will require additional work. And for now, we're using SendGrid for emails. Have your API key ready!

1 After provisioning an instance, add the Heroku Postgres addon.
2 Next, put the SendGrid API key in the environment variable, "SEND_GRID_API_KEY".
3 Add a "SECRET_KEY_BASE" environment variable. You can generate it locally via `mix guardian.gen.secret`.
4 Run `heroku run mix ecto.migrate`
5 Add an admin via `heroku run mix smart_ac.create_admin email password`
6 Log in, you're good to go!

With all that, you should be able to push the repo to your heroku instance and you're up and running.
