require 'pg'
require 'hanami/controller'
require 'json'

module DeleteProfile
    class DeleteProfile
        include ::Hanami::Action
        def call (env)
            response = request.body.read
            puts response
            deleteProfileDetails = JSON.parse(response)
            email = deleteProfileDetails['profileDetails']['email']
            puts email
            
            begin
                con = PG.connect :host => 'ec2-35-169-188-58.compute-1.amazonaws.com', :dbname => 'denfue801hlg5v', :user => 'kfdmxxbwfsbhyb', :password => '62522c639856cf962740a1287c6116bc74f09f60d59f9014d7c1603bfc0c8039'                
                exist = con.exec "DELETE FROM Emp where email = '#{email}'"
                    puts "Profile Is Deleted"

                    deleted = "true"
                                        
                    response = {'deleted' => deleted}
                    
                    puts response
                    res = JSON.generate(response)

                    self.body = res              
                
            
            rescue PG::Error => e
            
                puts e.message 

                    updated = "false"
                                      
                    response = {'updated' => updated}
                    
                    puts response
                    res = JSON.generate(response)

                    self.body = res
                
            ensure
            
                con.close if con
                
            end
        end
    end
end 
