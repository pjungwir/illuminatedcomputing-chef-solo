

package "python-software-properties"

bash "add-postgres-repo" do
  user 'root'
  code <<-EOH
    add-apt-repository ppa:pitti/postgresql && apt-get update
  EOH
end

package 'postgresql-9.0'
package 'postgresql-client-9.0'

# template '/etc/postgresql/9.0/main/pg_hba.conf' do
# end

# template '/etc/postgresql/9.0/main/postgresql.conf' do
# end



