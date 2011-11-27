require 'dashing/dash'

class Lister
  include Dash

  def get_erb_locals(data)
    Dash.validate_none_nil 'Lister', data, ['title', 'list']

    data['ordered'] ||= false

    { :title => data['title'], :ordered => data['ordered'], :list => data['list'] }
  end
end
