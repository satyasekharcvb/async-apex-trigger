# Asynchronous Apex Triggers

Asynchronous Apex Triggers are change event triggers which can process change event messages on the lightning platform. This code is for a demo use case which is used to identify high priority customers and update the Account based on the updated values of an associated Opportunity record in the Sales App. Opportunity object is enabled for Change Data Capture and the Apex trigger does the required post processing after the database operation is done on the Opportunity record.


## Installation Instructions
Steps to configure the org for demo:
1. Set up your environment. The steps include:

-   Enable Dev Hub in your Summer '19 org
-   Install Salesforce CLI
-   Install Visual Studio Code
-   Install the Visual Studio Code Salesforce extensions, including the Lightning Web Components extension

>**Note:** You can refer to the steps in the [Quick Start: Lightning Web Components](https://trailhead.salesforce.com/content/learn/projects/quick-start-lightning-web-components/) Trailhead project. 

2. If you haven't already done so, authenticate with your hub org and provide it with an alias (**myhuborg** in the command below):

```
sfdx force:auth:web:login -d -a myhuborg
```
>**Note:** Use **Summer '19 org** as your hub org.

3. Clone the async-apex-trigger repository:

```
git clone https://github.com/satyasekharcvb/async-apex-trigger.git
cd async-apex-trigger
```

4. Create a scratch org and provide it with an alias (**summer-demo** in the command below):

```
sfdx force:org:create -s -f config/project-scratch-def.json -a summer-demo
```
>**Note:** If you already have a default scratch org, you can use the existing scratch org for the demo. You can also use your Summer '19 org as default org.

5. Open the scratch org:
   
```
sfdx force:org:open 
```

6. Enable the Opportunity Object for Change Data Capture events
- In **Setup**, under **Integrations**, select **Change Data Capture**.
- From **Available Entities** component, select **Opportunity(Opportunity)**, move it to **Selected Entities** component and click **Save**.
  
7. Create a custom Picklist field named **_Customer Priority_** on the **Account** object. It should have three picklist values **_Low_**, **_Medium_** and **_High_**. Use first value(**_Low_**) as the default value. 

8. Open **Sales** App and create an Account named **_Astro_**. Fill as many fields possible.

9. Create an *Opportunity record* for **Astro** with the following values:
    - Amount: **_300000_**
    - Close Date: Any date of your choice
    - Stage: **_Needs Analysis_**
    - Account Name: **_Astro_**
    - Opportunity Name: **_Summer Deal_**


10. From the terminal, deploy the code to your org:

```
sfdx force:source:push
```
>**Note:** If you are using Summer '19 org instead of scratch org, use **_sfdx force:source:deploy_** instead of **_sfdx force:source:push_**
11.   You can reopen the scratch org using following command. If it is already open in the browser, you can refresh it.
    
```
sfdx force:org:open 
```
   