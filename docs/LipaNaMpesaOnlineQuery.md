### Lipa na M-Pesa Online Query Request - Resource URL
POST https://sandbox.safaricom.co.ke/mpesa/stkpushquery/v1/query

### Lipa na M-Pesa Online Query Request - Request Parameters

### BusinessShortCode 	Business Short Code

# Parameter 			Description
	Password 			Password
	Timestamp 			Timestamp
	CheckoutRequestID 	Checkout RequestID

##Sample PHP Query Request
```
	<?php

	$url = 'https://sandbox.safaricom.co.ke/mpesa/stkpushquery/v1/query';

	$curl = curl_init();
	curl_setopt($curl, CURLOPT_URL, $url);
	curl_setopt($curl, CURLOPT_HTTPHEADER, array('Content-Type:application/json','Authorization:Bearer ACCESS_TOKEN')); //setting custom header


	$curl_post_data = array(
	  //Fill in the request parameters with valid values
	  'BusinessShortCode' => ' ',
	  'Password' => ' ',
	  'Timestamp' => ' ',
	  'CheckoutRequestID' => ' '
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

### Lipa na M-Pesa Online Query Request - Response Parameters

#Parameter 				Description
	MerchantRequestID 	Merchant Request ID
	CheckoutRequestID 	Check out Request ID
	ResponseCode 		Response Code
	ResultDesc 			Result Desc
	ResponseDescription Response Description message
	ResultCode 			Result Code

## Sample JSON Query Response

```
	{

	  "ResponseCode":"0",
	  "ResponseDescription":"The service request has been accepted successfully",
	  "MerchantRequestID":"8555-67195-1",
	  "CheckoutRequestID":"ws_CO_27072017151044001",
	  "ResultCode":"1032",
	  "ResultDesc":"[STK_CB - ]Request cancelled by user"
	}
```