import boto3
import os
import sys
import uuid
from urllib.parse import unquote_plus
from PIL import Image
import PIL.Image

s3_client = boto3.client('s3')

def resize_image(image_path, resized_path):
  with Image.open(image_path) as image:
      image.thumbnail(tuple(x / 2 for x in image.size))
      image.save(resized_path)

def lambda_handler(event, context):
  print(event)
  for record in event['Records']:
      bucket = record['s3']['bucket']['name']
      print(bucket)
      key = unquote_plus(record['s3']['object']['key'])
      print(key)
      tmpkey = key.replace('/', '')
      print(tmpkey)
      download_path = '/tmp/{}'.format(tmpkey)
      print(download_path)
      upload_path = '/tmp/resized-{}'.format(tmpkey)
      print(upload_path)
      s3_client.download_file(bucket, key, download_path)
      resize_image(download_path, upload_path)
      s3_client.upload_file(upload_path, '{}-resized'.format(bucket), key)
  fp = open('/tmp/success.text','w')
  s3_client.upload_file('/tmp/success.text','{}-resized'.format(bucket), 'success.text')
            
