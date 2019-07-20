require 'parlour'
require 'data_mapper'

class ParlourDataMapper < Parlour::Plugin
  VERSION = '0.1.0'

  def generate(root)
    # Get all resources
    resources = ObjectSpace.each_object(Class).select do |x|
      x.included_modules.include?(DataMapper::Resource)
    end

    # Generate namespaces for each
    resources.each do |resource|
      root.path(resource) do |klass|
        # Iterate over each object property for this resource
        resource.properties.each do |prop|
          type_string = PROPERTIES_TO_TYPES[prop.class]

          # Define the getter
          klass.create_method(
            name: prop.name.to_s,
            returns: type_string
          )

          # Define the setter
          klass.create_method(
            name: "#{prop.name}=",
            parameters: [
              Parlour::RbiGenerator::Parameter.new(
                name: 'value',
                type: type_string
              )
            ],
            returns: type_string
          )
        end
      end
    end
  end

  PROPERTIES_TO_TYPES = {
    DataMapper::Property::String => 'String',
    DataMapper::Property::Text => 'String',
    DataMapper::Property::Integer => 'Integer',
    DataMapper::Property::Decimal => 'Float',
    DataMapper::Property::Float => 'Float',
    DataMapper::Property::Numeric => 'Numeric',
    DataMapper::Property::Boolean => 'T::Boolean',
    DataMapper::Property::Date => 'Date',
    DataMapper::Property::DateTime => 'DateTime',
    DataMapper::Property::Time => 'Time',
    DataMapper::Property::Serial => 'Integer'
  }
end