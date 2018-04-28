   <?php

   /**
	 * USSD Based Mobile Money Application  
	 *
	 * @category PHP
	 *
	 * @author  Basil Ndonga <basilndonga@gmail.com>
	 *
	 * @version 1.0.0
	 *
	 * For enquies dont hesitate to contact me on +254 728 986 084
	 *
	 **/

  
	//Ensure ths code runs only after a POST from AT
if(!empty($_POST) && !empty($_POST['phoneNumber'])){
	require_once('dbConnector.php');
	require_once('AfricasTalkingGateway.php');
	require_once('config.php');

	//Receive the POST from AT
	$sessionId     =$_POST['sessionId'];
	$serviceCode   =$_POST['serviceCode'];
	$phoneNumber   =$_POST['phoneNumber'];
	$text          =$_POST['text'];

	//Explode the text to get the value of the latest interaction - think 1*1
	$textArray=explode('*', $text);
	$userResponse=trim(end($textArray));

	//Set the default level of the user
	$level=0;

	//Check the level of the user from the DB and retain default level if none is found for this session
	$LevelQuery = $db->query("select level from session_levels where session_id ='".$sessionId." '");
	$LevelQuery->execute();
	
	if($result = $LevelQuery->fetch(PDO::FETCH_ASSOC)) {
  		$level = $result['level'];
	}	

   
	//Check if the user is in the db
	$stmt = $db->query("SELECT * FROM customer_details WHERE phoneNumber LIKE '%".$phoneNumber."%' LIMIT 1");
	$stmt->execute();
    
    $userAvailable = $stmt->fetch(PDO::FETCH_ASSOC);

	//Check if the user is available (yes)->Serve the menu; 
	if($userAvailable['id_number'] OR $userAvailable['phoneNumber']!=NULL){
		//Serve the Services Menu (if the user is fully registered, 
		//level 0 and 1 serve the basic menus, while the rest allow for financial transactions)

		if($level==0 || $level==1){
			//Check that the user actually typed something, else demote level and start at home
			switch ($userResponse) {
			  
			    case "1":
			        if($level==1){
 		          	 
                        // Find the account
                        $stmt = $db->query("SELECT * FROM customer_account WHERE phoneNumber LIKE '%".$phoneNumber."%'");
                        $stmt->execute();
                        
                        if($stmt->rowCount() > 0){
                           echo "CON "; 

                                while($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                                extract($row);
                       
		                       //Respond with Account Balance
                               $balance="Your account Balance is KES ".$row['account_balance']."\n"; 
                          	   echo $balance;
                            }
                             
                            $back = "0:Back\n";
                            echo $back;
    
				            //Update sessions to level 1
				            $stmt = $db->query("UPDATE `session_levels` SET `level`=1 where `session_id`='".$sessionId."'");
				    	    $stmt->execute();
			  			    // Print the response onto the page so that our gateway can read it
			  			    header('Content-type: text/plain');
 			  			  
                      } else {

                        $response= "CON Sorry, account balance not available at the moment\n" ;
                        $response .="0:Back\n";

                        //Update sessions to level 1
				        $stmt = $db->query("UPDATE `session_levels` SET `level`=1 where `session_id`='".$sessionId."'");
				    	$stmt->execute();

			  			// Print the response onto the page so that our gateway can read it
			  			header('Content-type: text/plain');
 			  			echo $response;	 
                        } 
                            
			        } 
			        break;
			      
			        
			    case "2":
			    	if($level==1){

			    		//Send Money
						$response = "CON You can only send 500 shillings.\n";
						$response .= "Enter phonenumber (like 0722122122)\n";					
			  			// Print the response onto the page so that our gateway can read it
			  			header('Content-type: text/plain');
 			  			echo $response;	

						//Update sessions to level 9
				    	$stmt=$db->query("UPDATE `session_levels` SET `level`=9 where `session_id`='".$sessionId."'");
				    	$stmt->execute();

				    	//B2C
				 
				    	//Find account
						$stmt=$db->query("SELECT * FROM customer_account WHERE phoneNumber LIKE '%".$phoneNumber."%' LIMIT 1");
						$stmt->execute();
				
						if($balAvailable=$stmt->fetch(PDO::FETCH_ASSOC)){
						
						// Reduce balance
						$newBal = $balAvailable['account_balance'];	
						$newBal -= 500;				

						    if($newBal > 0){					    	
								$gateway = new AfricasTalkingGateway($username,$apikey,"sandbox");
								$productName  = "SendFunds"; 
								$currencyCode = "KES";

								$recipient   = array(
									"phoneNumber" => $phoneNumber,
									"currencyCode" => "KES", 
									"amount"=> 500,
									"metadata"=>array("name"=> "Basil","reason" => "Funds Transfer")
									);

								$recipients  = array($recipient);

								try { 
									 $responses = $gateway->mobilePaymentB2CRequest($productName,$recipients);
								}

								catch(AfricasTalkingGatewayException $e){ 
									echo "Received error response: ".$e->getMessage(); 
								}											    	
	 			    		
	 			    		}

	 			    	}

	 			    }
 			    	       
			        break;
			      
			    case "3":
			    	if($level==1){
			    		//9e. Ask how much and Launch B2C to the user
						$response = "CON How much are you withdrawing?\n";
						$response .= " 1. 1500 Shillings.\n";
						$response .= " 2. 1600 Shillings.\n";
						$response .= " 3. 1700 Shillings.\n";							

						//Update sessions to level 10
				    	$stmt=$db->query("UPDATE `session_levels` SET `level`=10 where `session_id`='".$sessionId."'");
				    	$stmt->execute();


			  			// Print the response onto the page so that our gateway can read it
			  			header('Content-type: text/plain');
 			  			echo $response;	
 			  		}

			    	break;	

			    	
			    case "4":
			    	if($level==1){
			    		//Find account
						$stmt=$db->query("SELECT * FROM customer_account WHERE phoneNumber LIKE '%".$phoneNumber."%' LIMIT 1");
						$stmt->execute();

						if($balAvailable=$stmt->fetch(PDO::FETCH_ASSOC)){
							// Reduce balance
							$newBal = $balAvailable['account_balance'];	
							$newBal -= 50;

							//Update Recipient Account
				    		$stmt = $db->query("UPDATE customer_account SET `account_balance`='".$newBal."' WHERE `phoneNumber` = '". $phoneNumber ."'");
				    		$stmt->execute();
				

							if($newBal > 0){

				    		// Send user airtime
							$response = "END Please wait while we load your airtime account.\n";

				  			// Print the response onto the page so that our gateway can read it
				  			header('Content-type: text/plain');

	 			  			echo $response;	

								// Search DB and the Send Airtime
								$recipients = array( array("phoneNumber"=>"".$phoneNumber."", "amount"=>"KES 50") );

								//JSON encode
								$recipientStringFormat = json_encode($recipients);

								//Create an instance of our gateway class, pass your credentials
								$gateway = new AfricasTalkingGateway($username, $apikey,"sandbox");  

								try { 
									$results = $gateway->sendAirtime($recipientStringFormat);
								}

								catch(AfricasTalkingGatewayException $e){ 
									echo $e->getMessage();
								}

							} else {
                        
                                $response= "CON Sorry, you dont have sufficient funds in your account\n " ;
                                $response .= "0:Back\n";
                                //Update sessions to level 1
				                $stmt = $db->query("UPDATE `session_levels` SET `level`=1 where `session_id`='".$sessionId."'");
				    	        $stmt->execute();

			  			        // Print the response onto the page so that our gateway can read it
			  			        header('Content-type: text/plain');
 			  			        echo $response;	 
                        	}
					
					    }
 			    		
			    	}
			        break;
			    case "5":
			    	if($level==1){

					    	// Find the user in the db
							$stmt=$db->query("SELECT * FROM customer_details WHERE phoneNumber LIKE '%".$phoneNumber."%' LIMIT 1");
							$stmt->execute();
							$userAvailable=$stmt->fetch(PDO::FETCH_ASSOC);

				    		// Find the account
							$stmt=$db->query("SELECT * FROM customer_account WHERE phoneNumber LIKE '%".$phoneNumber."%' LIMIT 1");
							$stmt->execute();
							$newBal = 0.00; $newLoan = 0.00;

							if($BalAvailable=$stmt->fetch(PDO::FETCH_ASSOC)){
							$newBal = $BalAvailable['account_balance'];
							$newLoan = $BalAvailable['loan_amount'];
							}
							//Respond with user Balance
							$response = "CON Your Mini statement.\n";
							$response .= "WIRETECH Microfinance.\n";
							$response .= "Name: ".$userAvailable['surname']."\n";	
							$response .= "Balance:KES ".$newBal."\n";	
							$response .= "Loan:KES ".$newLoan."\n";																													
				  			// Print the response onto the page so that our gateway can read it
				  			header('Content-type: text/plain');
	 			  			echo $response;	
				    	}
			    	break;	
			        
			        
			     default:
			         //9b. Graduate user to next level & Serve Main Menu
			        	$stmt = $db->query("INSERT INTO `session_levels`(`session_id`,`phoneNumber`,`level`) VALUES('".$sessionId."','".$phoneNumber."',1)");
			        	$stmt->execute();
                        //Serve our services menu
						$response = "CON Welcome " .$userAvailable['firstname']."\nSelect an option.\n";
						$response .= " 1. Account Balance\n";
						$response .= " 2. Send Money\n";
						$response .= " 3. Withdraw Funds\n";
						$response .= " 4. Send Airtime\n";						
						$response .= " 5. Mini Statement\n";
					    $response .= " 6. PIN Change\n";
																																					

			  			// Print the response onto the page so that our gateway can read it
			  			header('Content-type: text/plain');
 			  			echo $response;	
 			  			break;
			         
			   
			}
			
        }
        
	

    else{
			
			switch ($level){

				 case 9:
			    	//11d. Send money to person described
					$response = "END We are sending KES 500 to the specified number \n";
			
			    	//Find and update account
					$stmt = $db->query("SELECT * FROM customer_account WHERE phoneNumber LIKE '%".$phoneNumber."%' LIMIT 1");
					$stmt->execute();
			
					if($balAvailable=$stmt->fetch(PDO::FETCH_ASSOC)){
					// Reduce balance
					$newBal = $balAvailable['account_balance'];	
					$newBal -=500;				
					}

					//Send money only if new balance is above 0 
					if($newBal > 0){

				    	//Find and update Debtor
						$stmt = $db->query("SELECT * FROM customer_account WHERE phoneNumber LIKE '%".$userResponse."%' LIMIT 1");
						$stmt->execute();

						if($reciever=$stmt->fetch(PDO::FETCH_ASSOC)){
						$newBal_Receiver = $reciever['account_balance'];
						$newBal_Receiver += 500;
						}				

						// SMS New Balance
						$code = '20880';
		            	$recipients = $phoneNumber;
		            	$message    = "We have sent KES 500 to ".$userResponse." If this is a wrong number the transaction will fail.
		            				   Your new balance is KES ".$newBal.". Thank you.";

		            	$gateway    = new AfricasTalkingGateway($username, $apikey,"sandbox");

		            	try { 
		            		$results = $gateway->sendMessage($recipients, $message, $code); 
		            	}

		            	catch ( AfricasTalkingGatewayException $e ) {
		            		echo "Encountered an error while sending: ".$e->getMessage(); 
		            	}

		            	// Update the Sender Account
				        $stmt = $db->query("UPDATE customer_account SET `account_balance`='".$newBal."' WHERE `phoneNumber` = '". $phoneNumber ."'");
				        $stmt->execute();

				    	//Update Recipient Account
				    	$stmt = $db->query("UPDATE customer_account SET `account_balance`='".$newBal_Receiver."' WHERE `phoneNumber` = '". $userResponse ."'");
				    	$stmt->execute();

			        
						//Declare Params
						$gateway = new AfricasTalkingGateway($username, $apikey,"sandbox");
						$productName  = "SendFunds";
						$currencyCode = "KES";

						$recipient   = array(
							"phoneNumber" => "".$phoneNumber."",
							"currencyCode" => "KES",
							"amount"=>500,
							"metadata"=>array("name"=>"Client","reason" => "Withdrawal")
							);

						$recipients  = array($recipient);

						//Send B2C
						try {
							$responses = $gateway->mobilePaymentB2CRequest($productName, $recipients);
						}

						catch(AfricasTalkingGatewayException $e){
							echo "Received error response: ".$e->getMessage();}	

						//respond
						$response = "END We have sent money to ".$userResponse." \n";	

					} else {

						//Alert user of insufficient funds
						$response = "END Sorry, you dont have sufficient\n";
						$response .= "funds in your account \n";						
					}	    	

			  		// Print the response onto the page so that our gateway can read it
			  		header('Content-type: text/plain');
				  	echo $response;	
			    	break;

			      case 10: 
			    	//Withdraw fund from account
					switch ($userResponse) {
					    case "1":
					    	//Find account
							$stmt = $db->query("SELECT * FROM customer_account WHERE phoneNumber LIKE '%".$phoneNumber."%' LIMIT 1");
							$stmt->execute();
		
							if($balAvailable=$stmt->fetch(PDO::FETCH_ASSOC)){
							// Reduce balance
							$newBal = $balAvailable['account_balance'];
							$newBal -=1500;					
							}

							if($newBal > 0){

						    	//Alert user of incoming Mpesa cash
						    	$response = "END We are sending your withdrawal of\n";
						    	$response .= "KES 1500 shortly\n";

								//Declare Params
								$gateway = new AfricasTalkingGateway($username, $apikey,"sandbox");
								$productName  = "SendFunds";
								$currencyCode = "KES";

								$recipient   = array(
									"phoneNumber" => "".$phoneNumber."",
									"currencyCode" => "KES",
									"amount"=>1500,
									"metadata"=>array("name"=>"Client","reason" => "Withdrawal")
									);

								$recipients  = array($recipient);

								//Send B2C
								try {
									$responses = $gateway->mobilePaymentB2CRequest($productName, $recipients);
								}
								catch(AfricasTalkingGatewayException $e){
									echo "Received error response: ".$e->getMessage();
								}	

							} else {
						    	//Alert user of insufficient funds
						    	$response = "END Sorry, you dont have sufficient\n";
						    	$response .= "funds in your account \n";						
							}		    	

							// Print the response onto the page so that our gateway can read it
							header('Content-type: text/plain');
						  	echo $response;	
					    break;


					    case "2":
					    	//Find account
							$stmt = $db->query("SELECT * FROM customer_account WHERE phoneNumber LIKE '%".$phoneNumber."%' LIMIT 1");
							$stmt->execute();
		
							if($balAvailable=$stmt->fetch(PDO::FETCH_ASSOC)){
							// Reduce balance
							$newBal = $balAvailable['account_balance'];
							$newBal -=1500;					
							}

							if($newBal > 0){

						    	//Alert user of incoming Mpesa cash
						    	$response = "END We are sending your withdrawal of\n";
						    	$response .= "KES 1600 shortly\n";

								//Declare Params
								$gateway = new AfricasTalkingGateway($username, $apikey,"sandbox");
								$productName  = "SendFunds";
								$currencyCode = "KES";

								$recipient   = array(
									"phoneNumber" => "".$phoneNumber."",
									"currencyCode" => "KES",
									"amount"=>1600,
									"metadata"=>array("name"=>"Client","reason" => "Withdrawal")
									);

								$recipients  = array($recipient);

								//Send B2c
								try {
									$responses = $gateway->mobilePaymentB2CRequest($productName, $recipients);
								}
								catch(AfricasTalkingGatewayException $e){
									echo "Received error response: ".$e->getMessage();
								}	

							} else {
						    	//Alert user of insufficient funds
						    	$response = "END Sorry, you dont have sufficient\n";
						    	$response .= "funds in your account \n";						
							}		    	

							// Print the response onto the page so that our gateway can read it
							header('Content-type: text/plain');
						  	echo $response;	
					    break;



					    case "3":
					    	//Find account
							$stmt = $db->query("SELECT * FROM customer_account WHERE phoneNumber LIKE '%".$phoneNumber."%' LIMIT 1");
							$stmt->execute();
		
							if($balAvailable=$stmt->fetch(PDO::FETCH_ASSOC)){
							// Reduce balance
							$newBal = $balAvailable['account_balance'];
							$newBal -=1500;					
							}

							if($newBal > 0){

						    	//Alert user of incoming Mpesa cash
						    	$response = "END We are sending your withdrawal of\n";
						    	$response .= " KES 1700 shortly\n";

								//Declare Params
								$gateway = new AfricasTalkingGateway($username, $apikey,"sandbox");
								$productName  = "SendFunds";
								$currencyCode = "KES";

								$recipient   = array(
									"phoneNumber" => "".$phoneNumber."",
									"currencyCode" => "KES",
									"amount"=>1700,
									"metadata"=>array("name"=>"Client","reason" => "Withdrawal")
									);

								$recipients  = array($recipient);

								//Send B2c
								try {
									$responses = $gateway->mobilePaymentB2CRequest($productName, $recipients);
								}
								catch(AfricasTalkingGatewayException $e){
									echo "Received error response: ".$e->getMessage();
								}	

							} else {
						    	//Alert user of insufficient funds
						    	$response = "END Sorry, you dont have sufficient\n";
						    	$response .= "funds in your account \n";						
							}		    	

							// Print the response onto the page so that our gateway can read it
							header('Content-type: text/plain');
						  	echo $response;	
					    break;



					    default:
							$response = "END Apologies, something went wrong... \n";
						  		// Print the response onto the page so that our gateway can read it
						  		header('Content-type: text/plain');
						  		echo $response;	
						break;    
				        
				       
					}				
		        
		        	
				}
        
    		}
	    
		}
    
    else{
       $response = "END Sorry, you are not registered for WIRETECH Mobile money Service.\n";
       	// Print the response onto the page so that our gateway can read it
	  header('Content-type: text/plain');
	  echo $response;
       
    }
}
    	

?>
