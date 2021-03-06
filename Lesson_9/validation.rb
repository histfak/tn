module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :validations

    def validate(name, variant, opts = nil)
      @validations ||= []
      pattern = { name => { variant: variant, opts: opts } }
      @validations << pattern
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |pattern|
        pattern.each do |attribute, args|
          value = get_var(attribute)
          send(args[:variant], value, args[:opts])
        end
      end
    end

    def valid?
      validate!
      true
    rescue RuntimeError
      false
    end

    protected

    def get_var(name)
      var_name = "@#{name}"
      instance_variable_get(var_name)
    end

    def presence(value, _arg)
      raise 'Variable not found!' if value.nil?
    end

    def format(value, format)
      raise 'Wrong format!' if value !~ format
    end

    def type(value, class_name)
      raise 'Wrong class!' if class_name != value.class
    end
  end
end
