import cv2
import sys
import imutils
import pytesseract
import numpy as np
import csv
# import mysql.connector
import subprocess
import datetime
import time
import serial
from firebase import firebase




now = datetime.datetime.now()
pytesseract.pytesseract.tesseract_cmd = r'C:\Program Files\Tesseract-OCR\tesseract.exe'

# firebase db
firebase = firebase.FirebaseApplication('https://tollgateapp-febd0.firebaseio.com/', None)
userid=[]
result =firebase.get('/', '')
for user in result:
    userid.append(user)
# a='/'+userid[0]+'/'
userinfoid=[]
userNo = 0

if __name__ == '__main__':

	imPath = "images/computer-vision.jpg"
	cap = cv2.VideoCapture(0)    
	config = ('-l eng --oem 1 --psm 3')
	number_plate = ''
	wallet_amt = 0
	user_time = ''
	FMT = '%Y-%m-%d %H:%M:%S'
	vehicle_type = ''

	def check_entry(number_plate):
		flag = 0
		
		for x in myresult:
			if (x[0] == number_plate):
				flag = 1
				break
			else:
				flag = 0
		  
		if (flag == 1):
			return 1
		else:
			return 0	

	def getUserTime(number_plate):
		t = ''
		for x in myresult:
			if (x[0] == number_plate):
				t = x[4]
				break
		return t						
					
	
	def getNumberPlate(number_plate):
		plate = ''
		for x in myresult:
			if(x[0] == number_plate):
				plate = x[2]
				break
		return plate

	def getVehicleType(number_plate):
		vehicle = ''
		for x in myresult:
			if(x[0] == number_plate):
				vehicle = x[2]
				break
		return vehicle

	def getWalletAmount(number_plate):
		wallet = 0
		for x in myresult:
			if(x[0] == number_plate):
				wallet = x[3]
				break
		return wallet

	while True:
		# ret, img = cap.read()
		# img = cv2.resize(img,(400,400))

		# # Read the number plate
		# text = pytesseract.image_to_string(img, config=config)
		# print(text)
		text = "KA 20 D 1436" 
        # print(len(text))

		# gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)  # convert to grey scale
		# # gray = cv2.bilateralFilter(gray, 11, 17, 17)  # Blur to reduce noise
		# edged = cv2.Canny(gray, 30, 200)  # Perform Edge detection
		# # find contours in the edged image, keep only the largest
		# # ones, and initialize our screen contour
		# cnts = cv2.findContours(edged.copy(), cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)
		# cnts = imutils.grab_contours(cnts)
		# cnts = sorted(cnts, key=cv2.contourArea, reverse=True)[:10]
		# screenCnt = None

		# # loop over our contours
		# for c in cnts:
		# 	# approximate the contour
		# 	peri = cv2.arcLength(c, True)
		# 	approx = cv2.approxPolyDP(c, 0.018 * peri, True)

		# 	# if our approximated contour has four points, then
		# 	# we can assume that we have found our screen
		# 	if len(approx) == 4:
		# 		screenCnt = approx
		# 		break

		# if screenCnt is None:
		# 	detected = 0
		# 	print
		# 	"No contour detected"
		# else:
		# 	detected = 1

		# if detected == 1:
		# 	cv2.drawContours(img, [screenCnt], -1, (0, 255, 0), 3)

		# cv2.imshow('TOLL2', edged)
		# cv2.imshow('TOLL', img)
		# if cv2.waitKey(25) & 0xFF == ord('q'):
		# 	cv2.destroyAllWindows()
		# 	break

        # print("numberplate detected")
		print('numberplate detected')
		userNo=0
		if text != '':
			number_plate = text.strip()
			print(number_plate)
			if True:#len(number_plate)==10:				
				print("\n")
				# result = firebase.put(a+'/travelinfo/-M8trMRZupVHNf_2MFWN','starting','usa')
				
				for i in range (0,len(userid)):
        
					
					tempUserdata =  firebase.get('/'+userid[i]+'/','userinfo')
					print(tempUserdata)
					for tempuserinfo in tempUserdata:
						userinfoid.append(tempuserinfo)
					tempUrl='/'+userid[i]+'/'+'/userinfo/'+userinfoid[-1]
					numPlate = firebase.get(tempUrl,'vehicleNumber')
					print(numPlate)					
					if(numPlate==text):
						userNo=i
						break
					print(userNo)
				print(userNo)	
                # b='/'+userid[userNo]+'/'
				b='/'+userid[userNo]+'/'

				if(True):#check_entry(number_plate)):
					#print("The vehicle exists") 

					# user_time = getUserTime(number_plate) 
					current_time = now.strftime("%Y-%m-%d %H:%M:%S")
					# tdelta = now.strptime(str(current_time), FMT) - now.strptime(str(user_time), FMT)
					tdelta = now.strptime(str(current_time), FMT)
					current_wallet_amt = 0
					if(True):#tdelta.days>0):
						vehicle_type = "Private" 
                        #getVehicleType(number_plate)
						if(vehicle_type == "Bus"):
							print("It was a public vehicle so no amount has been deducted")
							print("The gate will open")

							# subprocess.check_call(["python3", "testing_motor5.py"])
						else:	
							if(vehicle_type == "Car"or vehicle_type == "Bike" or vehicle_type == "Jeep"):
								# current_wallet_amt = getWalletAmount(number_plate)

								# userdata =firebase.get(b, 'userinfo')
								# userinfoid=[]
								# for userinfo in userdata:
								# 	userinfoid.append(userinfo)

								currentUserInfo1 = firebase.get(b+'/userinfo', userinfoid[-1])
								current_wallet_amt = float(currentUserInfo1['amount'])

								if(current_wallet_amt >= 200):
									balance=float(currentUserInfo1['amount'])-200								
									result = firebase.put(b+'/userinfo/'+userinfoid[-1],'amount',str(balance))
									print("Amount has been deducted")
									print("The gate will open")
								else:
									print("You dont have sufficinet amount")
									print("The gate will not be opened")

							

								break
							if(vehicle_type == "Lorry"):
								currentUserInfo1 = firebase.get(b+'/userinfo', userinfoid[-1])
								current_wallet_amt = float(currentUserInfo1['amount'])

								# current_wallet_amt = getWalletAmount(number_plate)
								if(current_wallet_amt >= 500):		

									balance=float(currentUserInfo1['amount'])-500								
									result = firebase.put(b+'/userinfo/'+userinfoid[-1],'amount',str(balance))										
								else:
									print("You dont have sufficient balance, Please Recharge")
									print("The gate will not open")							
					else:
						## OPEN THE GATE
						print("The gate will open")
						# subprocess.check_call(["python3", "testing_motor5.py"])
						time.sleep(15)

				else:
					## DONOT OPEN THE GATE
					print("The vehicle doesnot exists")
					print("The gate will not open")
			


#on check place of tollgate and number,    payment amount deducted
				

