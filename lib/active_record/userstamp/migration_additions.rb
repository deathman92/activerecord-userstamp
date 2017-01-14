module ActiveRecord::Userstamp::MigrationHelper
  extend ActiveSupport::Concern

  def userstamps(*args)
    config = ActiveRecord::Userstamp.config
    foreign_key(config.default_stamper_class.table_name, *(args << { column: config.creator_attribute }))
    foreign_key(config.default_stamper_class.table_name, *(args << { column: config.updater_attribute }))
    foreign_key(config.default_stamper_class.table_name, *(args << { column: config.deleter_attribute })) if config.deleter_attribute.present?
   end
end

ActiveRecord::ConnectionAdapters::TableDefinition.class_eval do
  include ActiveRecord::Userstamp::MigrationHelper
end
