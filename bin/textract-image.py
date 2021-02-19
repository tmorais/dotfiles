import boto3
from sys import argv
import os.path

# boto3 client
client = boto3.client('textract')

def is_file(file_name):
    if not os.path.isfile(file_name):
        raise ValueError("You must provide a valid file_name as parameter")

if __name__=="__main__":
    file_name = None
    
    try:
        file_name = argv[1]
        print("file_name: ",file_name)
        is_file(file_name)
    except Exception as e:
        print("You must provide a valid file_name as parameter")
        raise

    # Read image
    with open(file_name, 'rb') as document:
        img = bytearray(document.read())

    # Call Amazon Textract
    response = client.detect_document_text(
        Document={'Bytes': img}
    )

    # Print detected text
    for item in response["Blocks"]:
        if item["BlockType"] == "LINE":
            print ('\033[94m' +  item["Text"] + '\033[0m')

