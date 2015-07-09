﻿# Working with Cloudformation

## Set Up
Before you deploy with Cloudformation you need to set up your parameters.json file. There is an example copy called parameters.json-dist that you can copy and edit. It should look something like this:

```json
[
  {
    "ParameterKey": "ServiceName",
    "ParameterValue": "skel"
  }, 
  {
    "ParameterKey": "Environment",
    "ParameterValue": "sandbox"
  }, 
  {
    "ParameterKey": "SSHKeyName",
    "ParameterValue": "my_key"
  },
  {
    "ParameterKey": "TechnicalOwner",
    "ParameterValue": "my-email@domain.dom"
  },
  {
    "ParameterKey": "AmiId",
    "ParameterValue": "ami-abcdef123"
  }
]
``` 

### ServiceName
The ServiceName is the name of this service. For Mozilla deployments this should be the name of a real service as noted in [inventory](https://inventory.mozilla.org/en-US/core/service/)

### Environment
The environment is one of *sandbox*, *stage* or *prod*. For this (and all manual deployments) you will set this to *sandbox*.

### KeyName
This is the name of an existing ssh key that you have either created or uploaded to AWS.

### TechnicalOwner
The technical owner should be a valid email or distribution list which is monitored by the team responsible for maintaining this service.

### AmiId
You will collect this as output from nubis-builder. Once the build is complete nubis-builder will display the ami id which you will need to manually copy into the parameters.json file. You will need to do this after every successful build.

## Commands to work with CloudFormation
NOTE: All examples run from the top level project directory.

In these examples the stack is called *nubis-elk*. You will need to choose a unique name for your stack as there can only be one *nubis-elk* stack at a time.

### Create
To create a new stack:
```bash
bin/create.sh nubis-elk
```

### Update
To update and existing stack:
```bash
bin/update.sh nubis-elk
```

### Login
If you have only one EC2 instance and your ssh keys are on the jumphost, you can login by:
```bash
bin/ssh.sh nubis-elk
```

### Delete
To delete the stack:
```bash
bin/delete.sh nubis-elk
```

## Nested Stacks
We are using Cloudformation nested stacks to deploy the necessary resources. You can find the nested stack templates in the [nubis-stacks](https://github.com/Nubisproject/nubis-stacks) repository.
