from aws_cdk import (
    Stack,
    aws_ec2 as ec2,
    aws_elasticloadbalancingv2 as elbv2,
    aws_autoscaling as autoscaling,
)

from constructs import Construct

class AppScalableAlbStack(Stack):

    def __init__(self, scope: Construct, construct_id: str, **kwargs) -> None:
        super().__init__(scope, construct_id, **kwargs)

        # VPC with public subnets (2 AZs)
        vpc = ec2.Vpc(self, "VPC",
            max_azs=2,
            nat_gateways=0,
            subnet_configuration=[
                ec2.SubnetConfiguration(
                    name="Public",
                    subnet_type=ec2.SubnetType.PUBLIC,
                    cidr_mask=24
                )
            ]
        )

        # Security Group for ALB
        alb_sg = ec2.SecurityGroup(self, "ALBSG",
            vpc=vpc,
            description="Allow HTTP from internet",
            allow_all_outbound=True
        )
        alb_sg.add_ingress_rule(ec2.Peer.any_ipv4(), ec2.Port.tcp(80), "HTTP from internet")

        # Security Group for EC2
        ec2_sg = ec2.SecurityGroup(self, "EC2SG",
            vpc=vpc,
            description="Allow HTTP from ALB",
            allow_all_outbound=True
        )
        ec2_sg.add_ingress_rule(alb_sg, ec2.Port.tcp(80), "HTTP from ALB")

        # Launch Template
        lt = ec2.LaunchTemplate(self, "LaunchTemplate",
            machine_image=ec2.MachineImage.latest_amazon_linux2023(
                cpu_type=ec2.AmazonLinuxCpuType.ARM_64
            ),
            instance_type=ec2.InstanceType("t4g.micro"),
            security_group=ec2_sg,
            user_data=ec2.UserData.custom(
                """#!/bin/bash
                dnf update -y
                dnf install -y httpd php
                systemctl start httpd
                systemctl enable httpd
                echo "<h1>Hello from Scalable App (CDK)</h1>" > /var/www/html/index.html
                echo "OK" > /var/www/html/health
                """
            )
        )

        # Auto Scaling Group
        asg = autoscaling.AutoScalingGroup(self, "ASG",
            vpc=vpc,
            launch_template=lt,
            min_capacity=1,
            max_capacity=3,
            desired_capacity=1,
            vpc_subnets=ec2.SubnetSelection(subnet_type=ec2.SubnetType.PUBLIC)
        )

        # Application Load Balancer
        alb = elbv2.ApplicationLoadBalancer(self, "ALB",
            vpc=vpc,
            internet_facing=True,
            security_group=alb_sg
        )

        # Listener
        listener = alb.add_listener("Listener", port=80)
        listener.add_targets("Targets",
            port=80,
            targets=[asg]
        )

        # Output ALB DNS
        self.alb_dns = alb.load_balancer_dns_name