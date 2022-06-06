module ApplicationHelper
  def humanized_duration(seconds)
    ActiveSupport::Duration.build(seconds).parts.except(:seconds).reduce("") do |output, (key, val)|
    output+= "#{val}#{key.to_s.first} "
    end.strip
  end
end
