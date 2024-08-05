########################################################################################################################
# Resource Group
########################################################################################################################

module "resource_group" {
  source  = "terraform-ibm-modules/resource-group/ibm"
  version = "1.1.5"
  # if an existing resource group is not set (null) create a new one using prefix
  resource_group_name          = var.resource_group == null ? "${var.prefix}-resource-group" : null
  existing_resource_group_name = var.resource_group
}

resource "ibm_resource_instance" "isv_instance" {
  name              = "${var.prefix}-isv"
  service           = "security-verify"
  plan              = "verify-lite"
  location          = var.region
  resource_group_id = module.resource_group.resource_group_id

  parameters = {
    hostname : "myisvtenant"
  }

  timeouts {
    create = "60m"
    update = "60m"
    delete = "60m"
  }

}

data "external" "which_oc" {
  program = ["bash", "${path.module}/external_which_check.sh"]

  query = {
    # arbitrary map from strings to strings, passed
    # to the external program as the data query.
    the_prog = "oc"
  }
}

data "external" "which_kubectl" {
  program = ["bash", "${path.module}/external_which_check.sh"]

  query = {
    # arbitrary map from strings to strings, passed
    # to the external program as the data query.
    the_prog = "kubectl"
  }
}

data "external" "which_cloudctl" {
  program = ["bash", "${path.module}/external_which_check.sh"]

  query = {
    # arbitrary map from strings to strings, passed
    # to the external program as the data query.
    the_prog = "cloudctl"
  }
}

data "external" "oc_plugins" {
  program = ["bash", "${path.module}/check_oc_plugins.sh"]
}
