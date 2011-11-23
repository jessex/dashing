require 'dash'

class Lister
  include Dash

  def self.get_erb_locals(data)
    raise(Dash::DashConfigurationError, "Dash 'Lister' missing a title", caller) if data['title'].nil?
    raise(Dash::DashConfigurationError, "Dash 'Lister' missing list of items", caller) if data['list'].nil?

    data['ordered'] ||= false

    { :title => data['title'], :ordered => data['ordered'], :list => data['list'] }
  end
end
