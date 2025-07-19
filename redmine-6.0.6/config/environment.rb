# frozen_string_literal: true

# Load the Rails application
require File.expand_path('../application', __FILE__)

# Make sure there's no plugin in vendor/plugin before starting
vendor_plugins_dir = File.join(Rails.root, "vendor", "plugins")
if Dir.glob(File.join(vendor_plugins_dir, "*")).any?
  $stderr.puts "Plugins in vendor/plugins (#{vendor_plugins_dir}) are no longer allowed. " \
    "Please, put your Redmine plugins in the `plugins` directory at the root of your " \
    "Redmine directory (#{File.join(Rails.root, "plugins")})"
  exit 1
end

# Initialize the Rails application
require 'yaml'
secrets_path = File.expand_path('../secrets.yml', __FILE__)
if File.exist?(secrets_path)
  secrets = YAML.load_file(secrets_path)
  ENV['SECRET_KEY_BASE'] ||= secrets['production']['secret_key_base']
end
Rails.application.initialize!
