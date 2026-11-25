# Food Zone: load resource IDs by their Name tags
$vpc    = aws ec2 describe-vpcs --filters "Name=tag:Name,Values=foodzone-vpc" --query "Vpcs[0].VpcId" --output text
$pubA   = aws ec2 describe-subnets --filters "Name=tag:Name,Values=foodzone-public-a"  --query "Subnets[0].SubnetId" --output text
$pubB   = aws ec2 describe-subnets --filters "Name=tag:Name,Values=foodzone-public-b"  --query "Subnets[0].SubnetId" --output text
$privA  = aws ec2 describe-subnets --filters "Name=tag:Name,Values=foodzone-private-a" --query "Subnets[0].SubnetId" --output text
$privB  = aws ec2 describe-subnets --filters "Name=tag:Name,Values=foodzone-private-b" --query "Subnets[0].SubnetId" --output text
$igw    = aws ec2 describe-internet-gateways --filters "Name=tag:Name,Values=foodzone-igw" --query "InternetGateways[0].InternetGatewayId" --output text
$rtPub  = aws ec2 describe-route-tables --filters "Name=tag:Name,Values=foodzone-public-rt"  --query "RouteTables[0].RouteTableId" --output text
$rtPriv = aws ec2 describe-route-tables --filters "Name=tag:Name,Values=foodzone-private-rt" --query "RouteTables[0].RouteTableId" --output text
$nat    = aws ec2 describe-nat-gateways --filter "Name=tag:Name,Values=foodzone-nat" "Name=state,Values=available" --query "NatGateways[0].NatGatewayId" --output text
$sgApp  = aws ec2 describe-security-groups --filters "Name=group-name,Values=foodzone-app-sg" --query "SecurityGroups[0].GroupId" --output text
$app    = aws ec2 describe-instances --filters "Name=tag:Name,Values=foodzone-app-private-a" "Name=instance-state-name,Values=running" --query "Reservations[0].Instances[0].InstanceId" --output text
"vpc=$vpc"; "pubA=$pubA pubB=$pubB"; "privA=$privA privB=$privB"; "igw=$igw rtPub=$rtPub rtPriv=$rtPriv"; "nat=$nat sgApp=$sgApp app=$app"