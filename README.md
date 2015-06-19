### nubis-elk

#### Howto build

1. Run packer-build.sh
    ```bash
    $ ./bin/packer-build.sh
    ```

2. Build stack with ami that you get from the packer build
    ```bash
    $ ./bin/build.sh nubis-elk
    ```

3. Wait for build to complete and then update consul
    ```bash
    $ export PATH="~/nubis/nubis-builder/bin:$PATH"
    $ nubis-consul --stack-name nubis-elk --settings nubis/cloudformation/parameters.json get-and-update
    ```
#### Notes

* Stack information
    ```bash
    $ aws cloudformation describe-stacks --stack-name nubis-elk
    ```

* Get ec2 instance private IP
    ```bash
    $ aws ec2 describe-instances --filter "Name=tag:ServiceName,Values=nubis-elk" | jq ".Reservations|.[].Instances|.[].PrivateIpAddress" -r
    ```

* Get stack build information
    ```bash
    STACK_NAME="nubis-elk"; watch -n 1 "echo 'Container Stack'; aws cloudformation describe-stacks --query 'Stacks[*].[StackName,StackStatus]' --output text --stack-name $STACK_NAME; echo \"\nNested Stacks\"; aws cloudformation describe-stack-resources --stack-name $STACK_NAME --query 'StackResources[*].[LogicalResourceId, ResourceStatus]' --output text"
    ```
