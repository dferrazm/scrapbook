module Requests
  module JsonHelpers
    %w(get post put delete).each do |method|
      define_method("json_#{method}") do |*args|
        send(method, *args)
        JSON.parse(response.body)
      end
    end
  end
end
