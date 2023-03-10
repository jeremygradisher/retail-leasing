require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DeviseSandbox
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    
    config.active_job.queue_adapter = :delayed_job
    #config.active_job.queue_adapter = :sidekiq

    # Do not swallow errors in after_commit/after_rollback callbacks.
    #config.active_record.raise_in_transactional_callbacks = true
    
    config.hosts << "e841612c53ff48c295eb161fa22da606.vfs.cloud9.us-east-1.amazonaws.com"
    
    # Enable the asset pipeline
    #really not sure that this is necessarry
    config.assets.enabled = true
    config.assets.paths << Rails.root.join('/app/assets/fonts')
  end
end
