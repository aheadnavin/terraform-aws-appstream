"""Check user expiry for AppStream."""
import boto3
import json
import os
import time
import datetime
from mklog import WriteLog  # [internal]


def user_age(
    created_date: datetime.date
) -> datetime.date:
    """
    Calculate user age in the AppStream User Pool.

    return datetime.date
    """
    # Calculate user's created date value.
    created = datetime.date(
        created_date.year,
        created_date.month,
        created_date.day
    )

    return created


def lambda_handler(event, context):
    """
    Check AppStream User Pool user expiry.

    return dict
    """
    # Start logging.
    logger = WriteLog({})
    timestamp = time.strftime('%Y-%m-%d:%H-%M-%S')
    logger.log('request_id', context.aws_request_id)
    logger.log('exec_timestamp', timestamp)

    # Create AppStream client.
    appstream = boto3.client('appstream')

    # Calculate today's date value.
    today = datetime.date(
        datetime.datetime.now().year,
        datetime.datetime.now().month,
        datetime.datetime.now().day
    )

    # Check for expired users and delete from User Pool.
    expired_users = list()
    paginator = appstream.get_paginator('describe_users')
    response_iterator = paginator.paginate(
        AuthenticationType=os.environ['AUTH_TYPE']
    )
    for page in response_iterator:
        for user in page['Users']:

            # Calculate user's age in User Pool.
            age = today - user_age(user['CreatedTime'])

            # Delete user if age is older than expiry days.
            if (
                int(os.environ['EXPIRED_USER_AGE']) >= 1
                and age.days >= int(os.environ['EXPIRED_USER_AGE'])
            ):
                response = appstream.delete_user(
                    UserName=user['UserName'],
                    AuthenticationType=os.environ['AUTH_TYPE']
                )

                # Create log of deleted users.
                logger.log(user['UserName'], f'Deleted after {age} days')

                # Create status if failed to delete expired users.
                if not response:
                    status_code = 500
                    status = 'Failed to delete expired users'
                    raise Exception(status)

    # Create return.
    status_code = 200
    status = 'Success'

    # Return response.
    logger.log('status_code', status_code)
    logger.log('status', status)
    print(json.dumps(logger.text, default=str))
    return {
        'statusCode': status_code,
        'headers': {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': os.environ['CORS']
        },
        'body': json.dumps({'message': status}, default=str)
    }
