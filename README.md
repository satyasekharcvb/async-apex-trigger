# Asynchronous Apex Triggers

Asynchronous Apex Triggers are change event triggers which can process change event messages on the lightning platform. This code is for a demo use case which is used to identify high priority customers and update the Account based on the updated values of an associated Opportunity record in the Sales App. Opportunity object is enabled for Change Data Capture and the Apex trigger does the required post processing after the database operation is done on the Opportunity record.

## Installation instructions for scratch orgs

1. If you haven't already done so, authenticate with your hub org and provide it with an alias (**myhuborg** in the command below):

```
sfdx force:auth:web:login -d -a myhuborg
```

2. Clone the async-apex-trigger repository:

```
git clone https://github.com/satyasekharcvb/async-apex-trigger.git
cd async-apex-trigger
```

3. Create a scratch org and provide it with an alias (**summer-demo** in the command below):

```
sfdx force:org:create -s -f config/project-scratch-def.json -a summer-demo
```

4. Deploy the source.

```
sfdx force:source:push
```

5. Open the scratch org:

```
sfdx force:org:open
```

6. You can reopen the scratch org using following command. If it is already open in the browser, you can refresh it.

```
sfdx force:org:open
```

## Installation instructions for non-scratch orgs

1. If you haven't already done so, authenticate with your org and provide it with an alias (**mydevorg** in the command below):

```
sfdx force:auth:web:login -a mydevorg
```

2. Clone the async-apex-trigger repository:

```
git clone https://github.com/satyasekharcvb/async-apex-trigger.git
cd async-apex-trigger
```

3. Deploy the source.

```
sfdx force:source:deploy - force-app
```

4. Open the org.

```
sfdx force:org:open
```
