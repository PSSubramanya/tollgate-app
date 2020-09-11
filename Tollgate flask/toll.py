from firebase import firebase
# firebase = firebase.FirebaseApplication('https://tollgate-3ef1e.firebaseio.com/', None)
# data = {'name':'rohan','email':'roh@gmail.com'}
# firebase.put('/tollgate-3ef1e/Customer/-M8C2pj_UfGZMeFxhyFM','name','bob')

# result =firebase.get('/tollgate-3ef1e/Customer', '')
# # result = firebase.post('/tollgate-3ef1e/Customer', data) 
# print(result)
# # print (result)

firebase = firebase.FirebaseApplication('https://tollgateapp-febd0.firebaseio.com/', None)
# data = {'name':'rohan','email':'roh@gmail.com'}
result =firebase.get('/', '')
# print(result)
userid=[]
for user in result:
    userid.append(user)
# print(userid)
result =firebase.get('/', userid[0])
# print(result)
a='/'+userid[0]+'/'
traveldata =firebase.get(a, 'travelinfo')
userdata =firebase.get(a, 'userinfo')
userinfoid=[]
travelinfoid=[]
for userinfo in userdata:
    userinfoid.append(userinfo)
for travelinifo in traveldata:
    travelinfoid.append(travelinifo)
print(userinfoid)
print(travelinfoid)


currentTravelInfo =firebase.get(a+'/travelinfo', travelinfoid[-1])
currentUserInfo =firebase.get(a+'/userinfo', userinfoid[-1])
print(currentTravelInfo)
print(currentUserInfo)
userFields=['amount', 'arrival', 'destination', 'starting']
travelFields = ['name','phoneNumber','vehicleNumber','vehicleType']
print(currentUserInfo.get("name"))

new_travel = {'arrival': 'Down', 'destination': 'Udupi', 'starting': 'Karwar'}
# result = firebase.post(a+'/travelinfo',new_travel)
# print (result)

# result = firebase.post('/users', new_user, {'print': 'silent'}, {'X_FANCY_HEADER': 'VERY FANCY'})
# print (result) 
new_user = {'amount': '5000', 'name': 'User1', 'phoneNumber': '9898898999', 'vehicleNumber': 'KA 19 B 2332', 'vehicleType': 'bus'}
# result = firebase.post(a+'/userinfo',new_user)

result = firebase.put(a+'/travelinfo/-M8trMRZupVHNf_2MFWN','starting','usa')

print(userinfoid[-1])

currentUserInfo1 = firebase.get(a+'/userinfo', userinfoid[-1])
balance=float(currentUserInfo1['amount'])-20


result = firebase.put(a+'/userinfo/-M8qbbM_KOHkZPnHqurE','amount',str(balance))
print (result)