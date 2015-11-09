# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

#Instagram client ID
ENV["client_id"] = "206d66c30526438c944aa8fc88154913"
#MAx num of requests by scheduler
ENV["max_tag_requests"] = "10"

