# Monkey patch FormHelper
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
        options.merge!("date-picker" => true)

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

      def hour_field(object_name, method, options = {})
        instance_tag = InstanceTag.new(object_name, method, self, options.delete(:object))

        # Let InstanceTag do the object/attribute lookup for us
        value = instance_tag.value(instance_tag.object)

        # value is empty when re-showing field after error, use params
        options["value"] =  value.to_s(:text_field) if (value.is_a?(Time) or value.is_a?(DateTime))
        options["value"] ||= params[object_name][method] if params[object_name]
        options.merge!('data-check-hours' => true)
        options.merge!('alt' => 'time')
        options.merge!('class' => 'hasCheckHours')

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

      def hour_field(method, options = {})
        @template.hour_field(@object_name, method, objectify_options(options))
      end
    end
  end
end

# Monkey patch formtastic
class Formtastic::SemanticFormBuilder
  # Outputs a label and standard Rails text field inside the wrapper.
  def date_field_input(method, options)
    basic_input_helper(:date_field, :string, method, options)
  end

  def time_field_input(method, options)
    basic_input_helper(:time_field, :string, method, options)
  end
  
  def hour_field_input(method, options)
    basic_input_helper(:hour_field, :string, method, options)
  end  

  # Add :validates_date to requiring validations
  def method_required?(attribute)
    if @object && @object.class.respond_to?(:validators_on)
      attribute_sym = attribute.to_s.sub(/_id$/, '').to_sym
      !@object.class.validators_on(attribute_sym).find{|validator|
        ((validator.kind == :presence) && (validator.options.present? ? options_require_validation?(validator.options) : true)) ||
        ((validator.kind == :timeliness) && !(validator.instance_variable_get('@allow_nil') || validator.instance_variable_get('@allow_blank')))
      }.nil?
    else
      self.class.all_fields_required_by_default
    end
  end
end
