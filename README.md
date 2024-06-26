# cloud-platform-terraform-flow-logs

[![Releases](https://img.shields.io/github/release/ministryofjustice/cloud-platform-terraform-flow-logs/all.svg?style=flat-square)](https://github.com/ministryofjustice/cloud-platform-terraform-flow-logs/releases)

This module enables us to use AWS Flow logs: network traffic logs at VPC, subnet and ENI levels.
## Usage

The module should be invoked in the cloud-platform-network folder.

```hcl
  module "flow_logs"{
      source= "github.com/ministryofjustice/cloud-platform-terraform-flow-logs?ref=1.2"
      
      #  is_enabled=true
      #  vpc_id="my-vpc" 
      #  OR subnet_id=
      #  OR eni_id=
      #  traffic_type="ALL"
  }
```
## Inputs


| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| is_enabled | | bool | false| no |
| vpc_id | VPC ID as the source of the flow log| string |  | no |
| subnet_id | Subnet ID as the source of the flow log| string |  | no |
| eni_id | ENI ID as the source of the flow log| string |  | no |
| traffic_type | Type of network traffic to be logged | `ACCEPT`/`REJECT`/`ALL` | `ALL`| no |


## Tags

Some of the inputs are tags. All infrastructure resources need to be tagged according to the [MOJ techincal guidance](https://ministryofjustice.github.io/technical-guidance/standards/documenting-infrastructure-owners/#documenting-owners-of-infrastructure). The tags are stored as variables that you will need to fill out as part of your module.

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| application |  | string | - | yes |
| business-unit | Area of the MOJ responsible for the service | string | `mojdigital` | yes |
| environment-name |  | string | - | yes |
| infrastructure-support | The team responsible for managing the infrastructure. Should be of the form team-email | string | - | yes |
| is-production |  | string | `false` | yes |
| team_name |  | string | - | yes |


## Outputs


| Name | Description |
|------|-------------|
| s3_bucket_arn | S3 bucket arn containing the flow_logs|
| s3_bucket_id | S3 bucket id containing the flow_logs|

## Reading Material

[TF documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/flow_log)
