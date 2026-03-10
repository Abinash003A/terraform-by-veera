output "prod_ec2" {
  value = {
    public_ip         = aws_instance.prod_ec2.public_ip
    private_ip        = aws_instance.prod_ec2.private_ip
    availability_zone = aws_instance.prod_ec2.availability_zone
  }
}
output "test_ec2" {
  value = {
    public_ip         = aws_instance.test_ec2.public_ip
    private_ip        = aws_instance.test_ec2.private_ip
    availability_zone = aws_instance.test_ec2.availability_zone
  }
}