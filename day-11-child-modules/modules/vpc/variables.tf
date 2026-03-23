#vpc module variables
variable "vpc" {
  type =object({
    cidr = string
    tags = map(string)
  })
}