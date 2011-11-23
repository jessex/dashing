require 'YAML'

module Configuration
  CONFIG_FILE = 'data/config.yml'

  def Configuration.load_configuration
    YAML::load_file CONFIG_FILE
  end
end
