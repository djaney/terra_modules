# Some terraform modules to make life easier

This are just some opinionated structure that I use in my projects.

Individual documentation is located inside each module.
Just look at the modules and inspect `variables.tf` and `outputs.tf` for input and output.

Generally resources are grouped into layers based on how often they change.

It's also useful when you need to populate data to a layer before you create the next. 
For example in ECS tasks, you can create the ECR first, push some images, then create the ECS. 
This way, your task will not be in a state where there are no valid images in the ECR.

## Layers
Each layer can be connected by Terragrunt using `dependency` block:

1. **Network** - Network related. Mostly resources that almost never changes.

   Example: VPC, NAT, ALB

2. **Storage** - Stateful resources.
   They also seldom change but more often than network layers, so they get their own layer.

   Example: S3, database, ECR

3. **Other** - any stateless resources.

## Documentation
[https://djaney.github.io/terra_modules/](https://djaney.github.io/terra_modules/)