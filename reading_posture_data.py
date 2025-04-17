import pandas as pd

# Load the data
posture_data = pd.read_csv('/Users/noahm/Library/Containers/com.example.PostureProject/Data/Documents/posture_data copy.csv')

# Define function to convert 'good'/'bad' to 1/0
posture_data = posture_data.drop(columns=['Shoulder Tilt'])

#highlight everything then run
def check_posture(row):
  if (abs(row['Head Tilt'] - 180) <= 8) and (45 <= row['Head Lean'] <= 48) and (-87 >= row['Head Rotation'] >= -93):
    return True
  else:
    return False

#Create the new column Posture
posture_data['Posture'] = posture_data.apply(check_posture, axis=1)

# Save the updated CSV
posture_data.to_csv('/Users/noahm/Library/Containers/com.example.PostureProject/Data/Documents/posture_data copy.csv', index=False)
