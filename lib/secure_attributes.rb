module SecureAttributes
  extend ActiveSupport::Concern
  module ClassMethods
    def secure_attributes(*attrs)
      attributes = attrs.collect{|atr| atr.to_sym}
      column_names = self.column_names.collect{|column_name| column_name.to_sym }
      @@whitelist_attributes = self.column_names - attributes
    end
    def whitelist_attributes
      @@whitelist_attributes ||= self.column_names
    end
  end
end