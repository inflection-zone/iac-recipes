import * as pulumi from "@pulumi/pulumi";
import * as aws from "@pulumi/aws";
import * as awsx from "@pulumi/awsx/classic";
import { region } from "@pulumi/aws/config";
import { count } from "console";

const vpc = aws.ec2.Vpc.get("aws-default-vpc", "vpc-02a8a14ab85726904");
//const subnetIds = aws.ec2.getSubnetIds({vpcId:"vpc-02a8a14ab85726904"})

const server1 = new aws.ec2.Instance("webserver1", {
    ami: "ami-0cca134ec43cf708f",
    associatePublicIpAddress: true,
    availabilityZone : "ap-south-1a",
    instanceType : "t2.micro",
    keyName: "webserver1",
    vpcSecurityGroupIds: ["sg-0cc3eaf1d359bfe91"],
    userData:`#!/bin/bash 
              sudo su - 
              yum install httpd -y 
              echo 'welcome to Pune'>/var/www/html/index.html 
              service httpd start 
              chkconfig httpd on`,
    tags: {
             name : "webserver-1"
            } 

})
const server2 = new aws.ec2.Instance("webserver2", {
    ami: "ami-0cca134ec43cf708f",
    associatePublicIpAddress: true,
    availabilityZone : "ap-south-1b",
    instanceType : "t2.micro",
    keyName: "webserver1",
    vpcSecurityGroupIds: ["sg-0cc3eaf1d359bfe91"],
    userData:`#!/bin/bash 
              sudo su - 
              yum install httpd -y 
              echo 'welcome to Mumbai'>/var/www/html/index.html 
              service httpd start 
              chkconfig httpd on`,
    tags: {
                name : "webserver-2"
            } 
})

const testTargetgroup = new aws.lb.TargetGroup("alb-tg",{
    targetType : "instance",
    vpcId : "vpc-02a8a14ab85726904",
    protocol : "HTTP",
    port: 80,
    healthCheck : {
        healthyThreshold : 2,
        interval : 10,
        matcher : "200",
        path : "/index.html",
        port : "traffic-port",
        protocol: "HTTP",
        timeout: 5,
        unhealthyThreshold: 2
    }
} )

const target1 = new aws.lb.TargetGroupAttachment("target1", {
    targetGroupArn : testTargetgroup.arn,
    targetId : server1.id
})

const target2 = new aws.lb.TargetGroupAttachment("target2", {
    targetGroupArn : testTargetgroup.arn,
    targetId : server2.id
})

const loadbalancer1 = new aws.lb.LoadBalancer("my-load-balancer", {
    internal : false,
    loadBalancerType: "application",
    name: "my-loadbalancer",
    securityGroups: ["sg-01a523fea5523b856"],
    subnets: ["subnet-0c71e1108a994ac38", "subnet-0045cc147b1543650", "subnet-0284d6538812c701d"],
    tags: {
        name: "my-loadbalancer"
    }
})

const listner1 = new aws.lb.Listener("target-group", {
    defaultActions: [{
        type: "forward",
        targetGroupArn: testTargetgroup.arn,
    }],
     loadBalancerArn: loadbalancer1.arn,
     port : 80,
     protocol : "HTTP"
})

const ipSet = new aws.wafv2.IpSet("my-ipset",{
    addresses: ["49.36.50.233/32"],
    ipAddressVersion: "IPV4",
    scope: "REGIONAL"
})

const ruleGroup1 =  new aws.wafv2.RuleGroup("rulegroup1", {
    capacity : 1,
    rules: [{
        action: {
            allow: {},
        },
        name: "rule-1",
        priority: 1,
        statement: {
            geoMatchStatement: {
                countryCodes: [
                    "IN",
                ],
            },
        },
        visibilityConfig: {
            cloudwatchMetricsEnabled: true,
            metricName: "rule-1-metric",
            sampledRequestsEnabled: true,
        },
    }],
    scope: "REGIONAL",
    visibilityConfig: {
        cloudwatchMetricsEnabled: true,
        metricName: "rule-group-metric",
        sampledRequestsEnabled: true,
    },
});


const webAcl1 = new aws.wafv2.WebAcl("wafAcl", {
    scope: "REGIONAL",
    visibilityConfig: {   
        cloudwatchMetricsEnabled: true,
        metricName: "web-acl-metric",
        sampledRequestsEnabled: true,
    },
    defaultAction: {
     allow : {}
    },
});

const webaclAssociation = new aws.wafv2.WebAclAssociation("awf-association", {
    resourceArn : loadbalancer1.arn,
    webAclArn: webAcl1.arn,
})
