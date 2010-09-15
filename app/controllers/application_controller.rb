class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'
end

module ActionView
  module Helpers
    module FormHelper
      def date_field(object_name, method, options = {})
        instance_tag = InstanceTag.new(object_name, method, self, options.delete(:object))

        # Let InstanceTag do the object/attribute lookup for us
        value = instance_tag.value(instance_tag.object)

        # value is empty when re-showing field after error, use params  
        options["value"] =  value.to_s(:text_field) if value.is_a?(Date)
        options["value"] ||= params[object_name][method] if params[object_name]

        instance_tag.to_input_field_tag("text", options)
      end

      def time_field(object_name, method, options = {})
        instance_tag = InstanceTag.new(object_name, method, self, options.delete(:object))

        # Let InstanceTag do the object/attribute lookup for us
        value = instance_tag.value(instance_tag.object)

        # value is empty when re-showing field after error, use params
        options["value"] =  value.to_s(:text_field) if (value.is_a?(Time) or value.is_a?(DateTime))
        options["value"] ||= params[object_name][method] if params[object_name]

        instance_tag.to_input_field_tag("text", options)
      end
    end

    class FormBuilder
      def date_field(method, options = {})
        @template.date_field(@object_name, method, objectify_options(options))
      end

      def time_field(method, options = {})
        @template.time_field(@object_name, method, objectify_options(options))
      end
    end
  end
end

# Monkay patch formtastic
class Formtastic::SemanticFormBuilder
  # Outputs a label and standard Rails text field inside the wrapper.
  def date_field_input(method, options)
    basic_input_helper(:date_field, :string, method, options)
  end

  def time_field_input(method, options)
    basic_input_helper(:time_field, :string, method, options)
  end

  # Add :validates_date to requiring validations
  def method_required?(attribute)
    if @object && @object.class.respond_to?(:reflect_on_validations_for)
      attribute_sym = attribute.to_s.sub(/_id$/, '').to_sym

      @object.class.reflect_on_validations_for(attribute_sym).any? do |validation|
        [:validates_presence_of, :validates_date, :validates_time].include?(validation.macro) &&
        validation.name == attribute_sym && !(validation.options.present? && (validation.options[:allow_nil] || validation.options[:allow_blank])) &&
        (validation.options.present? ? options_require_validation?(validation.options) : true)
      end
    else
      if @object && @object.class.respond_to?(:validators_on)
        attribute_sym = attribute.to_s.sub(/_id$/, '').to_sym
        !@object.class.validators_on(attribute_sym).find{|validator| (validator.kind == :presence) && (validator.options.present? ? options_require_validation?(validator.options) : true)}.nil?
      else
        self.class.all_fields_required_by_default
      end
    end
  end
end
