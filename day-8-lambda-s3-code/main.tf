    # #create lambda basic execution role policy
    # resource "aws_iam_policy" "lambda_basic_execution" {
    # name = "lambda_basic_execution"
    # policy = jsonencode(
    #     {
    # "Version": "2012-10-17",
    # "Statement": [
    #     {
    #         "Effect": "Allow",
    #         "Action": [
    #             "logs:CreateLogGroup",
    #             "logs:CreateLogStream",
    #             "logs:PutLogEvents"
    #         ],
    #         "Resource": "*"
    #     }
    # ]
    # })

    # }
    
# #create a policy for lambda function to access s3 bucket
#  resource "aws_iam_policy" "lambda_policy" {
#     name = "lambda_policy"
#     policy = jsonencode({
#         Version = "2012-10-17"
#         Statement = [
#         {
#             Action = [
#             "s3:GetObject",
#             "s3:PutObject",
#             "s3:ListBucket"
#             ]
#             Effect = "Allow"
#             Resource = "${aws_s3_bucket.bucket.arn}/*"
#         }
#         ]
#     })
#     }
 
  #create an IAM role for lambda function
    resource "aws_iam_role" "lambda_role" {
    name = "lambda_role"
    description = "Allows Lambda functions to call AWS services on your behalf."
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
        {
            Action = "sts:AssumeRole"
            Effect = "Allow"
            Principal = {
            Service = "lambda.amazonaws.com"
            }
        }
        ]
    })
    tags = {
        Name = "lambda_role"
    }
    }

    #attach the policies to the IAM role
    resource "aws_iam_role_policy_attachment" "lambda_roles" {
    role = aws_iam_role.lambda_role.name
    for_each = toset( ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole",
    "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"])
    policy_arn = each.value
    }

#create a s3 bucket to store lambda code
 resource "aws_s3_bucket" "bucket" {
  bucket = "veera-lambda-s3-code"
 }
 #Enable versioning for the s3 bucket
 resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}
#create a lambda function
resource "aws_lambda_function" "lambda_function" {
    function_name = "lambda_function_test"
    description = "A Lambda function created using Terraform"
    runtime = "python3.12" 
    architectures = ["x86_64"]
    role = aws_iam_role.lambda_role.arn
    memory_size = 128
    ephemeral_storage {
      size = 512
    }
    timeout = 900
    handler = "lambda_function.lambda_handler"
    depends_on = [aws_s3_object.lambda_zip]
    s3_bucket = aws_s3_bucket.bucket.bucket
    s3_key = aws_s3_object.lambda_zip.key
    source_code_hash = filebase64sha256("lambda_function.zip")
}
resource "aws_s3_object" "lambda_zip" {
  bucket = aws_s3_bucket.bucket.id
  key    = "lambda_function.zip"
  source = "lambda_function.zip"

  etag = filemd5("lambda_function.zip")
}
# Creates an EventBridge rule that filters S3 Object Created events 
# (only for .zip files in the specified bucket)
resource "aws_cloudwatch_event_rule" "s3_object_feed" {
  name = "s3_object_feed"
  description = "Trigger Lambda function on every object creation in the S3 bucket"
 event_pattern = jsonencode({
  source = ["aws.s3"],
  "detail-type" = ["Object Created"],
  detail = {
    bucket = {
      name = [aws_s3_bucket.bucket.bucket]
    },
    object = {
      key = [{
        suffix = ".zip"
      }]
    }
  }
})
}
# Attaches the Lambda function as a target to the EventBridge rule
# (defines what action to take when the rule matches an event)
resource "aws_cloudwatch_event_target" "lambda_target" {
  rule = aws_cloudwatch_event_rule.s3_object_feed.name
  target_id = "lambda_target"
  arn = aws_lambda_function.lambda_function.arn
}
# Grants permission to EventBridge to invoke the Lambda function
# (resource-based policy on Lambda allowing events.amazonaws.com)
resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id = "AllowExecutionFromEventBridge"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_function.function_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.s3_object_feed.arn
}

# Enables S3 to send all events to EventBridge
# (required for EventBridge rules to receive S3 event notifications)
resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.bucket.id

  eventbridge = true
}