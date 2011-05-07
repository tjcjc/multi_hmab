module MultiEnd

  def self.included(base)
    base.extend         ClassMethods
    base.class_eval do
          
    end
    base.send :include, InstanceMethods
  end # self.included

  module ClassMethods
    def multi_end(through = "", type = [])
      join_table = (through + "s").to_sym
      mul, single = through.split("_")
      has_many join_table
      self.class_eval <<-END
        def relate_#{single}(type)
          #{single.camelize}.joins(#{join_table}).where("#{join_table}.#{mul}_id = ? and #{join_table}.relation_type = ?", self.id, type)
        end
      END

      type.each do |k, v|
        self.class_eval <<-END
          def #{k.underscore}_#{single}s
            relate_#{single}s(#{v})
          end

          def #{k.underscore.gsub("ing", "")}_#{single}(#{single})
            #{through.camelize}.create(:#{mul}_id => self.id, :#{single}_id => #{single}.id, :relation_type => #{v})
          end

          def un#{k.underscore.gsub("ing", "")}_#{single}(#{single})
            item = #{through.camelize}.where(:#{mul}_id => self.id, :#{single}_id => #{single}.id, :relation_type => #{v}).first
            item.delete if item
          end
        END
      end
    end
  end # ClassMethods

  module InstanceMethods

  end # InstanceMethods

end
