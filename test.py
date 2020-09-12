from firebase import firebase
import flask
import re
from flask import request, jsonify
import json

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

app = flask.Flask(__name__)
app.config["DEBUG"] = True

pytesseract.pytesseract.tesseract_cmd = r'C:\Program Files\Tesseract-OCR\tesseract.exe'
firebase = firebase.FirebaseApplication('https://tollgateapp-febd0.firebaseio.com/', None)

amt = []
phNo = []
vhNo = []
vhType = []
userNo = 9999
userId = []
userInfoId = []


def fetchUsersDetails():	
	# numbPlate = 'KL 14 A 2222'
	global userNo	
	global amt 
	global phNo
	global vhNo
	global vhType 
	global userId
	global userInfoId
	userNo = 9999
	amt = []
	phNo = []
	vhNo = []
	vhType = []	
	userId = []
	userInfoId = []

	a = firebase.get('/','')
	b = []
	for i in a:
		b.append(i)
		userId.append(i)
	# print(b)

	# print(a[b[1]])
	c = []
	for j in range (0,len(a)):
		for k in a[b[j]]['userinfo']:
			c.append(k)
			userInfoId.append(k)
	# print(c)

	d = []
	for l in range(0,len(b)):
		m=a[b[l]]['userinfo']
		amt.append(m[c[l]]['amount'])
		phNo.append(m[c[l]]['phoneNumber'])
		vhNo.append(m[c[l]]['vehicleNumber'])
		vhType.append(m[c[l]]['vehicleType'])
	# print(a[b[1]]['userinfo'][l])
	# print(d)
	# print(amt)
	# print(phNo)
	# print(vhNo)
	# print(vhType)
	print("data fetched")

def verifyNumPlate(numbPlate):	
	for y in range (0,len(vhNo)):
		if(numbPlate==vhNo[y]):
			print("nemberplate match found")
			global userNo
			userNo = y
			return(True)
	if (userNo==9999):
		print("nemberplate match not found")
		return (False)



def check2():#idu
	
	imPath = "images/computer-vision.jpg"
	cap = cv2.VideoCapture(0)    
	config = ('-l eng --oem 1 --psm 3')
	number_plate = ''
	print()
	# text1 = input("number plate")
	while True:
		ret, img = cap.read()
		img = cv2.resize(img,(400,400))
		print(img.shape)
		_,img=cv2.threshold(img,165,180,cv2.THRESH_BINARY)
		# Read the number plate
		text = pytesseract.image_to_string(img, config=config)
		print(text)
		
		# text1 = "KA 19 B 2332" 
		# print(len(text))

		gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)  # convert to grey scale
		# gray = cv2.bilateralFilter(gray, 11, 17, 17)  # Blur to reduce noise
		edged = cv2.Canny(gray, 30, 200)  # Perform Edge detection
		# find contours in the edged image, keep only the largest
		# ones, and initialize our screen contour
		cnts = cv2.findContours(edged.copy(), cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)
		cnts = imutils.grab_contours(cnts)
		cnts = sorted(cnts, key=cv2.contourArea, reverse=True)[:10]
		screenCnt = None

		# loop over our contours
		for c in cnts:
			# approximate the contour
			peri = cv2.arcLength(c, True)
			approx = cv2.approxPolyDP(c, 0.018 * peri, True)

			# if our approximated contour has four points, then
			# we can assume that we have found our screen
			if len(approx) == 4:
				screenCnt = approx
				break

		if screenCnt is None:
			detected = 0
			print("No contour detected")
		else:
			detected = 1

		if detected == 1:
			cv2.drawContours(img, [screenCnt], -1, (0, 255, 0), 3)

		cv2.imshow('TOLL2', edged)
		cv2.imshow('TOLL', img)
		s=''
		# if()verifyNumPlate(text)
		if(re.match('^KA[ 0-9]',text)):
			if(verifyNumPlate(text)):
				text=text.split('\n')
				print(text[0])
				cv2.destroyAllWindows()
				break

		if (cv2.waitKey(25) & 0xFF == ord('q')):#((re.match('^KA[ 0-9]',text))):
			text=text.split('\n')
			print(text[0])
			cv2.destroyAllWindows()
			break

		#working code.....
		# if (cv2.waitKey(25) & 0xFF == ord('q')) or ((re.match('^KA[ 0-9]',text))):
		# 	text=text.split('\n')
		# 	print(text[0])
		# 	cv2.destroyAllWindows()
		# 	break
		#till here.....
		# if text.startswith("KA") and len(text)==9:
		# 	cv2.destroyAllWindows()
		# 	break


	print("numberplate detected")
	#return "jij"
	return text[0]




def updateAmount():
	global userNo
	global vhType
	global amt
	global userId
	global userInfoId
	b='/'+userId[userNo]+'/'+'/userinfo/'+userInfoId[userNo]
	if(userNo!=9999):
		print(userNo,vhType[userNo],vhNo[userNo],amt[userNo])
		print("The vehicle exists") 
		current_wallet_amt = 0
		if(True):#tdelta.days>0):
			# vehicle_type = "Car" 
			if(vhType[userNo] == "Bus"):
				print("It was a public vehicle so no amount has been deducted")
				print("The gate will open")
				return "Public transport - no fee"

				# subprocess.check_call(["python3", "testing_motor5.py"])
			else:	
				if(vhType[userNo] == "Car"or vhType[userNo] == "Bike" or vhType[userNo] == "Jeep"):

					# currentUserInfo1 = firebase.get(b+'/userinfo', userinfoid[-1])
					# current_wallet_amt = float(currentUserInfo1['amount'])


					if(float(amt[userNo]) >= 200):
						balance=float(amt[userNo])-200		
						result = firebase.put(b,'amount',str(balance))
						print("Amount has been deducted")
						print("The gate will open")
						return "Amount deducted - 200. \n Balance - "+str(balance)
						
					else:
						print("You dont have sufficinet amount")
						print("The gate will not be opened")
						return "Insufficient Account Balance"
					# break
				if(vhType[userNo] == "Lorry"):
					# currentUserInfo1 = firebase.get(b+'/userinfo', userinfoid[-1])
					# current_wallet_amt = float(currentUserInfo1['amount'])

					# current_wallet_amt = getWalletAmount(number_plate)
					if(float(amt[userNo]) >= 500):		

						balance=float(amt[userNo])-500			
						result = firebase.put(b,'amount',str(balance))
						return "Amount deducted - 500. \n Balance - "+str(balance)									
					else:
						print("You dont have sufficient balance, Please Recharge")
						print("The gate will not open")		
						return "Insufficient Account Balance"					
		else:
			## OPEN THE GATE
			print("The gate will open")
			# subprocess.check_call(["python3", "testing_motor5.py"])
			# time.sleep(15)
			return "Public transport - no fee"
	else:
		## DONOT OPEN THE GATE
		print("The vehicle doesnot exists")
		print("The gate will not open")
		return "Vehicle has not been registered"

@app.route('/check',methods=['GET'])
def check():
	fetchUsersDetails()
	check2()
	return (updateAmount())

app.run(host='0.0.0.0')

# fetchUsersDetails()
# check2()
# # verifyNumPlate('KA 19 V 1999')
# print(updateAmount())

