### Reversal
Reverses a B2B, B2C or C2B M-Pesa transaction.

### Reversal Resource URL
POST https://sandbox.safaricom.co.ke/mpesa/reversal/v1/request

### Reversal Request Parameters

	##Initiator 	
This is the credential/username used to authenticate the transaction request.

	##SecurityCredential 	
Base64 encoded string of the Security Credential, which is encrypted using M-Pesa public key and validates the transaction on M-Pesa Core system.

	##CommandID 	
Unique command for each transaction type, possible values are: 
TransactionReversal.

	##PartyA 	
Organization/MSISDN sending the transaction.

	##RecieverIdentifierType 	
Type of organization receiving the transaction.

	##Remarks 	
Comments that are sent along with the transaction.

	##QueueTimeOutURL 	
The path that stores information of time out transaction.

	##ResultURL 	
The path that stores information of transaction.

	##TransactionID 	
Organization Receiving the funds.

	##Occasion 	
Optional.

### Sample PHP Reversal Request

```
	<?php
	
	$url = 'https://sandbox.safaricom.co.ke/mpesa/reversal/v1/request';

	$curl = curl_init();
	curl_setopt($curl, CURLOPT_URL, $url);
	curl_setopt($curl, CURLOPT_HTTPHEADER, array('Content-Type:application/json','Authorization:Bearer ACCESS_TOKEN')); //setting custom header


	$curl_post_data = array(
	  //Fill in the request parameters with valid values
	  'CommandID' => ' ',
	  'Initiator' => ' ',
	  'SecurityCredential' => ' ',
	  'CommandID' => 'TransactionReversal',
	  'TransactionID' => ' ',
	  'Amount' => ' ',
	  'ReceiverParty' => ' ',
	  'RecieverIdentifierType' => '4',
	  'ResultURL' => 'https://ip_address:port/result_url',
	  'QueueTimeOutURL' => 'https://ip_address:port/timeout_url',
	  'Remarks' => ' ',
	  'Occasion' => ' '
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

### Sample JSON Reversal Response

```
	{

	  "Result":{
	    "ResultType":0,
	    "ResultCode":0,
	    "ResultDesc":"The service request has been accepted successfully.",
	    "OriginatorConversationID":"10819-695089-1",
	    "ConversationID":"AG_20170727_00004efadacd98a01d15",
	    "TransactionID":"LGR019G3J2",
	    "ReferenceData":{

	      "ReferenceItem":{
	        "Key":"QueueTimeoutURL",
	        "Value":"https://internalsandbox.safaricom.co.ke/mpesa/reversalresults/v1/submit"
	      }
	    }
	  }
	}

```