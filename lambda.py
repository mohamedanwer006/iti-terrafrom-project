# use lambda function to send email when the state file change in s3
import json
import boto3
from botocore.exceptions import ClientError


def lambda_handler(event, context):
    print("---------event------------")
    print(event)

    client = boto3.client('sesv2')
    # send email using ses

    print("------------- start sending email-----------")

    try:
        response = client.send_email(
            FromEmailAddress='mohamedanwer006.dev@gmail.com',
            Destination={
                'ToAddresses': [
                    'mohamedanwer006@gmail.com',
                ],
            },
            Content={
                'Simple': {
                    'Subject': {
                        'Data': 'iti-terraform-state-change',
                        'Charset': 'UTF-8'
                    },
                    'Body': {
                        'Text': {
                            'Data': 'iti-terraform-state file changed ',
                            'Charset': 'UTF-8'
                        },
                    }
                },

            },
        )

        print("---------response------------")
        print(response)

    except ClientError as e:
        print(e.response['Error']['Message'])

    return {
        'statusCode': 200,
        'body': json.dumps('upload done')
    }
