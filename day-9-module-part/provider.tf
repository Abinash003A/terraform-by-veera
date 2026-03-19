# provider "aws" {
  
# }
# we shouldnot define provider in module, we should define provider in root module.
# 2 providers can cause misconfiguration.
# Defining provider inside module breaks inheritance from root
#root provider should not be empty.(atleast region should be defined)