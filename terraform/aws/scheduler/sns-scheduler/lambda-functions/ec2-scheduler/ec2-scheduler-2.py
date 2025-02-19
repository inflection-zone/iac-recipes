import json

def get_action(event):
    try:
        print(f"Received event: {json.dumps(event)}")  # Debugging: Print full event

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

def lambda_handler(event, context):
    action = get_action(event)

    if action not in ["start", "stop"]:
        print("From ec2-scheduler-2: Invalid action. Use 'start' or 'stop'.")
        return {"message": "Invalid action. Use 'start' or 'stop'."}

    print("Hello World from ec2-scheduler-2")
