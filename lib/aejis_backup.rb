require "rubygems"

module AejisBackup

  # def config_setter(*names)
  #   names.each do |name|
  #     instance_eval %{
  #       def #{name}(#{name}=nil)
  #         #{name} ? (@#{name} = #{name}) : @#{name}
  #       end
  #       alias :#{name}= :#{name}
  #     }
  #   end
  # end

end

require "aejis_backup/configuration"