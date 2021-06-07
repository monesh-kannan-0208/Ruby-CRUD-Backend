require 'pg'
require 'hanami/controller'

module CreateTable
    class CreateTable
        include ::Hanami::Action
        def call (env)
            begin
                con = PG.connect :host => 'ec2-35-169-188-58.compute-1.amazonaws.com', :dbname => 'denfue801hlg5v', :user => 'kfdmxxbwfsbhyb', :password => '62522c639856cf962740a1287c6116bc74f09f60d59f9014d7c1603bfc0c8039'
                exist = "SELECT EXISTS (SELECT FROM information_schema.tables WHERE table_schema='public' AND table_name='Emp')"
                if exist[0]["exists"]=="f"
                    con.exec "CREATE TABLE Emp(Name VARCHAR(20), Email VARCHAR(30) PRIMARY KEY, Password VARCHAR(20), EmpCode VARCHAR(20), Address VARCHAR(50), JoiningDate  VARCHAR(20))"
                    puts "Table Created"
                else
                    puts "Table Exist"
                end
                rescue PG::Error => e
            
                    puts e.message 
                    
                ensure
                
                    con.close if con
                    
            end
        end
    end
end