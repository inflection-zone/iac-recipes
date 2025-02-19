# def lambda_handler(event, context):
#     action = event.get("action")

#     if action not in ["start", "stop"]:
#         print("Invalid action. Use 'start' or 'stop'.")
#         return {"message": "Invalid action. Use 'start' or 'stop'."}

#     print("Hello World")

import boto3
import json

# Replace with your EC2 instance IDs
INSTANCE_IDS = [""]

ec2 = boto3.client("ec2")

def start_ec2_instance():
    response = ec2.start_instances(InstanceIds=INSTANCE_IDS)
    print(f"Starting instances: {INSTANCE_IDS}")
    return {
        "statusCode": 200,
        "body": json.dumps({"message": f"Started instances: {INSTANCE_IDS}"})
    }

def stop_ec2_instance():
    response = ec2.stop_instances(InstanceIds=INSTANCE_IDS)
    print(f"Stopping instances: {INSTANCE_IDS}")
    return {
        "statusCode": 200,
        "body": json.dumps({"message": f"Stopped instances: {INSTANCE_IDS}"})
    }

def lambda_handler(event, context):
    try:
        action = event.get("action", "").lower()

        if action == "start":
            return start_ec2_instance()
        
        elif action == "stop":
            return stop_ec2_instance()

        else:
            print("Invalid action received. Expected 'start' or 'stop'.")
            return {
                "statusCode": 400,
                "body": json.dumps({"error": "Invalid action. Expected 'start' or 'stop'."})
            }

    except Exception as e:
        print(f"Error processing request: {str(e)}")
        return {
            "statusCode": 500,
            "body": json.dumps({"error": str(e)})
        }
