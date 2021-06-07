require 'pg'
require 'hanami/controller'
require 'json'

module AddEmp
    class AddEmp
        include ::Hanami::Action
        def call (env)
            response = request.body.read
            signupDetails = JSON.parse(response)
            name = signupDetails['signupDetails']['name']
            email = signupDetails['signupDetails']['email']
            password = signupDetails['signupDetails']['password']
            empcode = signupDetails['signupDetails']['empcode']
            address = signupDetails['signupDetails']['address']
            joiningdate = signupDetails['signupDetails']['joiningdate']
            begin
                con = PG.connect :host => 'ec2-35-169-188-58.compute-1.amazonaws.com', :dbname => 'denfue801hlg5v', :user => 'kfdmxxbwfsbhyb', :password => '62522c639856cf962740a1287c6116bc74f09f60d59f9014d7c1603bfc0c8039'
                
                existingUser = con.exec "select exists (select * from Emp where email='#{email}')"
                puts existingUser[0]["exists"]
                if existingUser[0]["exists"]=='f' 
                    exist = con.exec "INSERT INTO Emp values ('#{name}', '#{email}', '#{password}', '#{empcode}', '#{address}', '#{joiningdate}')"
                    puts "Emp Added"
                    result = "Account Created"
                    response = {'result' => result}
                    
                    puts response
                    res = JSON.generate(response)

                    self.body = res
                else 
                    result = "Existing User"
                    response = {'result' => result}
                    
                    puts response
                    res = JSON.generate(response)

                    self.body = res
                end  
            
            rescue PG::Error => e
            
                puts e.message 

                puts "Emp Not Added"
                
            ensure
            
                con.close if con
                
            end
        end
    end
end 
