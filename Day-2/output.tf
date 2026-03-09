output "bastion_ec2_1_details" {
  value = {
    public_ip         = aws_instance.bastion_ec2_1.public_ip
    private_ip        = aws_instance.bastion_ec2_1.private_ip
    availability_zone = aws_instance.bastion_ec2_1.availability_zone
  }
}
output "bastion_ec2_2_details" {
  value = {
    public_ip         = aws_instance.bastion_ec2_2.public_ip
    private_ip        = aws_instance.bastion_ec2_2.private_ip
    availability_zone = aws_instance.bastion_ec2_2.availability_zone
  }
}