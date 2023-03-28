output "ec2_iam_role" {
    value = aws_iam_role.iam_role
  
}

output "ec2_iam_role_name" {
    value = aws_iam_role.iam_role.name 
  
}