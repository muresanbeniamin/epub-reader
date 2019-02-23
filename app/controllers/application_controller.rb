class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  private

  def json_api_params(*attrs, polymorphic: [])
    attrs += polymorphic.map { |relationship| ["#{relationship}_id".to_sym, "#{relationship}_type".to_sym] }.flatten

    parsed = jsonapi_parse(polymorphic).slice(*attrs)
    capitalize_polymorphic_type(parsed, polymorphic)

    parsed
  end

  def jsonapi_parse(polymorphic)
    # specifying the :only option does not work with relations
    ActiveModelSerializers::Deserialization.jsonapi_parse(params, polymorphic: polymorphic, key_transform: :unaltered)
  end

  # arguably, this should be part of AMS
  def capitalize_polymorphic_type(parsed, polymorphic)
    polymorphic.each do |relationship|
      relationship_attribute = "#{relationship}_type".to_sym
      parsed[relationship_attribute] = parsed[relationship_attribute]&.singularize&.capitalize
    end
  end

  # TODO: we need to refactor the result, page and component updates and get rid of this
  def deserialize_relationship(field, local_params = params, polymorphic: [], children: {})
    field_params = local_params[:data][field] or return
    child_class = field.to_s.singularize.classify.constantize

    return parse_object(child_class, field_params, polymorphic, children) unless field_params.is_a?(Array)

    field_params.map do |field_param|
      parse_object(child_class, field_param, polymorphic, children)
    end
  end

  def parse_object(child_class, field_param, polymorphic, children)
    parsed = deserialize_object(field_param, polymorphic, children)

    child = child_class.find_or_initialize_by(id: parsed[:id])
    child.assign_attributes(parsed)
    child
  end

  def deserialize_object(field_param, polymorphic, children)
    parsed = ActiveModelSerializers::Deserialization.jsonapi_parse(field_param, polymorphic: polymorphic)

    capitalize_polymorphic_type(parsed, polymorphic)

    children.each do |key, value|
      parsed[key] = deserialize_relationship(key, field_param, polymorphic: value || [])
    end

    parsed
  end
end
