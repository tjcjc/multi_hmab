module SingleEnd

  def self.included(base)
    base.extend         ClassMethods
    base.class_eval do
        
    end
    base.send :include, InstanceMethods
  end # self.included

  module ClassMethods
    def single_end(through = "", type =[])
      join_table = through + "s"
      mul, single = through.split("_")
      has_many join_table.to_sym
      self.class_eval <<-END
        def relate_#{mul}s(type)
          #{mul.camelize}.joins(:#{join_table}).where("#{join_table}.#{single}_id = ? and #{join_table}.relation_type = ?", self.id, type)
        end
      END

      type.each do |k, v|
        self.class_eval <<-END
          def #{k.underscore}_#{mul}s
            relate_#{mul}s(#{v})
          end
        END
      end
      
    end
  end # ClassMethods

  module InstanceMethods

  end # InstanceMethods

end
