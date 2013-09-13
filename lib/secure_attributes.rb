module SecureAttributes
  extend ActiveSupport::Concern
  module ClassMethods
    def secure_attributes(*attrs)
      attributes = attrs.collect{|atr| atr.to_sym}
      column_names = self.column_names.collect{|column_name| column_name.to_sym }
      @@whitelist_attributes = default_whitelist - attributes
    end
    
    def default_whitelist
      a = self.column_names
      nested_attributes = {}
      attrs = self.reflect_on_all_associations(:has_many).map(&:name)
      attrs.each do |attr|
        nested_attributes["#{attr}_attributes"] = attr.to_s.classify.constantize.column_names
      end
      a << nested_attributes
    end
    
    def whitelist_attributes
      @@whitelist_attributes ||= default_whitelist
    end
  end
end