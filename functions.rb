class PasswordReqClass
	attr_accessor :password

	def initialize(password)
		@password = password		
	end

	def password_requirements()
		password[/[a-zA-Z0-9]{6,}/] == password
	end
	#password function. Can only contain letters, numbers and no less than 6 characters.
	def password_match(confirm)
		password.include?(confirm)
	#password confirm function. When signing up making sure passwords match	
	end
end

 #                                MMMMMM=                                      
 #                           .MMMMMMMMMMMMMM                                   
 #                         MMMMMM         MMMM                                 
 #                      MMMMM              MMMMM.                              
 #                MMMMMMMM                  ?MMMM.                             
 #             .MMMMMMMM7MM                  MMMMM                             
 #             MMMMMMMMM MM                   MMMM                             
 #             MMMMMMMMM .MM                   MMM                             
 #            .MMMMMMM.   MM.M.   =MMMMMMMM.   MMM                             
 #             MMMMMMMM.MMMMMM.  MMMMMMMM MMM  MMM                             
 #             MMMMMMMMMMMM     MMMMMMMMM  MMM MMM                             
 #            MMM    MMM:  MM   MMMMMMMMM  MMM MMM                             
 #           8MM.    MMMMMMMM=  MMMMMMMM.  .M ,MM7                             
 #          MMMMMMMM..          MMMMM.     M  MMM                              
 #         .MMMMMMMMMMMMMMM       MMMMMMMMM.  MMM                              
 #        .MMM        MMMMMMMMMMM.           MMMM                              
 #        MMM                .~MMMMMMM.      MMM.                              
 #       MMM.                               MMMM                               
 #      .MMM                                MMMM                               
 #      MMM                                DMMM                                
 #     MMM                                 MMMM                                
 #     MMM                                .MMM                                 
 #    MMM                      MM        .MMM                                  
 #    MMM                     .MM  MM.   MMM~                                  
 #    MMM                     MMM .MM.   MMM                         MMMMM     
 #    MMM                     MM. MMM   MMM                        MMM   MMO   
 #    MMM                     MM  MM   .MMM                      MMMM     MM   
 #    MM~                    MM. MMM   MMM.                     MMM      IMM   
 #    MM.                    MM  MM.  .MMM                    .MMM.      MM    
 #    MM                     M  MMN   .MMM                   MMMM       MM.    
 #    MM+                   MM MMM    .MM 7MMMMMMMMMMM      MMM.       MM      
 #    MMM                  .M  MM      MMMMMM. .. MMMMMMM MMM.       MMM.      
 #    MMM                  +M MMM      MM    .MM     .MMMMMM.      .MMM.       
 #    ?MM                  M  MM       .      MMM      ~MM.       MMMM         
 #    .MM                 MM  MM            ,MMMMMMMMMMM         MMMM          
 #     MMM              MM     MM          MMMMMMMMMMMMMMM     MMMMM           
 #     MMM            .M     N  MM                  ..MMMMM.     MMMM          
 #     .MM             MMMM MMMMMM                     .MMMMM        DMM       
 #      MMM              MMMMM.MM.             ,M,       .MMM.        MM       
 #       MMM               M.                  MMM         MMM.  .MMMM         
 #       MMMM                                              MMM.    MM          
 #        =MMM.                            MM.             MMM      MM         
 #          MMMM.                          MM              MMM       M         
 #            MMMM                                         MMMMM,. MMM         
 # .          MMMMMMM.                     MMM            MMM MMMMMM.          
 # MMMM      MMN  .MMMMM                               .MMMD                   
 # MM MMN  .MM    MM MMMMMMMM~ .              M.     .MMMM                     
 # MM   MM$MM   MMN      MMMMMMMMMM.          M.   .MMMM                       
 #  M.   MMM   MM              MMMMM  MMMMMMMMM~MMMMMM                         
 #  MM      .MMN          .. . +MM,  8MM .MMMMMMMM.                            
 #   M?    NMM           MMMMMMMMM   MM                                        
 #   .M  .MM7            MMM MMMM   MM                                         
 #     MMMM              OMM       .MM                                         
 #      .                 MMM      MM                                          
 #                        .MMM    MM                                           
 #                         .MMD  MMM                                           
 #                           MMMMM?                                            
 #                            MMM.                                             