# PHP package for a mobile money solution on USSD

This is a PHP package for a mobile money solution on USSD based on the Africa's Talking API.This is developed on sandbox (testing) mode. To go live contact Africa's Talking Ltd on https://www.africastalking.com/contact.

## Prerequisites

For testing download Africas Talking android app from Google Playstore or use the web interface at https://simulator.africastalking.com:1517/


## Installation

This project supports both composer dependency management tool and can also be used without composer

### Using Composer

Run the following command

```
composer require bascil/ussd-mobile-money-php

```
### Without composer

Download the source code as zipped 

## Configuration

1. Import the ussd_sample.sql file into MySQL database.

2. Configure the database connection using dbConnector.php file

``` 
<?php 
     /* Configure Database */

     $conn = 'mysql:dbname=ussd_sample;host=127.0.0.1;'; //database name
     $user = 'root'; // your mysql user 
     $password = ''; // your mysql password

     //  Create a PDO instance that will allow you to access your database
     try {
        $db = new PDO($conn, $user, $password);
     }

    catch(PDOException $e) {
     //var_dump($e);
        echo("PDO error occurred");
    }

    catch(Exception $e) {
    //var_dump($e);
    echo("Error occurred");
    }
    
?>

```
3. Go to "https://account.africastalking.com/". Create an account then click on the 'Go to Sandbox App' button

4. In your sandbox account under USSD > Create Channel , pick a shared service code  such as `*384*` and a channel such as 1100 i.e `*384*1100#` (Be sure to take a unique channel which is not taken already)

5. Configure your callback url( the URL that points to your application) e.g www.example.com/folder_name/ussd.php then click 'Create channel'.This assumes you are working from a live server whose domain name is example.com.Replace the domain name with your own.

6. If working from localhost you can set up a Ngrok server or Localtunnel to expose your localhost to the internet.Use the temporary URL provided as your callback e.g  http://6a71f5ec.ngrok.io/folder_name/ussd.php. This only works when the computer is on and connected to the internet.If using Ngrok free package this address may change every 8 hours. You could opt for a paid version at USD 5 a month.

7. Go to Settings > API key and enter your password to generate an API key. Look for a file named `config.php` and set your username as 'sandbox' and the api key as the one you have generated.

8. Configure a payment product (if working with mobile money). Payment products allow you to interact with our payment APIs. Go to Payments > Products to create a payment product for testing. 


### Usage

```
   
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

```

9. Configure a an SMS shortcode (if working with SMS). This allows sending of SMS notifications (for this case on sandbox mode). Go to SMS > Shortcodes > Create Shortcode to create an SMS shortcode for testing. 


### Usage

```
   
    $code = '20880';
    $recipients = $phoneNumber;
    $message    = "We have sent KES 500 to ".$userResponse." If this is a wrong number the transaction will fail.
    Your new balance is KES ".$newBal.". Thank you.";

    $gateway    = new AfricasTalkingGateway($username, $apikey,"sandbox");

```
10. Now test the USSD application using Africas Talking android app downloaded from Google Playstore or use the web interface at https://simulator.africastalking.com:1517/ using the USSD code you configured i.e. `*384*1100#`

## API's Supported

The code  is configure to to work with the Africa's Talking API and may support the following payment types


### 1. [C2B](https://developer.safaricom.co.ke/docs#c2b-api)
#### &nbsp; &nbsp; What it is?
This endpoint enables developers to receive real time notifications when a client makes a payments to a merchant's Till number or Paybill number. It assumes the payment are made via the SIM card toolkit and as a developer you need to know when that payment hits the merchants till/paybill number for reconciliation and accounting purposes.


### 2. [B2C](https://developer.safaricom.co.ke/docs#b2c-api)
#### &nbsp; &nbsp; What it is?
This endpoints enables merchants to pay their customers from they paybill account. Some of the use cases are but not limited to paying salaries, paying promotions to customers etc.

### 3. [B2B](https://developer.safaricom.co.ke/docs#b2b-api)
#### &nbsp; &nbsp; What it is?
This endpoint allows merchants to transfer funds from business to business accounts. 

Find out more payment options at http://docs.africastalking.com/payments


## Inspiration

This package was inspired by the work from Graham Ingokho (JaniKibichi) work on the following project:-
https://github.com/JaniKibichi/microfinance-ussd-app


## Support

Need support using this package:-

Email basilndoga@gmail.com or skype me at basilndonga. Feel free to call me on my cellphone number +254 728 986 084

If you wish to be added as a contributor to this project let me know.

## License

This USSD Package is open-sourced software licensed under the [MIT license](http://opensource.org/licenses/MIT).

Happy coding!!!!!!!

