#!/usr/bin/env python3
import aws_cdk as cdk

from app_scalable_alb.app_scalable_alb_stack import AppScalableAlbStack

app = cdk.App()
AppScalableAlbStack(app, "AppScalableAlbStack")

app.synth()