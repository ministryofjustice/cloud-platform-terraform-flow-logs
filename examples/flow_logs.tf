
module "flow_logs"{
      source= "github.com/ministryofjustice/cloud-platform-terraform-flow-logs?ref=1.2"
      # vpc_id="my-vpc" 
      #  OR subnet_id=
      #  OR eni_id=
      # traffic_type="ALL"
  }