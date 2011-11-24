require 'dash'

class Lister
  include Dash

  def self.get_erb_locals(data)
    Dash.validate_none_null 'Lister', data, ['title', 'ordered']

    data['ordered'] ||= false

    { :title => data['title'], :ordered => data['ordered'], :list => data['list'] }
  end
end
