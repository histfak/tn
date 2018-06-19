module Accessors
  def attr_accessor_with_history(*args)
    args.each do |name|
      define_method(name) { instance_variable_get("@#{name}".to_sym) }
      define_method("#{name}_history".to_sym) { instance_variable_get("@#{name}_history".to_sym) }
      define_method("#{name}=".to_sym) do |value|
        history = (instance_variable_get("@#{name}_history") || [])
        instance_variable_set("@#{name}_history".to_sym, \
                              history << instance_variable_get("@#{name}".to_sym))
        instance_variable_set("@#{name}".to_sym, value)
      end
    end
  end

  def strong_attr_accessor(name, class_name)
    define_method(name) { instance_variable_get("@#{name}".to_sym) }
    define_method("#{name}=".to_sym) do |value|
      raise 'Wrong class!' if class_name != value.class
      instance_variable_set("@#{name}".to_sym, value)
    end
  end
end
