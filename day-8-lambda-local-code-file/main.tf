#creating an IAM role for Lambda execution
resource "aws_iam_role" "lambda_execution_role_tf" {
    name = "lambda_execution_role"
    assume_role_policy = jsonencode({
        Version = "2012-10-17",
        Statement = [
            {
                Action = "sts:AssumeRole",
                Effect = "Allow",
                Principal = {
                    Service = "lambda.amazonaws.com"
                }
            }
        ]
    })
}
#Attaching AWSLambdaBasicExecutionRole policy to the IAM role
resource "aws_iam_role_policy_attachment" "lambda_execution_role_attachment" {
    role = aws_iam_role.lambda_execution_role_tf.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

#Creating a Lambda function
resource "aws_lambda_function" "lambda_function" {
    function_name = "my_lambda_function-tf"
    description = "A Lambda function created using Terraform"
    runtime = "python3.12"
    architectures = ["x86_64"]
    role = aws_iam_role.lambda_execution_role_tf.arn
    memory_size = 128
    timeout = 300
    handler = "lambda_function.lambda_handler"
    filename = "lambda_function.zip"
    source_code_hash = filebase64sha256("lambda_function.zip")
}