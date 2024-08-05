########################################################################################################################
# Outputs
########################################################################################################################

output "isv_data" {
  value       = ibm_resource_instance.isv_instance
  description = "The result of isv creation"
}

output "oc_check" {
  value = data.external.which_oc.result
}

output "kubectl_check" {
  value = data.external.which_kubectl.result
}

output "cloudctl_check" {
  value = data.external.which_cloudctl.result
}

output "oc_plugins_list" {
  value = data.external.oc_plugins.result
}
