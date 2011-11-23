module Dash
  class DashConfigurationError < ArgumentError
  end

  def Dash.validate_none_null(dash_name, data, *fields)
    fields.each do |field|
      raise(DashConfigurationError, "Dash '#{dash_name}' missing field #{field}", caller) if data[field].nil?
    end
  end
end
