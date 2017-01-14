module ActiveRecord::Userstamp::MigrationHelper
  extend ActiveSupport::Concern

  def userstamps(*args)
    config = ActiveRecord::Userstamp.config
    foreign_key(config.default_stamper_class.table_name, { column: config.creator_attribute }.with_indifferent_access.merge!(args.extract_options!))
    foreign_key(config.default_stamper_class.table_name, { column: config.updater_attribute }.with_indifferent_access.merge!(args.extract_options!))
    foreign_key(config.default_stamper_class.table_name, { column: config.deleter_attribute }.with_indifferent_access.merge!(args.extract_options!)) if config.deleter_attribute.present?
   end
end

ActiveRecord::ConnectionAdapters::TableDefinition.class_eval do
  include ActiveRecord::Userstamp::MigrationHelper
end
