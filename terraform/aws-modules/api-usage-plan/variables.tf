variable "api_id" {
  description = "API Id of the associated API stage in a usage plan."
}
variable "usage_plan_name" {
  description = "The name of the usage plan."
}
variable "stage_name" {
  description = "API stage name of the associated API stage in a usage plan."
}
variable "quota_settings_limit" {
  description = "The maximum number of requests that can be made in a given time period."
  default     = 100
}
variable "quota_settings_offset" {
  description = "The number of requests subtracted from the given limit in the initial time period."
  default     = 0
}
variable "quota_settings_period" {
  description = "The time period in which the limit applies. Valid values are \"DAY\", \"WEEK\" or \"MONTH\"."
  default     = "DAY"
}
variable "throttle_settings_burst_limit" {
  description = "The API request burst limit, the maximum rate limit over a time ranging from one to a few seconds, depending upon whether the underlying token bucket is at its full capacity."
  default     = 200
}
variable "throttle_settings_rate_limit" {
  description = "The API request steady-state rate limit."
  default     = 100
}
variable "key_name" {
  description = "The name of a usage plan key."
}
variable "create_key" {
  description = "Flag to determine if we should create an api key."
  default     = true
}
variable "key_type" {
  description = "The type of the API key resource. Currently, the valid key type is API_KEY."
  default     = "API_KEY"
}
