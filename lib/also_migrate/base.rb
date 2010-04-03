module AlsoMigrate
  module Base
    
    def self.included(base)
      unless base.respond_to?(:also_migrate)
        base.extend ClassMethods
      end
    end
    
    module ClassMethods
      
      def also_migrate(*args)
        options = args.extract_options!
        @also_migrate_config ||= []
        @also_migrate_config << {
          :tables => args.collect(&:to_s),
          :options => {
            :ignore => [ options[:ignore] ].flatten.compact,
            :indexes => options[:indexes] ? [ options[:indexes] ].flatten : nil
          }
        }
        self.class_eval do
          class <<self
            attr_accessor :also_migrate_config
          end
        end
      end
    end
  end
end