# tollgate_app

It is a flutter based project.

## Description

- It is an android app that is built for the purpose of making payments at the tollgates via the app.
- A user should register his/her account first.
- Then he/she must enter their personal info (Vehicle number, amount in wallet etc.).
- Every time they travel, they will have to make a ***TRAVEL ENTRY***.
- When they reach the tollgate, the camera will detect the registered number plate.
- User must click payment, and the amount gets deducted from the wallet.
- It also displays he amount deducted and amount pending in the wallet to the user.

## Working of the App
(This is a prototype mobile application and actual payment portal isn't included).
- This app runs an ML model to recognize the displayed number plate.
- So we have used the local host concept and hence, the app will be recieving the data from the ML model via the local system itself.
- Turn on the hotspot on the laptop.
- Connect your phone to the laptop hotspot.
- Turn on GPS Location on your phone.
- Keep a screenshot of a properly cropped number plate which is registered by you in the app already.
- But for displaying the payment section you need to do as follows:
  - Run the test.py file on pc (This makes the ml mode run and open the system camera to test the project)
  - Then click on Payment button
- Now you can use the app!

## Future Plans
- To host the ml model ina server.
- To use SMS integration to the app to notify the users about money deduction.
- To add payment portal.
- Add QR Code generation to scan and auto deduct the money and store data about every user's travel history.

# Preview of the App

## Splash Screen
![alt text](https://github.com/PSSubramanya/tollgate-app/blob/master/assets/images/1.jpeg)

## Login Page
![alt text](https://github.com/PSSubramanya/tollgate-app/blob/master/assets/images/2.jpeg)

## Signup Page
![alt text](https://github.com/PSSubramanya/tollgate-app/blob/master/assets/images/3.jpeg)

## New User Registration Loading Screen
![alt text](https://github.com/PSSubramanya/tollgate-app/blob/master/assets/images/4.jpeg)

## User Info Page
![alt text](https://github.com/PSSubramanya/tollgate-app/blob/master/assets/images/5.jpeg)

## Travel Info Page
![alt text](https://github.com/PSSubramanya/tollgate-app/blob/master/assets/images/6.jpeg)

## Payment Page
![alt text](https://github.com/PSSubramanya/tollgate-app/blob/master/assets/images/7.jpeg)

## User Login Loading Screen
![alt text](https://github.com/PSSubramanya/tollgate-app/blob/master/assets/images/8.jpeg)
