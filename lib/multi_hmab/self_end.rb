module SelfEnd

  def self.included(base)
    base.extend         ClassMethods
    base.class_eval do
      
    end
    base.send :include, InstanceMethods
  end # self.included

  module ClassMethods
    def self_end(type = {})
      name = self.name.downcase
      self_table = name + "s"
      through = name + "_relation"
      join_table = through + "s"
      has_many join_table.to_sym, :foreign_key => "active_#{self.name.downcase}_id"

      type.each do |k, v|
        self.class_eval <<-END
          def #{k.underscore}ings
            #{name.camelize}.joins("inner join #{join_table} on #{self_table}.id = #{join_table}.passive_#{name}_id").where("#{join_table}.active_#{name}_id = ? and #{join_table}.relation_type = #{v}", self.id)
          end

          def #{k.underscore}ers
            #{name.camelize}.joins("inner join #{join_table} on #{self_table}.id = #{join_table}.active_#{name}_id").where("#{join_table}.passive_#{name}_id = ? and #{join_table}.relation_type = #{v}", self.id)
          end

          def #{k.underscore}ing?(passive)
            #{through.camelize}.where(:active_#{name}_id => self.id, :passive_#{name}_id => passive.id).present?
          end

          def #{k.underscore}ed?(active)
            #{through.camelize}.where(:active_#{name}_id => active.id, :passive_#{name}_id => self.id).present?
          end

          def #{k.underscore}(passive)
            #{through.camelize}.create(:active_#{name}_id => self.id, :passive_#{name}_id => passive.id, :relation_type => #{v})
          end

          def un#{k.underscore}(passive)
            item = #{through.camelize}.where(:active_#{name}_id => self.id, :passive_#{name}_id => passive.id, :relation_type => #{v}).first
            item.delete if item
          end
        END
      end
    end

  end # ClassMethods

  module InstanceMethods

  end # InstanceMethods

end
