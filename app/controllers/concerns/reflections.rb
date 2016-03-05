module Reflections
  def model_name
    @model_name ||= controller_name.classify
  end

  def model_class
    @model_class ||= model_name.constantize
  end

  def model_name_low_singular
    @model_name_low_singular ||= model_name.downcase.singularize
  end

  def model_name_low_plural
    @model_name_low_plural ||= model_name.downcase.pluralize
  end
end
