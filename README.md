# parlour-datamapper
A simple Parlour extension to generate types for DataMapper keys. (Associations 
are currently not supported.)

## Usage
Ensure you've required this gem and loaded the program code which defines your
DataMapper models in your `.parlour` file, then add the `ParlourDataMapper`
plugin to `plugins`. This plugin takes no configuration.

An example `.parlour`:

```yaml
output_file: out.rbi

requires:
  - parlour-datamapper

relative_requires:
  - src/main.rb # load models

plugins:
  ParlourDataMapper: {}
```