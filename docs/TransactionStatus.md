### Transaction Status API 
checks the status of a B2B, B2C and C2B APIs transactions.

### Transaction Status Resource URL
POST https://sandbox.safaricom.co.ke/mpesa/transactionstatus/v1/query

### Transaction Status Request Parameters

	##CommandID 	
Unique command for each transaction type, possible values are: TransactionStatusQuery.

	##ShortCode 	
Organization /MSISDN sending the transaction.

	##IdentifierType 	
Type of organization receiving the transaction

	##Remarks 	
Comments that are sent along with the transaction.

	##Initiator 	
The name of Initiator to initiating the request.

	##SecurityCredential 	
Base64 encoded string of the Security Credential, which is encrypted using M-Pesa public key and validates the transaction on M-Pesa Core system.

	##QueueTimeOutURL 	
The path that stores information of time out transaction.

	##ResultURL 	
The path that stores information of transaction.

	##TransactionID 	
Organization Receiving the funds.

	##Occasion 	
Optional.

## Sample PHP Transaction Status Request

```
<?php
	$url = 'https://sandbox.safaricom.co.ke/mpesa/transactionstatus/v1/query';

	$curl = curl_init();
	curl_setopt($curl, CURLOPT_URL, $url);
	curl_setopt($curl, CURLOPT_HTTPHEADER, array('Content-Type:application/json','Authorization:Bearer ACCESS_TOKEN')); //setting custom header


	$curl_post_data = array(
	  //Fill in the request parameters with valid values
	  'Initiator' => ' ',
	  'SecurityCredential' => ' ',
	  'CommandID' => 'TransactionStatusQuery',
	  'TransactionID' => ' ',
	  'PartyA' => ' ',
	  'IdentifierType' => '1',
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

## Sample JSON Response

```

	{
	  "Result":{
	    "ResultType":0,
	    "ResultCode":0,
	    "ResultDesc":"The service request has been accepted successfully.",
	    "OriginatorConversationID":"10816-694520-2",
	    "ConversationID":"AG_20170727_000059c52529a8e080bd",
	    "TransactionID":"LGR0000000",
	    "ResultParameters":{
	      "ResultParameter":[
	        {
	          "Key":"ReceiptNo",
	          "Value":"LGR919G2AV"
	        },
	        {
	          "Key":"Conversation ID",
	          "Value":"AG_20170727_00004492b1b6d0078fbe"
	        },
	        {
	          "Key":"FinalisedTime",
	          "Value":20170727101415
	        },
	        {
	          "Key":"Amount",
	          "Value":10
	        },
	        {
	          "Key":"TransactionStatus",
	          "Value":"Completed"
	        },
	        {
	          "Key":"ReasonType",
	          "Value":"Salary Payment via API"
	        },
	        {
	          "Key":"TransactionReason"
	        },
	        {
	          "Key":"DebitPartyCharges",
	          "Value":"Fee For B2C Payment|KES|33.00"
	        },
	        {
	          "Key":"DebitAccountType",
	          "Value":"Utility Account"
	        },
	        {
	          "Key":"InitiatedTime",
	          "Value":20170727101415
	        },
	        {
	          "Key":"Originator Conversation ID",
	          "Value":"19455-773836-1"
	        },
	        {
	          "Key":"CreditPartyName",
	          "Value":"254708374149 - John Doe"
	        },
	        {
	          "Key":"DebitPartyName",
	          "Value":"600134 - Safaricom157"
	        }
	      ]
	    },
	    "ReferenceData":{
	      "ReferenceItem":{
	        "Key":"Occasion",
	        "Value":"aaaa"
	      }
	    }
	  }
	}

```