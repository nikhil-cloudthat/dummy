

# create tgw in AWS Shared Account 
resource "aws_ec2_transit_gateway" "asista-tgw" {
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"
  vpn_ecmp_support                = "enable"
  dns_support                     = "enable"
  tags = {
    "Name"            = "asista-tgw"
    "Environment"     = var.env
    "Stoppable"       = "False"
    "Restart"         = "False"
  }
}

## Attachement of VPC from AWS shared services account Account
resource "aws_ec2_transit_gateway_vpc_attachment" "asista-vpc-attachment-shared" {
  vpc_id             = var.vpc_id
  subnet_ids         = var.subnet_ids
  transit_gateway_id = aws_ec2_transit_gateway.asista-tgw.id

  appliance_mode_support = "enable"
  dns_support            = "enable" 
  tags = {
    "Name"          = "asista-tgw-attachment"
    Environment     = var.env
  }
}



# *************** TGW FLOW LOGS *************************

# STARTING VPC and TGW FLOW LOGS

resource "aws_flow_log" "asista_tgw_flow_logs" {
  log_destination          = "arn:aws:s3:::shared-asista-tgw-flow-logs"
  log_destination_type     = "s3"
  traffic_type             = "ALL"
  transit_gateway_id       = aws_ec2_transit_gateway.asista-tgw.id
  max_aggregation_interval = 60

  tags = {
    "Name"            = "asista-tgw-flow-logs"
    "Environment"     = var.env
  }
}



# ENDING VPC FLOW LOGS


