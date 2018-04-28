### B2C API
This API enables Business to Customer (B2C) transactions between a company and customers who are the end-users of its products or services. Use of this API requires a valid and verified B2C M-Pesa Short code.

### B2C Resource URL
POST https://sandbox.safaricom.co.ke/mpesa/b2c/v1/paymentrequest


### B2C Query Parameters

	###InitiatorName 	
This is the credential/username used to authenticate the transaction request.

	##SecurityCredential 	
Base64 encoded string of the Security Credential, which is encrypted using M-Pesa public key and validates the transaction on M-Pesa Core system.

	##CommandID 	
Unique command for each transaction type e.g. SalaryPayment, BusinessPayment, PromotionPayment

	##Amount 	
The amount being transacted

	##PartyA 	
Organization’s shortcode initiating the transaction.

	##PartyB 	
Phone number receiving the transaction

	##Remarks 	
Comments that are sent along with the transaction.

	##QueueTimeOutURL 	
The timeout end-point that receives a timeout response.

	##ResultURL 	
The end-point that receives the response of the transaction

	##Occasion 	
Optional

###Sample PHP Request
```
	<?php
	
	$url = 'https://sandbox.safaricom.co.ke/mpesa/b2c/v1/paymentrequest';

	$curl = curl_init();
	curl_setopt($curl, CURLOPT_URL, $url);
	curl_setopt($curl, CURLOPT_HTTPHEADER, array('Content-Type:application/json','Authorization:Bearer ACCESS_TOKEN')); //setting custom header


	$curl_post_data = array(
	  //Fill in the request parameters with valid values
	  'InitiatorName' => ' ',
	  'SecurityCredential' => ' ',
	  'CommandID' => ' ',
	  'Amount' => ' ',
	  'PartyA' => ' ',
	  'PartyB' => ' ',
	  'Remarks' => ' ',
	  'QueueTimeOutURL' => 'http://your_timeout_url',
	  'ResultURL' => 'http://your_result_url',
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
## Sample M-Pesa Core response received on the callback url.

```

	{
	    "Result":{
	    "ResultType":0,
	    "ResultCode":0,
	    "ResultDesc":"The service request has been accepted successfully.",
	    "OriginatorConversationID":"19455-424535-1",
	    "ConversationID":"AG_20170717_00006be9c8b5cc46abb6",
	    "TransactionID":"LGH3197RIB",
	    "ResultParameters":{
	      "ResultParameter":[
	        {
	          "Key":"TransactionReceipt",
	          "Value":"LGH3197RIB"
	        },
	        {
	          "Key":"TransactionAmount",
	          "Value":8000
	        },
	        {
	          "Key":"B2CWorkingAccountAvailableFunds",
	          "Value":150000
	        },
	        {
	          "Key":"B2CUtilityAccountAvailableFunds",
	          "Value":133568
	        },
	        {
	          "Key":"TransactionCompletedDateTime",
	          "Value":"17.07.2017 10:54:57"
	        },
	        {
	          "Key":"ReceiverPartyPublicName",
	          "Value":"254708374149 - John Doe"
	        },
	        {
	          "Key":"B2CChargesPaidAccountAvailableFunds",
	          "Value":0
	        },
	        {
	          "Key":"B2CRecipientIsRegisteredCustomer",
	          "Value":"Y"
	        }
	      ]
	    },
	    "ReferenceData":{
	      "ReferenceItem":{
	        "Key":"QueueTimeoutURL",
	        "Value":"https://internalsandbox.safaricom.co.ke/mpesa/b2cresults/v1/submit"
	      }
	    }
	  }
	}

```