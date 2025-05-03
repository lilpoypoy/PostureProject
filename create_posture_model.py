import pandas as pd
from sklearn.tree import DecisionTreeRegressor
from sklearn.model_selection import train_test_split
from sklearn.metrics import mean_absolute_error

#training the model
posture_data_filepath = '/Users/noahm/Library/Containers/com.example.PostureProject/Data/Documents/posture_data copy.csv'


posture_data = pd.read_csv(posture_data_filepath)

y = posture_data.Posture

posture_features = ['Head Tilt', 'Head Lean', 'Head Rotation']

X = posture_data[posture_features]

train_X, val_X, train_y, val_y = train_test_split(X, y, random_state=0)

posture_model = DecisionTreeRegressor()
posture_model.fit(train_X, train_y)

val_predictions = posture_model.predict(val_X)
print(mean_absolute_error(val_y, val_predictions))

print(val_X)
print(val_predictions)


#testing the model
posture_test = pd.read_csv('/Users/noahm/Library/Containers/com.example.PostureProject/Data/Documents/posture_data.csv')
posture_test.drop(columns='Shoulder Tilt')
new_features = ['Head Tilt', 'Head Lean', 'Head Rotation']
new_test = posture_test[new_features]

posture_test['Posture'] = posture_model.predict(new_test)

posture_test.head(15)

posture_test[posture_test['Posture'] == 1.0]

#save model as coreml model
import coremltools as ct

coreml_model = ct.converters.sklearn.convert(posture_model, ["Head Tilt", "Head Lean", "Head Rotation"], "Posture")
coreml_model.save("posture.mlmodel")

