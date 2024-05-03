data "aws_ssm_parameter" "ami" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2023/recommended"
}

locals {
  ecs_image_ami_id = jsondecode(data.aws_ssm_parameter.ami.value).image_id
}