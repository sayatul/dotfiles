import requests
import argparse
import os

# https://github.com/RayBB/node-ticktick-api

project = ""

parser = argparse.ArgumentParser()
parser.add_argument("-p", "--project", help="Project ID")
parser.add_argument("-t", "--task", help="Task title")
args = parser.parse_args()

s = requests.session()

email = os.environ['email']
password = os.environ['password']

project = args.project

headers = {
    'Content-type': 'application/json',
    'Origin': 'https://ticktick.com',
}

headers2 = {
    'Content-type': 'application/json',
    'Origin': 'https://ticktick.com',
}

data = '{"username":"' + email + '", "password":"' + password + '"}'
data2 = '{"projectId":"' + str(project) + '", "sortOrder":1, "title":"' + args.task + '"}'

s.post('https://ticktick.com/api/v2/user/signon?wc=true&remember=true', headers=headers, data=data)
response2 = s.post('https://ticktick.com/api/v2/task', headers=headers2, data=data2)
