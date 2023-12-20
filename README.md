# Usage

This Acorn will prompt the user for the following information:

* address: the address of the Redis server. (no port)
* port: the port of the Redis server.
* adminUsername: the username of the admin user.
* adminPassword: the password of the admin user.
* dbName: the name of the database to use. (comma separated)

This information will be rendered into the Acorn service object, that is interchangeable with the Acorn Redis container service.

It will require you to run:

```bash
acorn login [APP_NAME]
```

To prompt you for the information.

## Example using Redis Cloud service

Lets walk through deploying the example application using Redis cloud to provide the Redis DB.

First we need to create a Redis Cloud instance. To do this, you will need to sign in or create an account on [Redis Cloud](https://app.redislabs.com).

Once you have created an account, you will need to create a subscription and a database. You should select your subscription type and Region/Cloud vendor you want to deploy to. We will use the "Fixed plan" on AWS US-EAST-2 for this example.

Select the 30MB Free plan and provide a name for your subscription. Then click "Create Subscription".

Now enter a DB name, and select Redis Stack. Leave the supported protocols as is.

We will leave all other settings as is.

Copy the default user password and save it somewhere. We will need it later. Also, make note the username is "default".

Click "Activate Database". This will kick of the provisioning process in Redis Cloud.

Once the green check mark is next to you DB name, you can proceed to the next step.

## Deploying the example application

Now that we have the Redis Cloud instance created, we can deploy the example application.

Let's run the following command:

```bash
acorn run -n redis-example ghcr.io/acorn-io/redis-external/examples:v#.#.#
```

You should see the following output:

```bash
? Choose an existing credential or enter a new one Enter a new credential

  ## Overview                                                                 
                                                                              
  This will create the service from an existing Redis server.                 
                                                                              
  ## Instructions                                                             
                                                                              
  fill in:                                                                    
                                                                              
  • address: the address of the Redis server endpoint (redis.example.com)     
  • port: the port of the MongoDB server (6379)                               
  • adminPassword: the main password to use to connect to the Redis server as 
  an admin                                                                    
  • proto: the protocol to use to connect to the Redis server.                
  • dbName: the name of the database to use                                   


? address ****************************************************
? adminPassword ********************************
? adminUsername *******
? dbName ****
? port *****
? proto 
STATUS: ENDPOINTS[https://redis-example-9c5326f1.upyiuu.on-acorn.io] HEALTHY[0] UPTODATE[0] "acorn login redis-example" required
STATUS: ENDPOINTS[https://redis-example-9c5326f1.upyiuu.on-acorn.io] HEALTHY[0] UPTODATE[0] (container: app): waiting for service to be created [db], waiting for service to be ready [db]; (service: db): acorn [redis-example.db] is not ready
STATUS: ENDPOINTS[https://redis-example-9c5326f1.upyiuu.on-acorn.io] HEALTHY[0] UPTODATE[0] (container: app): waiting for service to be created [db], waiting for service to be ready [db], waiting for service to be created [db], waiting for service to be ready [db]; (service: db): acorn [redis-example.db] is not ready, acorn [redis-example.db] is not ready; type *unstructured.Unstructured not assignable to *v1.AppInstance
STATUS: ENDPOINTS[https://redis-example-9c5326f1.upyiuu.on-acorn.io] HEALTHY[0] UPTODATE[0] (container: app): waiting for service to be created [db], waiting for service to be ready [db]; (service: db): acorn [redis-example.db] is not ready; type *unstructured.Unstructured not assignable to *v1.AppInstance, [routes.go:92] type *unstructured.Unstructured not assignable to *v1.AppInstance
STATUS: ENDPOINTS[https://redis-example-9c5326f1.upyiuu.on-acorn.io] HEALTHY[0] UPTODATE[0] (container: app): waiting for service to be created [db], waiting for service to be ready [db]; (service: db): acorn [redis-example.db] is not ready
STATUS: ENDPOINTS[https://redis-example-9c5326f1.upyiuu.on-acorn.io] HEALTHY[0] UPTODATE[0] (container: app): waiting for service to be ready [db]; (service: db): acorn [redis-example.db] is not ready
STATUS: ENDPOINTS[https://redis-example-9c5326f1.upyiuu.on-acorn.io] HEALTHY[0] UPTODATE[0] (container: app): waiting for service to be ready [db]
....

┌────────────────────────────────────────────────────────────────────────────────────────────────┐
| STATUS: ENDPOINTS[https://redis-example-9c5326f1.upyiuu.on-acorn.io] HEALTHY[1] UPTODATE[1] OK |
└────────────────────────────────────────────────────────────────────────────────────────────────┘
```

Where Address is the Public Endpoint from the Redis Cloud DB information page, without the Port. Everything before the `:`.

The adminUsername is "default" and the adminPassword is the password you copied earlier.

The port is everything after the `:` in the Public Endpoint field.

The dbName is the name of the database you created in Redis Cloud.

Proto is not needed for this example.

### Cleaning up

To clean up the example application, run the following command:

```bash
acorn rm -af redis-example
```

You will also need to remove the `credential.acorn.io/redis` secret and admin username by running:

```bash
AME                     TYPE                                 KEYS                                                                        CREATED
acorn secret 
config-9swg4             credential.acorn.io/redis            [address adminPassword adminUsername dbName port proto]                     23m ago
redis-example.db.admin   basic                                [password username]                                                         5h30m ago
..
acorn secret rm config-9swg4
acorn secret rm redis-example.db.admin
```
