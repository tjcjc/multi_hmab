module MultiHmab
  module Generators
    class InstallGenerator < Rails::Generators::NamedBase
      source_root File.expand_path("../templates", __FILE__)

      def generate_model_and_migration
        multi_end, single_end = singular_table_name.split("_")
        run("rails g model #{class_name} #{multi_end}:references #{single_end}:references relation_type:integer")
      end

      #def generate_model
        #multi_end, single_end = singular_table_name.split("_")
        #create_file "app/models/#{singular_table_name}.rb", <<-CONTENT
          #class #{class_name}
            #belongs_to :#{multi_end}
            #belongs_to :#{single_end}
          #end
        #CONTENT
      #end

      #def generate_migration
        #multi_end, single_end = singular_table_name.split("_")
        #migration_template 'migration.rb', "db/migrate/create_#{table_name}.rb", :multi_end => multi_end, :single_end => single_end
      #end
    end
  end
end
