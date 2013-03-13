# This rake file send email to offerers.
# They can be executed as follows:

desc "Tasks related to Guest User"
namespace :ledgers do
# rake Send email to offerers.
  task :set_values => [:environment] do
  	ActiveRecord::Base.connection.execute("UPDATE retailer_ledgers SET value = 1 order by RAND() limit 2000")
  	ActiveRecord::Base.connection.execute("UPDATE retailer_ledgers SET value = 2 order by RAND() limit 2000")
  	ActiveRecord::Base.connection.execute("UPDATE retailer_ledgers SET value = 3 order by RAND() limit 2000")
  end
end