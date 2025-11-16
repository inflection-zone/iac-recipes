import boto3
import json
import os

EKS_CLUSTER_NAME = os.environ.get("CLUSTER_NAME", "")
NODEGROUP_NAME = os.environ.get("NODEGROUP_NAME", "")

eks = boto3.client("eks")

def get_action(event):
    try:
        for record in event["Records"]:
            sns_message = record["Sns"]["Message"]  # Message is a **string**, not JSON
            try:
                # Convert SNS message string to JSON (if it's a JSON string)
                message_json = json.loads(sns_message)
            except json.JSONDecodeError:
                message_json = {"raw_message": sns_message}

            action = message_json.get("action", "unknown")  # Extract action
            return action

        return {
            "statusCode": 200,
            "body": json.dumps("SNS Message Processed Successfully!")
        }

    except Exception as e:
        print(f"Error: {str(e)}")
        return {
            "statusCode": 500,
            "body": json.dumps({"error": str(e)})
        }

def update_nodegroup_size(desired_size):
    try:
        eks.update_nodegroup_config(
            clusterName=EKS_CLUSTER_NAME,
            nodegroupName=NODEGROUP_NAME,
            scalingConfig={
                'minSize': 0,
                'maxSize': 1,
                'desiredSize': desired_size
            }
        )
        print(f"Scaling node group '{NODEGROUP_NAME}' to desiredSize = {desired_size}")
    except Exception as e:
        print(f"Error scaling node group: {str(e)}")

def start_nodegroup():
    update_nodegroup_size(1)

def stop_nodegroup():
    update_nodegroup_size(0)

def lambda_handler(event, context):
    if not EKS_CLUSTER_NAME or not NODEGROUP_NAME:
        print("CLUSTER_NAME or NODEGROUP_NAME is missing!")
        return
    
    action = get_action(event)
    print(f"Received action: {action}")

    if action not in ["start", "stop"]:
        print("Invalid action. Use 'start' or 'stop'.")
        return {"message": "Invalid action. Use 'start' or 'stop'."}

    if action == "start":
        start_nodegroup()
    elif action == "stop":
        stop_nodegroup()
    else:
        print(f"Invalid action '{action}' received. Expected 'start' or 'stop'.")
