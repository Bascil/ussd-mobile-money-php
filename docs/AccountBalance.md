## Account Balance API 
Requests for the account balance of a shortcode

## Account Balance - Resource URL
POST https://sandbox.safaricom.co.ke/mpesa/accountbalance/v1/query

### Account Balance - Request Parameters

	##Initiator
This is the credential/username used to authenticate the transaction request.

	##SecurityCredential 	
Base64 encoded string of the Security Credential, which is encrypted using M-Pesa public key and validates the transaction on M-Pesa Core system.

	##CommandID 	
A unique command passed to the M-Pesa system.

	##PartyB 	
The shortcode of the organisation receiving the transaction.

	##ReceiverIdentifierType 	
Type of the organisation receiving the transaction.

	##Remarks 	
Comments that are sent along with the transaction.

	##QueueTimeOutURL 	
The timeout end-point that receives a timeout message.

	##ResultURL 	
The end-point that receives a successful transaction.

	##AccountType 	
Organisation receiving the funds.

### Sample PHP Account Balance Request

```
	<?php

	$url = 'https://sandbox.safaricom.co.ke/mpesa/accountbalance/v1/query';

	$curl = curl_init();
	curl_setopt($curl, CURLOPT_URL, $url);
	curl_setopt($curl, CURLOPT_HTTPHEADER, array('Content-Type:application/json','Authorization:Bearer ACCESS_TOKEN')); //setting custom header


	$curl_post_data = array(
	  //Fill in the request parameters with valid values
	  'CommandID' => ' ',
	  'Initiator' => ' ',
	  'SecurityCredential' => ' ',
	  'CommandID' => 'AccountBalance',
	  'PartyA' => ' ',
	  'IdentifierType' => '4',
	  'Remarks' => ' ',
	  'QueueTimeOutURL' => 'https://ip_address:port/timeout_url',
	  'ResultURL' => 'https://ip_address:port/result_url'
	);

	$data_string = json_encode($curl_post_data);

	curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
	curl_setopt($curl, CURLOPT_POST, true);
	curl_setopt($curl, CURLOPT_POSTFIELDS, $data_string);

	$curl_response = curl_exec($curl);
	print_r($curl_response);

	echo $curl_response;
	?>

```
### Sample Account Balance Response

```
	{
	
	  "Result":{
	    "ResultType":0,
	    "ResultCode":0,
	    "ResultDesc":"The service request has b een accepted successfully.",
	    "OriginatorConversationID":"19464-802673-1",
	    "ConversationID":"AG_20170728_0000589b6252f7f25488",
	    "TransactionID":"LGS0000000",
	    "ResultParameters":{
	      "ResultParameter":[
	        {
	          "Key":"AccountBalance",
	          "Value":"Working Account|KES|46713.00|46713.00|0.00|0.00&Float Account|KES|0.00|0.00|0.00|0.00&Utility Account|KES|49217.00|49217.00|0.00|0.00&Charges Paid Account|KES|-220.00|-220.00|0.00|0.00&Organization Settlement Account|KES|0.00|0.00|0.00|0.00"
	        },
	        {
	          "Key":"BOCompletedTime",
	          "Value":20170728095642
	        }
	      ]
	    },
	    "ReferenceData":{
	      "ReferenceItem":{
	        "Key":"QueueTimeoutURL",
	        "Value":"https://internalsandbox.safaricom.co.ke/mpesa/abresults/v1/submit"
	      }
	    }
	  }
	}

```