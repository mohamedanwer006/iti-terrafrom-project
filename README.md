# Project

### Networking
1. create vpc
2. create internet gateway
3. create public route table
4. create private route table
5. create public route
6. attach public route table to subnets


### Compute

7. create security group which allow ssh from 0.0.0.0/0
8. create security group that allow ssh and port 3000 from vpc cidr only
9. create ssh key for bastion and application ec2 save it in aws secret manager 
10.  create ec2(bastion) in public subnet with security group from 7
11. create ec2(application) private subnet with security group from 8

> notes ami is ubuntu
> save state file on s3 and lock on dynamodb

test ssh to bastion

![alt](./assets/test.png)