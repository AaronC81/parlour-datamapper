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
        p klass.properties
      end
    end
  end
end